<%-- 
    Document   : driverHomePage.jsp
    Created on : Sep 16, 2022, 7:11:27 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        

<!DOCTYPE html>
<html  >
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="homePageAutoRide">
  <meta name="twitter:card" content="summary_large_image"/>
  <meta name="twitter:image:src" content="">
  <meta property="og:image" content="">
  <meta name="twitter:title" content="Home">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
  <link rel="shortcut icon" href="../assets/images/mbr-121x121.png" type="image/x-icon">
  <meta name="description" content="">
  
  
  <title>Driver Home</title>
  <link rel="stylesheet" href="assets/css/myBookings.css">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/dropdown/css/style.css">
  <link rel="stylesheet" href="assets/socicon/css/styles.css">
  <link rel="stylesheet" href="assets/theme/css/style.css">
  <link rel="stylesheet" href="assets/web/assets/mobirise-icons2/mobirise2.css">
  <link rel="stylesheet" href="assets/web/assets/mobirise-icons/mobirise-icons.css">
  <link rel="stylesheet" href="assets/web/assets/mobirise-icons-bold/mobirise-icons-bold.css">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap-grid.min.css">
  <!--<link rel="stylesheet" href="assets/bootstrap/css/bootstrap-reboot.min.css">-->
  <link rel="preload" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
  <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap"></noscript>
  <link rel="preload" as="style" href="assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css" type="text/css">
  
  
  
  
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
            response.sendRedirect("jsp/signIn.jsp");
        }
        %>
  
    <section data-bs-version="5.1" class="menu cid-s48OLK6784" once="menu" id="menu1-h">
    
        <nav class="navbar navbar-dropdown navbar-fixed-top navbar-expand-lg">
            <div class="container">
                <div class="navbar-brand">
                    <span class="navbar-logo">

                            <img src="assets/images/mbr-121x121.png" alt="Auto Ride Logo" style="height: 3.8rem;">

                    </span>
                    <span class="navbar-caption-wrap"><a class="navbar-caption text-black display-7" href="jsp/homePage.jsp">Auto Ride</a></span>
                </div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-bs-toggle="collapse" data-target="#navbarSupportedContent" data-bs-target="#navbarSupportedContent" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <div class="hamburger">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav nav-dropdown" data-app-modern-menu="true"><li class="nav-item"><a class="nav-link link text-black display-4" href="jsp/help.jsp"><span class="mobi-mbri mobi-mbri-help mbr-iconfont mbr-iconfont-btn"></span>Help</a></li>
                        <li class="nav-item"><a class="nav-link link text-black display-4" href="jsp/about.jsp"><span class="mbrib-info mbr-iconfont mbr-iconfont-btn"></span>About</a></li>
                        <li class="nav-item"><a class="nav-link link text-black display-4" href="myOrders"><span class="mbri-browse mbr-iconfont mbr-iconfont-btn"></span>My Orders</a></li>
                        <form id="logOutForm">                        
                            <div class="navbar-buttons mbr-section-btn">
                                <a class="btn btn-primary display-4" id="logOut" href="logOut">Log Out</a>
                            </div>
                        </form>
                </div>
            </div>
        </nav>
    </section>

    <section data-bs-version="5.1" class="header1 cid-s48MCQYojq" data-bg-video="http://www.youtube.com/watch?v=uNCr7NdOJgw" id="header1-f">
        <div class="mbr-overlay" style="opacity: 0.8; background-color: rgb(255, 255, 255);"></div>
        <div class="align-center container-fluid">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <h1 class="mbr-section-title mbr-fonts-style mb-3 display-1" id="HiName"><strong>Hi, {name}!</strong></h1>
                </div>
            </div>
        </div>
    </section>

    <!--- add Tables -->
    <section data-bs-version="5.1" class="form4 cid-tcYkO9d54D" id="form4-l">  
        <div class="container-fluid">
            <div class="row content-wrapper justify-content-center">
                <div class="col-lg-12 offset-lg-0 mbr-form">
                    <!--- section two-->
                    <div class="container">
                        <div class="row">
                            <div>
                                <h1 class="align-center">Pending Bookings</h1>
                                <div class="table-bordered">
                                    <table id="myBookings" class="table table-striped" title="Incoming Bookings">
                                        <thead>
                                            <tr>
                                                <th>Book_Date</th>
                                                <th>Book_Time</th>
                                                <th>Location</th>
                                                <th>Destination</th>
                                                <th>Price</th>
                                                <th>Accept_Ride</th>
                                                <th>Reject_Ride</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="data" items="${requestScope.pendingRides}">
                                                <tr>
                                                    <td><c:out value="${data.bookDate}" /></td>
                                                    <td><c:out value="${data.bookTime}" /></td>
                                                    <td><c:out value="${data.location}" /></td>
                                                    <td><c:out value="${data.destination}" /></td>
                                                    <td><c:out value="${data.price}" /></td>
                                                    <td><a style="font-size: 10px;"
                                                            onclick="updateRideStatus(${data.id},'Accept')"
                                                            href="#"
                                                            class="btn btn-success"
                                                                        >
                                                            <c:out value="Accept" />
                                                        </a>
                                                    </td>
                                                    <td><a style="font-size: 10px;"
                                                            onclick="updateRideStatus(${data.id},'Reject')"
                                                            href="#"
                                                            class="btn btn-danger"
                                                                        >
                                                            <c:out value="Reject" />
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
                </div>
                <div class="col-lg-7 offset-lg-1 col-12">
                    <!--- section two-->
                    
                </div>
            </div>
        </div>
    </section>
    
    <section data-bs-version="5.1" class="form4 cid-tcYkO9d54D" id="form4-l">  
        <div class="container-fluid">
            <div class="row content-wrapper justify-content-center">
                <div class="col-lg-12 offset-lg-0 mbr-form">
                    <!--- section two-->
                    <div class="container">
                        <div class="row">
                            <div>
                                <h1 class="align-center">Ongoing Bookings</h1>
                                <div class="table-bordered">
                                    <table id="myBookings" class="table table-striped" title="Incoming Bookings">
                                        <thead>
                                            <tr>
                                                <th>Book_Date</th>
                                                <th>Book_Time</th>
                                                <th>Location</th>
                                                <th>Destination</th>
                                                <th>Price</th>
                                                <th>Mark_As_Paid</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="data" items="${requestScope.ongoingRides}">
                                                <tr>
                                                    <td><c:out value="${data.bookDate}" /></td>
                                                    <td><c:out value="${data.bookTime}" /></td>
                                                    <td><c:out value="${data.location}" /></td>
                                                    <td><c:out value="${data.destination}" /></td>
                                                    <td><c:out value="${data.price}" /></td>
                                                    <td><a style="font-size: 13px;"
                                                            onclick="updateRideStatus(${data.id},'Complete')"
                                                            href="#"
                                                            class="btn btn-success"
                                                                        >
                                                            <c:out value="Complete" />
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
                </div>
                <div class="col-lg-7 offset-lg-1 col-12">
                    <!--- section two-->
                    
                </div>
            </div>
        </div>
    </section>


    <section data-bs-version="5.1" class="pricing2 cid-tcYqBKDq4I" id="pricing2-o">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-6 align-center col-lg-4">
                    <div class="plan">
                        <div class="plan-header">
                            <h6 class="plan-title mbr-fonts-style mb-3 display-1">
                                <strong>Cycle</strong></h6>
                            <div class="plan-price">
                                <p class="price mbr-fonts-style m-0 display-2"><strong>MVR 10+</strong></p>
                                <p class="price-term mbr-fonts-style mb-3 display-7"><strong><br></strong><strong>Per Ride</strong></p>
                            </div>
                        </div>
                        <div class="plan-body">
                            <div class="plan-list mb-4">
                                <ul class="list-group mbr-fonts-style list-group-flush display-7">
                                    <li class="list-group-item">Distance less than 10 km - MVR 10</li>
                                    <li class="list-group-item">Greater than 10 km - MVR 1+/km</li>
                                    <li class="list-group-item">Greater than 15 km - MVR 2+/km</li>
                                    <li class="list-group-item">Greater than 20 km - MVR 3+/km<br></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 align-center col-lg-4">
                    <div class="plan">
                        <div class="plan-header">
                            <h6 class="plan-title mbr-fonts-style mb-3 display-1">
                                <strong>Car</strong></h6>
                            <div class="plan-price">
                                <p class="price mbr-fonts-style m-0 display-2"><strong>MVR 25+</strong><br></p>
                                <p class="price-term mbr-fonts-style mb-3 display-7"><strong><br></strong><strong>Per Ride</strong></p>
                            </div>
                        </div>
                        <div class="plan-body">
                            <div class="plan-list mb-4">
                                <ul class="list-group mbr-fonts-style list-group-flush display-7">
                                    <li class="list-group-item">Distance less than 10 km - MVR 25</li>
                                    <li class="list-group-item">Greater than 10 km - MVR 2+/km</li>
                                    <li class="list-group-item">Greater than 15 km - MVR 3+/km</li>
                                    <li class="list-group-item">Greater than 20 km - MVR 4+/km<br></li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 align-center col-lg-4">
                    <div class="plan">
                        <div class="plan-header">
                            <h6 class="plan-title mbr-fonts-style mb-3 display-1">
                                <strong>Pickup</strong></h6>
                            <div class="plan-price">
                                <p class="price mbr-fonts-style m-0 display-2"><strong>MVR 40+</strong></p>
                                <p class="price-term mbr-fonts-style mb-3 display-7"><strong><br></strong><strong>Per Ride</strong></p>
                            </div>
                        </div>
                        <div class="plan-body">
                            <div class="plan-list mb-4">
                                <ul class="list-group mbr-fonts-style list-group-flush display-7">
                                    <li class="list-group-item">Distance less than 10 km - MVR 40</li>
                                    <li class="list-group-item">Greater than 10 km - MVR 3+/km</li>
                                    <li class="list-group-item">Greater than 15 km - MVR 4+/km</li>
                                    <li class="list-group-item">Greater than 20 km - MVR 5+/km<br></li> 
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section data-bs-version="5.1" class="content17 cid-tcYqGPaT9g" id="content17-p">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-10">
                    <div class="section-head align-center mb-4">
                        <h3 class="mbr-section-title mb-0 mbr-fonts-style display-2">
                            <strong>Toggle FAQ</strong>
                        </h3>
                    </div>
                    <div id="bootstrap-toggle" class="toggle-panel accordionStyles tab-content">
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingOne">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse1_13" aria-expanded="false" aria-controls="collapse1">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>What does Auto Ride do?</strong></h6>
                                    <span class="sign mbr-iconfont mbri-arrow-down"></span>
                                </a>
                            </div>
                            <div id="collapse1_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">We provide the best taxi booking services in Maldives.&nbsp;</p>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingTwo">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse2_13" aria-expanded="false" aria-controls="collapse2">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>In which areas do Auto Ride operate?</strong></h6>
                                    <span class="sign mbr-iconfont mbri-arrow-down"></span>
                                </a>
                            </div>
                            <div id="collapse2_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">We currently operate in the Greater Male Region. We are working on expanding our services to other islands within the upcoming years.</p>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingThree">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse3_13" aria-expanded="false" aria-controls="collapse3">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>How to generate payment and booking history?&nbsp;</strong></h6>
                                    <span class="sign mbr-iconfont mbri-arrow-down"></span>
                                </a>
                            </div>
                            <div id="collapse3_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">You can generate your booking history by clicking on My Bookings.</p>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingThree">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse4_13" aria-expanded="false" aria-controls="collapse4">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>How to contact us?</strong></h6>
                                    <span class="sign mbr-iconfont mbri-arrow-down"></span>
                                </a>
                            </div>
                            <div id="collapse4_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">You can contact us via the help page.</p>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingThree">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse5_13" aria-expanded="false" aria-controls="collapse5">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>How do i deactivate my account?</strong></h6>
                                    <span class="mbr-iconfont mobi-mbri-arrow-down mobi-mbri"></span>
                                </a>
                            </div>
                            <div id="collapse5_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">Go to my profile and click on deactivate account.</p>
                                </div>
                            </div>
                        </div>    
                        <div class="card mb-3">
                            <div class="card-header" role="tab" id="headingThree">
                                <a role="button" class="collapsed panel-title text-black" data-toggle="collapse" data-bs-toggle="collapse" data-core="" href="#collapse6_13" aria-expanded="false" aria-controls="collapse6">
                                    <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7"><strong>Can i view my previous booking details / invoices?</strong></h6>
                                    <span class="mbr-iconfont mobi-mbri-arrow-down mobi-mbri"></span>
                                </a>
                            </div>
                            <div id="collapse6_13" class="panel-collapse noScroll collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <p class="mbr-fonts-style panel-text display-7">Yes you can. Go to My Bookings and click on the status of the booking to view that invoice.</p>
                                </div>
                            </div>
                        </div>  
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section data-bs-version="5.1" class="map1 cid-tcYpin3hgz" id="map1-n">  
        <div class="container">
            <div class="google-map"><iframe frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0&amp;q=villa college" allowfullscreen=""></iframe></div>
        </div>
    </section>

    <section class="display-7" style="padding: 0;align-items: center;justify-content: center;flex-wrap: wrap;    align-content: center;display: flex;position: relative;height: 4rem;">
        <a href="https://mobiri.se/" onclick="return false;" style="flex: 1 1;height: 4rem;position: absolute;width: 100%;z-index: 1;">
            <img alt="" style="height: 4rem;" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==">
        </a>
        <p style="margin: 0;text-align: center;" class="display-7">© Copyright 2022 Auto Ride. All Rights Reserved.</p>
        <a href="https://mobirise" onclick="return false;"></a>
    </section>
    
    <!--Modal-->
    <div class="modal fade" id="location-modal" tabindex="-1" role="dialog" aria-labelledby="location-modal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">        
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title" id="address-label">Choose Location</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="map"></div>
                </div>
            </div>
        </div>
    </div>

    <form id="updateRideStatus" method="POST" action="./rideStatusUpdate" hidden>
        <input id="updateType" name="updateType" value="">
        <input id="bookingNumberRide" name="bookingNumberRide" value="">
    </form>
    
    <-<!-- Scripts -->
    <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script src="assets/smoothscroll/smooth-scroll.js"></script>  
    <script src="assets/ytplayer/index.js"></script>  
    <script src="assets/vimeoplayer/player.js"></script>  
    <script src="assets/embla/embla.min.js"></script>  
    <script src="assets/embla/script.js"></script>  
    <script src="assets/mbr-switch-arrow/mbr-switch-arrow.js"></script>  
    <script src="assets/dropdown/js/navbar-dropdown.js"></script>  
    <script src="assets/theme/js/script.js"></script>  
    <script src="assets/formoid/formoid.min.js"></script>  
    
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
        
        let type = getCookie("type");
        if (type!=="Driver"){
            document.forms[0].action="../logOut";
            document.forms[0].submit();
        }
        
        let firstName = getCookie("firstName");
        document.getElementById("HiName").innerHTML = "Hi, "+firstName+"!";
        
        function updateRideStatus(number, type){
            document.getElementById("bookingNumberRide").value = number;
            document.getElementById("updateType").value = type;
            var form = document.getElementById("updateRideStatus");
            form.submit();
        }
    </script>
    <script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0&libraries=places&callback=initGoogle"></script>
    <script src="//maps.googleapis.com/maps/api/js?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0"></script>
</body>
</html>