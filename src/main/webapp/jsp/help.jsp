<%-- 
    Document   : help
    Created on : Sep 14, 2022, 9:54:57 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  >
<head>
  <!-- Site made with Mobirise Website Builder v5.6.11, https://mobirise.com -->
  <meta charset="UTF-8">
  <meta id="meta" http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="Mobirise v5.6.11, mobirise.com">
  <meta name="twitter:card" content="summary_large_image"/>
  <meta name="twitter:image:src" content="">
  <meta property="og:image" content="">
  <meta name="twitter:title" content="Home">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
  <link rel="shortcut icon" href="assets/images/logo5.png" type="image/x-icon">
  <meta name="description" content="">
  
  
  <title>Home</title>
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap-grid.min.css">
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap-reboot.min.css">
  <link rel="stylesheet" href="../assets/socicon/css/styles.css">
  <link rel="stylesheet" href="../assets/theme/css/style.css">
  <link rel="preload" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
  <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap"></noscript>
  <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  
  
  
  
</head>
    <script type="text/javascript">
   
    </script>
<body>
      <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("../jsp/signIn.jsp");
        }
      %>  
  <section data-bs-version="5.1" class="form4 cid-thqBWPUvNM mbr-fullscreen" id="form4-t">

    

    

    <div class="container">
        <div class="row content-wrapper justify-content-center">
            <div class="col-lg-3 offset-lg-1 mbr-form" data-form-type="formoid">
                <form action="../submitQuery" method="POST" class="mbr-form form-with-styler" data-form-title="Form Name">
                    <div class="row">
                        <div hidden="hidden" data-form-alert="" class="alert alert-success col-12">Thanks for filling out the form!</div>
                        <div hidden="hidden" data-form-alert-danger="" class="alert alert-danger col-12">
                            Oops...! some problem!
                        </div>
                    </div>
                    <div class="dragArea row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <h1 class="mbr-section-title mb-4 display-2">
                                <strong>Contact Us</strong>
                            </h1>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <p class="mbr-text mbr-fonts-style mb-4 display-7">
                                Fill this form and we'll look into the issue.</p>
                        </div>
                        <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="security">
                            <select type="text" name="security" placeholder="Anonymous" data-form-field="name" class="form-control" value="" id="name-form4-t" required>
                            <option value="share">Share User details</option>
                            <option value="anonymous">Anonymous</option>
                            </select>
                        </div>
                        <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="type">
                            <label class="form-control-label">Choose type of Issue</label>                            
                            <select type="text" name="typeOfIssue" placeholder="Name" data-form-field="name" class="form-control" value="" id="name-form4-t" required>
                            <option value="Booking_Process">Booking Process</option>
                            <option value="Profile_Edit">Profile Edit</option>
                            <option value="Bookings_List">Bookings List</option>
                            <option value="Pricing">Pricing</option>
                            <option value="Pricing">Driver</option>
                            <option value="Improvement_Idea">Improvement Idea</option>
                            <option value="Other_Issue">Other Issue</option>
                            </select>
                        </div>
                        <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="explanation">
                            <textarea style="height: 250px;" type="text" name="explanation" placeholder="Details" data-form-field="text" class="form-control" value="" id="name-form4-t" required></textarea>
                        </div>
                        <div class="col-12 col-md-auto mbr-section-btn">
                            <a onclick="goToHome()" class="btn btn-secondary display-4">Back</a>
                        </div>
                        <div class="col-12 col-md-auto mbr-section-btn">
                            <button type="submit" class="btn btn-secondary display-4">Submit</button>
                        </div>
                        <div class="col-12 col-md-auto mbr-section-btn">
                            <a href="../viewUserQueries" class="btn btn-secondary display-3">Status</a>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-7 offset-lg-1 col-12">
                <div class="image-wrapper">
                    <img class="w-100" src="../assets/img/tesla-model-s.png" alt="Auto Ride">
                </div>
                
            </div>
        </div>
        
    </div>
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
</section>
</body>
</html>