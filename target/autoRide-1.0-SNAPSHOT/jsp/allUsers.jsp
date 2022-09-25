<%-- 
    Document   : allUsers
    Created on : Sep 16, 2022, 7:11:27 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        
<!doctype html>
<html lang="en">
  <head>
    <title>All Users</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/myBookings.css">
    <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  </head>
  <body>
      <section style="margin-top: 60px;">


      <div class="container">
        <div class="row">
          <div class="mbr-form form-with-styler">
              <a onclick="goToHome()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; background-color: #ff8080;">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section">All Users</h2>
          </div>
        </div>
        <div style="margin-left: 0px; margin-bottom: 20px" class="mbr-form form-with-styler">
            <label>Filter By</label>
            <select style="border: none; margin-left: 10px;" id="type">
                <option value="Passenger">Passenger</option>
                <option value="Driver">Driver</option>
            </select>
            <a onclick="loadUser()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-wrap">
              <table id="myBookings" class="table table-striped">
                  <thead>
                    <tr>
                        <th>Type</th>
                        <th>First_Name</th>
                        <th>Last_Name</th>
                        <th>Email</th>
                        <th>Telephone</th>
                        <th>Vehicle</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach var="data" items="${requestScope.allUsers}">
                    <tr>
                        <td><c:out value="${data.userType}" /></td>
                        <td><c:out value="${data.firstName}" /></td>
                        <td><c:out value="${data.lastName}" /></td>
                        <td><c:out value="${data.eMail}" /></td>
                        <td><c:out value="${data.telephone}" /></td>
                        <td><c:out value="${data.vehicleType}" /></td>
                        <td><a
                                onclick="deleteUser('${data.eMail}')"
                                href="#"
                                class="<c:choose>
                                            <c:when test="${data.userType=='Passenger'}">
                                                btn btn-danger
                                            </c:when>
                                            <c:when test="${data.userType=='Driver'}">
                                                btn btn-warning
                                            </c:when>
                                            <c:otherwise>
                                                btn btn-success
                                            </c:otherwise>
                                      </c:choose>"
                                            >
                               <c:out value="Delete" />
                            </a>
                        </td>
                    </tr>
                   </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </section>
    <script src="assets/js/jquery.min.js">
    </script>
    <script src="assets/js/popper.js">
    </script>
    <script src="assets/js/bootstrap.min.js">
    </script>
    <script src="assets/js/main.js">
    </script>
    <form id="goHome" method="POST" action="./adminLogIn" hidden>
        <input type="text" id="adminUserNameField" name="adminUserNameField" value="">
        <input type="text" id="alreadyCreated" name="alreadyCreated" value="">
    </form>
    <form id="filterUser" method="GET" action="./filterUsers" hidden>
        <input type="text" id="filterType" name="filterType" value="">
    </form>
    <form id="deleteUser" method="GET" action="./deleteUser" hidden>
        <input type="text" id="deleteMail" name="deleteMail" value="">
    </form>
  </body>
  <script>
      function deleteUser(eMail) {
          document.getElementById("deleteMail").value = eMail;
          var form = document.getElementById("deleteUser");
          form.submit();
      }
      function get(name){
          if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search)){
             return decodeURIComponent(name[1]);              
          }
      }
      
      if (get("filterType")===undefined){
          
      } else {
        document.getElementById("type").value = get("filterType");     
      }

      function getCookie(cname) {
        let name = cname + "=";
        let ca = document.cookie.split(';');
        for(let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) === ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) === 0) {
                return c.substring(name.length, c.length);
                }
            }
            return "";
      }
      function goToHome(){
          var status = getCookie("status");
          document.getElementById("adminUserNameField").value=status;
          document.getElementById("alreadyCreated").value="1";
          var form = document.getElementById("goHome");
          form.submit();
      }
      function loadUser(){
          document.getElementById("filterType").value = document.getElementById("type").value;
          var form = document.getElementById("filterUser");
          form.submit();
      }
  </script>
</html>

