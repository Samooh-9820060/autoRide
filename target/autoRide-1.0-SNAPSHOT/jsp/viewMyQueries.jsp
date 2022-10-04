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
            response.sendRedirect("signIn.jsp");
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
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- jstl function to populate table from data source -->
                  <c:forEach var="data" items="${requestScope.queriesList}">
                    <tr>
                        <td><c:out value="${data.queryNo}" /></td>
                        <td><c:out value="${data.type}" /></td>
                        <td><c:out value="${data.details}" /></td>
                        <td><c:out value="${data.date}" /></td>
                        <td><c:out value="${data.time}" /></td>
                        <td><a
                               class="<c:choose>
                                            <c:when test="${data.status=='Not_Fixed'}">
                                                btn btn-warning
                                            </c:when>
                                            <c:when test="${data.status=='Fixed'}">
                                                btn btn-success
                                            </c:when>
                                            <c:otherwise>
                                                btn btn-danger
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
  </body>
  <script>
      function getCookie(cname) {
          //function to get cookie values by name
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
        if (getCookie("type")!==("Passenger"||"Driver")){
            //if user is not passenger or driver go to sign in screen
            window.location.href = "./jsp/signIn.jsp";
        }
      function goToHome(){
          //function to go home
          window.location.href = "./jsp/help.jsp";
      }
  </script>
</html>

