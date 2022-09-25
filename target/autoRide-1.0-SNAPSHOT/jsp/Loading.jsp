<%-- 
    Document   : Loading
    Created on : Sep 9, 2022, 11:51:53 AM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Loading...</title>
  <link rel="stylesheet" href="../assets/css/loading.css">
  <meta id="meta" charset="UTF-8" http-equiv="refresh" content="2; url='../index.html'"/>
</head>
<body>
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
        if (getCookie("status") === "IncorrectLoginDetails"){
            document.getElementById("meta").content="2; url='../jsp/errorPage.jsp'";      
        } else if (getCookie("status") === "Registered"){
            document.getElementById("meta").content="2; url='../jsp/signIn.jsp'";                  
        } else if (getCookie("status") === "Repeated") {
            document.getElementById("meta").content="2; url='../jsp/errorPage.jsp'";                                          
        } else if (getCookie("page") === "homePage"){
            document.getElementById("meta").content="0.5; url='../jsp/homePage.jsp'"; 
        } else if (getCookie("page") === "about"){
            document.getElementById("meta").content="0.5; url='../jsp/about.jsp'"; 
        } else if (getCookie("page") === "help"){
            document.getElementById("meta").content="0.5; url='../jsp/help.jsp'"; 
        } else if (getCookie("page") === "myBookings"){
            document.getElementById("meta").content="0.5; url='../myBookings'"; 
        }
        
        else {
            if (getCookie("type") === "admin"){
                document.getElementById("meta").content="2; url='../jsp/adminPage.jsp'"; 
            } else if (getCookie("type") === "Passenger"){
                document.getElementById("meta").content="2; url='../jsp/homePage.jsp'";                              
            } else if (getCookie("type") === "driver"){
                document.getElementById("meta").content="2; url='../jsp/driverPage.jsp'"; 
            }
        } 
        
    </script> 
   
<!-- partial:index.partial.html -->
<svg width="300" height="120" id="clackers">
  <!-- Left arc path -->
  <svg>
    <path id="arc-left-up" fill="none" d="M 90 90 A 90 90 0 0 1 0 0"/>
  </svg>
  <!-- Right arc path -->
  <svg>
    <path id="arc-right-up" fill="none" d="M 100 90 A 90 90 0 0 0 190 0"/>
  </svg>
  
  <text x="150" y="50" fill="#ffffff" font-family="Helvetica Neue,Helvetica,Arial" font-size="18"
        text-anchor="middle">
    L O A D I N G
  </text>
  <circle cx="15" cy="15" r="15">
    <!-- I used a python script to calculate the keyPoints and keyTimes based on a quadratic function. -->
    <animateMotion dur="1.5s" repeatCount="indefinite"
      calcMode="linear"
      keyPoints="0.0;0.19;0.36;0.51;0.64;0.75;0.84;0.91;0.96;0.99;1.0;0.99;0.96;0.91;0.84;0.75;0.64;0.51;0.36;0.19;0.0;0.0;0.05;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0"
      keyTimes="0.0;0.025;0.05;0.075;0.1;0.125;0.15;0.175;0.2;0.225;0.25;0.275;0.3;0.325;0.35;0.375;0.4;0.425;0.45;0.475;0.5;0.525;0.55;0.575;0.6;0.625;0.65;0.675;0.7;0.725;0.75;0.775;0.8;0.825;0.85;0.875;0.9;0.925;0.95;0.975;1.0">
      <mpath xlink:href="#arc-left-up"/>
    </animateMotion>
  </circle>
  <circle cx="135" cy="105" r="15" />
  <circle cx="165" cy="105" r="15" />
  <circle cx="95" cy="15" r="15">
    <animateMotion dur="1.5s" repeatCount="indefinite"
      calcMode="linear"
      keyPoints="0.0;0.0;0.05;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0.0;0.19;0.36;0.51;0.64;0.75;0.84;0.91;0.96;0.99;1.0;0.99;0.96;0.91;0.84;0.75;0.64;0.51;0.36;0.19;0.0"
      keyTimes="0.0;0.025;0.05;0.075;0.1;0.125;0.15;0.175;0.2;0.225;0.25;0.275;0.3;0.325;0.35;0.375;0.4;0.425;0.45;0.475;0.5;0.525;0.55;0.575;0.6;0.625;0.65;0.675;0.7;0.725;0.75;0.775;0.8;0.825;0.85;0.875;0.9;0.925;0.95;0.975;1.0">
      <mpath xlink:href="#arc-right-up"/>
    </animateMotion>
  </circle>
</svg>


<!-- partial -->
  
</body>

</html>
