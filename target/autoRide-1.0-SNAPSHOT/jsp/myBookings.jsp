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
              <a href="./jsp/homePage.jsp" class="btn btn-secondary display-1" style="margin-left: 15px; background-color: #ff8080;">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section">My Bookings</h2>
          </div>
        </div>
        <div style="margin-left: 0px; margin-bottom: 20px" class="mbr-form form-with-styler">
            <label>Start Date</label>
            <input type="date" id="startDate">
            <label style="margin-left: 10px">End Date</label>
            <input type="date" id="endDate">
            <a onclick="loadDate()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
            <label style="margin-left: 25px">Filter By</label>
            <select style="border: none; margin-left: 10px;" id="filterBy">
                <option value="Vehicle">Vehicle</option>
                <option value="Status">Status</option>
                <option value="Driver">Driver Mail</option>
            </select>
            <input size="25px;" style="margin-left: 0px;" id="filterMailInput">
            <a onclick="loadFilter()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
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
    <form id="filterDate" method="GET" action="./filterBookingsDatePassenger" hidden>
        <input type="text" id="startDateField" name="startDateField" value="">
        <input type="text" id="endDateField" name="endDateField" value="">
    </form>
    <form id="filterUser" method="GET" action="./filterPassengerBookings" hidden>
        <input type="text" id="filterType" name="filterType" value="">
        <input type="text" id="filterValue" name="filterValue" value="">
    </form>
  </body>
  <script>
      Date.prototype.toDateInputValue = (function() {
            var local = new Date(this);
            local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
            return local.toJSON().slice(0,10);
      });

      
      function get(name){
          if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search)){
             return decodeURIComponent(name[1]);              
          }
      }
      if (get("startDateField")===undefined){
            document.getElementById('startDate').value = new Date().toDateInputValue();
            document.getElementById('endDate').value = new Date().toDateInputValue();
      } else {
            document.getElementById('startDate').value = get("startDateField");
            document.getElementById('endDate').value = get("endDateField");          
      }
      
      if (get("filterValue")===undefined){
          
      } else {
        document.getElementById("filterMailInput").value = get("filterValue");     
        document.getElementById("filterBy").value = get("filterType");
      }

      
      function goToInvoice(invoiceNumber){
            document.cookie = "invoiceNo="+invoiceNumber;
            window.location.href = './showInvoice';
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
      function loadDate(){
          document.getElementById("startDateField").value = document.getElementById("startDate").value;
          document.getElementById("endDateField").value = document.getElementById("endDate").value;
          var form = document.getElementById("filterDate");
          form.submit();
      }
      function loadFilter(){
          document.getElementById("filterType").value = document.getElementById("filterBy").value;
          document.getElementById("filterValue").value = document.getElementById("filterMailInput").value;
          var form = document.getElementById("filterUser");
          form.submit();
      }
  </script>
</html>

