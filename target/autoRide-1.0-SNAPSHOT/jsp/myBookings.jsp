<%-- 
    Document   : myBookings
    Created on : Sep 16, 2022, 7:11:27 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        
<!doctype html>
<html lang="en">
  <head>
    <title>My Bookings</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/myBookings.css">
    <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  </head>
  <body>
    <section class="ftco-section">
      <div class="container">
        <div class="row">
          <div class="mbr-form form-with-styler">
              <a href="./jsp/homePage.jsp" class="btn btn-secondary display-1" style="background-color: red">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section">My Bookings</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-wrap">
              <table id="myBookings" class="table table-striped">
                  <thead>
                    <tr>
                        <th>Invoice#</th>
                        <th>Book_Date</th>
                        <th>Book_Time</th>
                        <th>Order_Date</th>
                        <th>Order_Time</th>
                        <th>Location</th>
                        <th>Destination</th>
                        <th>Vehicle</th>
                        <th>Distance</th>
                        <th>Duration</th>
                        <th>Price</th>
                        <th>Driver</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach var="data" items="${requestScope.myBookingsList}">
                    <tr>
                        <td><c:out value="${data.invoiceNum}" /></td>
                        <td><c:out value="${data.bookDate}" /></td>
                        <td><c:out value="${data.bookTime}" /></td>
                        <td><c:out value="${data.orderDate}" /></td>
                        <td><c:out value="${data.orderTime}" /></td>
                        <td><c:out value="${data.location}" /></td>
                        <td><c:out value="${data.destination}" /></td>
                        <td><c:out value="${data.vehicle}" /></td>
                        <td><c:out value="${data.distance}" /></td>
                        <td><c:out value="${data.duration}" /></td>
                        <td><c:out value="${data.price}" /></td>
                        <td><c:out value="${data.driver}" /></td>
                        <td><a
                                onclick="goToInvoice(${data.invoiceNum})"
                                href="#"
                               class="<c:choose>
                                            <c:when test="${data.status=='Waiting'}">
                                                btn btn-danger
                                            </c:when>
                                            <c:when test="${data.status=='Completed'}">
                                                btn btn-warning
                                            </c:when>
                                            <c:otherwise>
                                                btn btn-success
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
      function goToInvoice(invoiceNumber){
            document.cookie = "invoiceNo="+invoiceNumber;
            window.location.href = './showInvoice';
      }
  </script>
</html>

