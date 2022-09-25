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
    <title>Report</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="./assets/css/myBookings.css">
  </head>
  <script type = "text/javascript">
        function disableBackButton() {
            window.history.forward();
        }
        //setTimeout("disableBackButton()", 0);
  </script>  
  <body>
      <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            //response.sendRedirect("../jsp/adminSignIn.jsp");
        }
      %>
      <section style="margin-top: 60px;">


      <div class="container">
        <div class="row">
          <div class="mbr-form form-with-styler">
              <a onclick="goToHome()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; background-color: #ff8080;">Back</a>
          </div>
          <div class="col-md-10 text-center mb-3">
            <h2 class="heading-section">${date}</h2>
          </div>
        </div>
        <div style="margin-left: 0px; margin-bottom: 20px" class="mbr-form form-with-styler">
            <label>Select Date</label>
            <input type="date" id="selectDate">
            <a onclick="loadDate()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
            
            <a onclick="generateSummaryReport()" href="#" class="btn btn-secondary display-1" style="margin-left: 130px; margin-bottom: 4px; background-color: #ff8080;">Generate Summary</a>
            
            <label style="margin-left: 70px">Driver ID: </label>
            <input size="25px;" style="margin-left: 0px;" id="filterIDInput">
            <a onclick="loadFilter()" href="#" class="btn btn-secondary display-1" style="margin-left: 15px; margin-bottom: 4px; background-color: #ff8080;">Search</a>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-wrap">
              <table id="myBookings" class="table table-striped">
                  <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>Total_Bookings</th>
                        <th>Total_Revenue</th>
                        <th>Total_Distance</th>
                        <th>Total_Time</th>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach var="data" items="${requestScope.reportDetailsList}">
                    <tr>
                        <td><c:out value="${data.driverID}" /></td>
                        <td><c:out value="${data.completedBookings}" /></td>
                        <td><c:out value="${data.revenue}" /></td>
                        <td><c:out value="${data.distance}" /></td>
                        <td><c:out value="${data.duration}" /></td>
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
    <form id="filterDate" method="GET" action="./filterBookingsDateReport" hidden>
        <input type="text" id="selectDateField" name="selectDateField" value="">
    </form>
    <form id="filterUser" method="GET" action="./filterUserReport" hidden>
        <input type="text" id="filterID" name="filterID" value="">
        <input type="text" id="filterDate" name="filterDate" value="${date}">
    </form>
    <form id="summaryReport" method="GET" action="./generateSummaryReport" hidden>
        <input type="text" id="date" name="date" value="${date}">
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
      if (get("selectDateField")===undefined){
            document.getElementById('selectDate').value = new Date().toDateInputValue();
      } else {
            document.getElementById('selectDate').value = get("selectDateField");
      }
      
      if (get("filterID")===undefined){
          
      } else {
        document.getElementById("filterIDInput").value = get("filterID");
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
          document.getElementById("selectDateField").value = document.getElementById("selectDate").value;
          var form = document.getElementById("filterDate");
          form.submit();
      }
      function loadFilter(){
          document.getElementById("filterID").value = document.getElementById("filterIDInput").value;
          var form = document.getElementById("filterUser");
          form.submit();
      }
      function generateSummaryReport(){
          var form = document.getElementById("summaryReport");
          form.submit();
      }
  </script>
</html>

