<%-- 
    Document   : queries
    Created on : Sep 16, 2022, 7:11:27 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
  <head>
    <title>Queries</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/queries.css">
    <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  </head>
  <body>
        <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("adminSignIn.jsp");
        }
        %>
    <section class="ftco-section">
      <div class="container">
          <div class="row" style="padding-top: 80px;">
          <div class="mbr-form form-with-styler">
              <a onclick="goToHome()" href="#" class="btn btn-secondary display-1" style="background-color: #ff8080">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section">Queries</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-wrap">
              <table id="myBookings" class="table table-striped">
                  <thead>
                    <tr>
                        <th>Query_No</th>
                        <th>Type</th>
                        <th>Details</th>
                        <th>Queried_By</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach var="data" items="${requestScope.queriesList}">
                    <tr>
                        <td><c:out value="${data.queryNo}" /></td>
                        <td><c:out value="${data.type}" /></td>
                        <td><c:out value="${data.details}" /></td>
                        <td><c:out value="${data.queriedBy}" /></td>
                        <td><c:out value="${data.date}" /></td>
                        <td><c:out value="${data.time}" /></td>
                        <td><a
                                onclick="changeStatus(${data.queryNo})"
                                href="#"
                               class="<c:choose>
                                            <c:when test="${data.status=='Not Fixed'}">
                                                btn btn-danger
                                            </c:when>
                                            <c:when test="${data.status=='Fixed'}">
                                                btn btn-success
                                            </c:when>
                                            <c:otherwise>
                                                btn btn-warning
                                            </c:otherwise>
                                      </c:choose>"
                                            >
                               <c:out value="${data.status}" />
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
    <form id="changeStatus" action="changeQueryStatus" hidden>
        <input type="text" id="submitQueryNo" name="queryNo" value="">
    </form>
    <form id="goHome" method="POST" action="./adminLogIn" hidden>
        <input type="text" id="adminUserNameField" name="adminUserNameField" value="">
        <input type="text" id="alreadyCreated" name="alreadyCreated" value="">
    </form>
  </body>
  <script>
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
            if (getCookie("type")!=="admin"){
                window.location.href = "../jsp/adminSignIn.jsp";
            }
      function changeStatus(queryNo){
            document.getElementById("submitQueryNo").value=queryNo;
            var form = document.getElementById("changeStatus");
            form.submit();
      }
      function goToHome(){
          var status = getCookie("status");
          document.getElementById("adminUserNameField").value=status;
          document.getElementById("alreadyCreated").value="1";
          var form = document.getElementById("goHome");
          form.submit();
      }
  </script>
</html>

