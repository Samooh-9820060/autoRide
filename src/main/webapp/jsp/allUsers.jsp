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
    <script type = "text/javascript">
        function disableBackButton() {
            window.history.forward();
        }
        //setTimeout("disableBackButton()", 0);
    </script>
    <title>All Users</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/myBookings.css">
    <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  </head>
  <body>
      <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("../jsp/adminSignIn.jsp");
        }
      %>
      <section style="margin-top: 60px;">


      <div class="container">
        <div class="row">
          <div class="mbr-form form-with-styler">
              <a onclick="goToHome()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; background-color: #ff8080;">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section" style="color: #FF6666">All Users</h2>
            </div>
        </div>
        <div id="changePassDiv" style="margin-bottom: 40px; margin-left: 780px" hidden>
            <label id="changePassAcc">PA1</label>
            <input id="changePassValue" type="password" >
            <a onclick="changePass()" href="#" class="btn btn-secondary display-1" style="background-color: #ff8080;" >Change</a>
        </div>
          
        <div style="margin-left: 0px; margin-bottom: 20px" class="mbr-form form-with-styler">
            <label>Filter By</label>
            <select style="border: none; margin-left: 10px;" id="type">
                <option value="Passenger">Passenger</option>
                <option value="Driver">Driver</option>
            </select>
            <a onclick="loadUser()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
            <a href="./jsp/createDriver.jsp" class="btn btn-secondary display-1" style="margin-left: 710px; margin-bottom: 4px; background-color: #ff8080;">Create Driver</a>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-wrap">
              <table id="myBookings" class="table table-striped">
                  <thead>
                    <tr>
                        <th style="color: #FF6666">Type</th>
                        <th style="color: #FF6666">User_ID</th>
                        <th style="color: #FF6666">First_Name</th>
                        <th style="color: #FF6666">Last_Name</th>
                        <th style="color: #FF6666">Email</th>
                        <th style="color: #FF6666">Phone</th>
                        <th style="color: #FF6666">ID_Number</th>
                        <th style="color: #FF6666">Address</th>
                        <th style="color: #FF6666">Postal_Code</th>
                        <th style="color: #FF6666">District</th>
                        <th style="color: #FF6666">Island</th>
                        <th style="color: #FF6666">EC_Name</th>
                        <th style="color: #FF6666">EC_Number</th>
                        <th style="color: #FF6666">Vehicle</th>
                        <th style="color: #FF6666">Vehicle_Reg</th>
                        <th style="color: #FF6666">License_No</th>
                        <th style="color: #FF6666">Edit</th>
                        <th style="color: #FF6666">Password</th>
                        <th style="color: #FF6666">Delete</th>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach var="data" items="${requestScope.allUsers}">
                    <tr style="align-content: center">
                        <td><c:out value="${data.userType}" /></td>
                        <td><c:out value="${data.userID}" /></td>
                        <td><c:out value="${data.firstName}" /></td>
                        <td><c:out value="${data.lastName}" /></td>
                        <td><c:out value="${data.email}" /></td>
                        <td><c:out value="${data.phoneNumber}" /></td>
                        <td><c:out value="${data.IDNumber}" /></td>
                        <td><c:out value="${data.address}" /></td>
                        <td><c:out value="${data.postalCode}" /></td>
                        <td><c:out value="${data.district}" /></td>
                        <td><c:out value="${data.island}" /></td>
                        <td><c:out value="${data.emergencyContactName}" /></td>
                        <td><c:out value="${data.emergencyContactNo}" /></td>
                        <td><c:out value="${data.vehicleType}" /></td>
                        <td><c:out value="${data.vehicleRegNo}" /></td>
                        <td><c:out value="${data.licenseNo}" /></td>
                        <td>
                            <a onclick="editUser('${data.userID}','${data.userType}')"
                               href="#"
                               class="btn btn-warning">
                               <c:out value="Edit" /> 
                            </a>
                        </td>
                        <td>
                            <a onclick="changePassField('${data.userID}')"
                               href="#"
                               class="btn btn-info">
                               <c:out value="Change Password" /> 
                            </a>
                        </td>
                        <td><a
                                onclick="deleteUser('${data.userID}')"
                                href="#"
                                class="<c:choose>
                                            <c:when test="${data.userType=='Passenger'}">
                                                btn btn-danger
                                            </c:when>
                                            <c:when test="${data.userType=='Driver'}">
                                                btn btn-danger
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
        <input type="text" id="deleteUserID" name="deleteUserID" value="">
        <input type="text" id="type" name="type" value="admin">
    </form>
    <form id="editUser" method="GET" action="./editUser" hidden>
        <input type="text" id="editUserID" name="editUserID" value="">
        <input type="text" id="editUserType" name="editUserType" value="">
    </form>
    <form id="changePassword" method="POST" action="./editPassword" hidden>
        <input type="text" id="editPasswordID" name="editPasswordID" value="">
        <input type="text" id="editPasswordValue" name="editPasswordValue" value="">
    </form>    
    
  </body>
  <script>
      function deleteUser(userID) {
          document.getElementById("deleteUserID").value = userID;
          var form = document.getElementById("deleteUser");
          form.submit();
      }
      
      function changePass(){
          document.getElementById("editPasswordID").value = document.getElementById("changePassAcc").innerHTML;
          document.getElementById("editPasswordValue").value = document.getElementById("changePassValue").value;
          var form = document.getElementById("changePassword");
          form.submit();
      }
      
      function changePassField(userID){
          document.getElementById("changePassAcc").innerHTML = userID;
          document.getElementById("changePassDiv").hidden = false;
      }
      
      function editUser(userID, userType) {
          document.getElementById("editUserID").value = userID;
          document.getElementById("editUserType").value = userType;
          var form = document.getElementById("editUser");
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
      let type = getCookie("type");
      if (type!=="admin"){
          document.forms[0].action="./logOut";
          document.forms[0].submit();
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

