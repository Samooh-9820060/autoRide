<%-- 
    Document   : about
    Created on : Sep 14, 2022, 8:52:11 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>About Us</title>
    <link rel="stylesheet" href="../assets/css/about.css">
    <meta id="meta" name="viewport" content="width=device-width, initial-sclae=1.0">


  </head>
  <style>
      .bg-gradient-info {
        background-image: linear-gradient(310deg, #ffb200 0%, #ff2700 100%);
      }
  </style>
      <script type = "text/javascript">
        function disableBackButton() {
            window.history.forward();
        }
        //setTimeout("disableBackButton()", 0);
    </script>
    <body style="background: white">
          <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("../jsp/signIn.jsp");
        }
    %>
      <div class="about-section">
        <div class="inner-width">
          <h1>About Us</h1>
          <div class="border"></div>
          <div class="about-section-row">
            <div class="about-section-col">
              <div class="about">
                <p>
			AutoRide is a taxy booking company based in maldives. As of now we only operate in the greater male region. However, we are planning to take the next step and start
			operation in the islands by 2023.
                </p>
                <a onclick="goToHome()" class="btn btn-secondary display-4">Back</a>
              </div>
            </div>
            <div class="about-section-col">
              <div class="skills">
                <div class="skill">
                  <div class="title">Speed</div>
                  <div class="progress">
                    <div class="progress-barSpeed p1"><span style="color: #ffffff">100%</span></div>
                  </div>
                </div>

                <div class="skill">
                  <div class="title">Safety</div>
                  <div class="progress">
                      <div class="progress-barSafety p2"><span style="color: #ffffff">100%</span></div>
                  </div>
                </div>

                <div class="skill">
                  <div class="title">Price</div>
                  <div class="progress">
                    <div class="progress-barPrice p3"><span style="color: #ffffff">100%</span></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
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
        function goToHome(){
            if (getCookie("type")==="Passenger"){
                window.location.href = '../jsp/homePage.jsp';
            } else if (getCookie("type")==="Driver"){
                window.location.href = '../driverHomePage';
            }
        }
  </script>
</html>

