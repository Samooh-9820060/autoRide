<%-- 
    Document   : errorPage
    Created on : Sep 9, 2022, 11:54:51 AM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
  <meta id = "meta" charset="UTF-8" http-equiv="refresh" content="5; url='../index.html'"/>
  <title>500 Error</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="../assets/css/errorPage.css">

</head>
<body>
<!-- partial:index.partial.html -->

<div class="browser">
  <div class="controls">
    <i></i>
    <i></i>
    <i></i>
  </div>
  
  <div class="eye"></div>
  <div class="eye"></div>
  <div class="mouth">
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
    <div class="lips"></div>
  </div>
</div>

<h1 id = "heading">test1</h1>
<p id = "details">test2</p>

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
        document.getElementById("meta").content="5; url='../jsp/signIn.jsp'";
        document.getElementById("heading").innerHTML = "The username or password you entered was incorrect";
        document.getElementById("details").innerHTML = "Please provide the correct Username and Password. You will be redirected to the login page in a few seconds.";
    } else if (getCookie("status") === "Repeated") {
        document.getElementById("heading").innerHTML = "The email or phone number your provided has already been registered";
        document.getElementById("details").innerHTML = "Please login using the email you provided. You will be redirected in a few seconds.";
        document.getElementById("meta").content="5; url='../jsp/signIn.jsp'";                                          
    }
</script>
<!-- 404 text -->
<!--
<h1>Unfortunately, this page does not exist.</h1>
<p>The link you clicked may be broken or the page may have been removed.</p>
-->
<!-- partial -->
  
</body>

</html>
