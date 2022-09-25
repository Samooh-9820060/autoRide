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
  
  
  <title>Home</title>
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="../assets/dropdown/css/style.css">
  <link rel="stylesheet" href="../assets/socicon/css/styles.css">
  <link rel="stylesheet" href="../assets/theme/css/style.css">
  <link rel="stylesheet" href="../assets/web/assets/mobirise-icons2/mobirise2.css">
  <link rel="stylesheet" href="../assets/web/assets/mobirise-icons/mobirise-icons.css">
  <link rel="stylesheet" href="../assets/web/assets/mobirise-icons-bold/mobirise-icons-bold.css">
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap-grid.min.css">
  <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap-reboot.min.css">
  <link rel="preload" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
  <noscript><link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap"></noscript>
  <link rel="preload" as="style" href="../assets/mobirise/css/mbr-additional.css"><link rel="stylesheet" href="../assets/mobirise/css/mbr-additional.css" type="text/css">
  
  
  
  
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
            response.sendRedirect("../jsp/signIn.jsp");
        }
    %>
  
    <section data-bs-version="5.1" class="menu cid-s48OLK6784" once="menu" id="menu1-h">
    
        <nav class="navbar navbar-dropdown navbar-fixed-top navbar-expand-lg">
            <div class="container">
                <div class="navbar-brand">
                    <span class="navbar-logo">

                            <img src="../assets/images/mbr-121x121.png" alt="Auto Ride Logo" style="height: 3.8rem;">

                    </span>
                    <span class="navbar-caption-wrap"><a class="navbar-caption text-black display-7" href="../jsp/homePage.jsp">Auto Ride</a></span>
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
                    <ul class="navbar-nav nav-dropdown" data-app-modern-menu="true"><li class="nav-item"><a class="nav-link link text-black display-4" onclick="goToHelp()"><span class="mobi-mbri mobi-mbri-help mbr-iconfont mbr-iconfont-btn"></span>Help</a></li>
                        <li class="nav-item"><a class="nav-link link text-black display-4" onclick="goToAbout()"><span class="mbrib-info mbr-iconfont mbr-iconfont-btn"></span>About</a></li>
                        <li class="nav-item"><a class="nav-link link text-black display-4" href="https://mobirise.com"><span class="mbri-browse mbr-iconfont mbr-iconfont-btn"></span>My Bookings</a></li>
                        <li class="nav-item"><a class="nav-link link text-black show display-4" href="" aria-expanded="true"><span class="mobi-mbri mobi-mbri-user-2 mbr-iconfont mbr-iconfont-btn"></span>My Profile</a></li></ul>
                        <form id="logOutForm">                        
                            <div class="navbar-buttons mbr-section-btn">
                                <a class="btn btn-primary display-4" id="logOut" href="../logOut">Log Out</a>
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
                    <h2 class="mbr-section-title mbr-fonts-style mb-3 display-5" id="ok">Book your Taxi Now</h2>
                </div>
            </div>
        </div>
    </section>

    <section data-bs-version="5.1" class="form4 cid-tcYkO9d54D" id="form4-l">  
        <div class="container-fluid">
            <div class="row content-wrapper justify-content-center">
                <div class="col-lg-3 offset-lg-1 mbr-form">
                        <div class="row">
                            <div id="placedOrder" class="alert alert-success col-12" hidden>Order has been successfully placed!</div>
                            <div hidden="hidden" class="alert alert-danger col-12">Oops...! some problem!</div>
                        </div>
                        <div class="dragArea row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <h1 class="mbr-section-title mb-4 display-2">
                                    <strong>Book Your Ride</strong></h1>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">

                            </div>
                            <form method="POST" action="../bookRide">
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="name">
                                <input type="date" name="bookedDate" placeholder="Date" data-form-field="date" class="form-control" value="" id="bookedDate" required>
                            </div>
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="time">
                                <input type="time" name="bookedTime" placeholder="Time" data-form-field="time" class="form-control" value="" id="bookingTime" required>
                            </div>
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="currentAddress">
                                <input type="location" name="bookedCurrentLocation" placeholder="Current Location" data-form-field="currentLocation" class="form-control" value="" id="bookingCurrentLocation" required>
                            </div>
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="destination">
                                <input type="location" name="bookedDestination" placeholder="Destination" data-form-field="destination" class="form-control" value="" id="bookingDestination" required>
                            </div>
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="type">
                                <select name="vehicleType" class="form-control" id="typeVehicle">
                                    <option value="Car">Car (MVR 25+)</option>
                                    <option value="Cycle">Cycle (MVR 10+)</option>
                                    <option value="Pickup">Pickup (MVR 40+)</option>
                                </select>
                            </div>
                            <div class="col-lg-12 col-md col-12 form-group mb-3" data-for="bookPrice" id="bookPriceDiv" hidden>
                                <input type="location" name="bookPriceLabel" placeholder="MVR " data-form-field="destination" class="form-control" value="" id="bookPriceLabel" disabled>
                            </div>

                            <input type="text" id="carryDate" name="carryDate"  hidden value="OK" ></input>
                            <input type="text" id="carryTime" name="carryTime"  hidden value="OK" ></input>
                            <input type="text" id="carryLocation" name="carryLocation" hidden value="OK" ></input>
                            <input type="text" id="carryDestination" name="carryDestination" hidden value="OK" ></input>
                            <input type="text" id="carryVehicle" name="carryVehicle" hidden value="OK" ></input>

                            <input type="text" id="locationLat" name="locationLat" hidden value="OK" ></input>
                            <input type="text" id="locationLng" name="locationLng" hidden value="OK" ></input>
                            <input type="text" id="destLat" name="destLat" hidden value="OK" ></input>
                            <input type="text" id="destLng" name="destLng" hidden value="OK" ></input>
                            <input type="text" id="inputDuration" name="inputDuration" hidden value="OK" ></input>
                            <input type="text" id="inputDistance" name="inputDistance" hidden value="OK" ></input>
                            <div>
                            <div class="col-12 col-md-auto mbr-section-btn"><button name="calculateDistanceAndPriceButton" id="calculateDistanceAndPriceButton" class="btn btn-secondary display-4" onclick="return bookNowButton()"><span class="mobi-mbri mobi-mbri-touch mbr-iconfont mbr-iconfont-btn"></span>Book Now</button></div>
                            <div class="col-12 col-md-auto mbr-section-btn"><button type="submit" name="confirmOrderButton" id="confirmOrderButton" class="btn btn-secondary display-4" hidden><span class="mobi-mbri mobi-mbri-touch mbr-iconfont mbr-iconfont-btn"></span>Confirm</button></div>
                            <div class="col-12 col-md-auto mbr-section-btn"><button name="cancelOrderButton" id="cancelOrderButton" class="btn btn-secondary display-4" onclick="return backButton()" hidden><span class="mobi-mbri mobi-mbri-touch mbr-iconfont mbr-iconfont-btn"></span>Back</button></div>
                            </div>
                            </form>
                        </div>
                </div>
                <div class="col-lg-7 offset-lg-1 col-12">
                    <div class="image-wrapper">
                        <img class="w-100" src="../assets/images/mbr-1476x984.jpg" alt="Auto Ride">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <-<!-- Our Team Section -->

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
                            <div class="mbr-section-btn text-center">
                                <a onclick="bookCycle()" class="btn btn-primary display-4">Get started</a>
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
                            <div class="mbr-section-btn text-center">
                                <a onclick="bookCar()" class="btn btn-primary display-4">Get started</a>
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
                            <div class="mbr-section-btn text-center">
                                <a onclick="bookPickup()" class="btn btn-primary display-4">Get started</a>
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
    
    <-<!-- Scripts -->
    <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>  
    <script src="../assets/smoothscroll/smooth-scroll.js"></script>  
    <script src="../assets/ytplayer/index.js"></script>  
    <script src="../assets/vimeoplayer/player.js"></script>  
    <script src="../assets/embla/embla.min.js"></script>  
    <script src="../assets/embla/script.js"></script>  
    <script src="../assets/mbr-switch-arrow/mbr-switch-arrow.js"></script>  
    <script src="../assets/dropdown/js/navbar-dropdown.js"></script>  
    <script src="../assets/theme/js/script.js"></script>  
    <script src="../assets/formoid/formoid.min.js"></script>  
    
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
        if (type!=="Passenger"){
            document.forms[0].action="../logOut";
            document.forms[0].submit();
        }
        
        let firstName = getCookie("firstName");
        document.getElementById("HiName").innerHTML = "Hi, "+firstName+"!";   
    </script>
    <script type="text/javascript">
        function finishBooking(){
            document.getElementById("placedOrder").setAttribute("hidden", "hidden");
        }
    </script>
    <script>
        
        function initGoogle(){
            var location = {
		lat: 40.000,
		lng: -79.000
            };
            var options= {
		center:location,
		zoom:9
            };
	
            if (navigator.geolocation){
		//console.log('geolocation is here!');
		
		navigator.geolocation.getCurrentPosition((loc) => {
                    location.lat = loc.coords.latitude;
                    location.lng = loc.coords.longitude;

                    map = new google.maps.Map(document.getElementById("map"),options);
		},
		(err) => {
                    //console.log("User clicked no");
                    map = new google.maps.Map(document.getElementById("map"),options);
		});
            } else {
                console.log('geolocation not supported');
                map = new google.maps.Map(document.getElementById("map"),options);
            }

            currentLocation = new google.maps.places.Autocomplete(document.getElementById("bookingCurrentLocation"), 
            {
                componentRestrictions: {'country': ['MV']},
                fields: ['geometry','name'],
                types: []
            });
            
            destination = new google.maps.places.Autocomplete(document.getElementById("bookingDestination"), 
            {
                componentRestrictions: {'country': ['MV']},
                fields: ['geometry','name'],
                types: []
            });
	
            currentLocation.addListener("place_changed",() => {
                const place = currentLocation.getPlace();
                new google.maps.Marker({
                    position: place.geometry.location,
                    title: place.name,
                    map:map 
                });
            }); 
            
            destination.addListener("place_changed",() => {
                const place = destination.getPlace();
                new google.maps.Marker({
                    position: place.geometry.location,
                    title: place.name,
                    map:map 
                });
            });
        }
        
        
        var bookingLat = null;
        var bookingLng = null;
        var destLat = null;
        var destLng = null;
        
        function bookNowButton(){
            if (document.getElementById("bookedDate").value === ""){
                alert("Please enter valid date");
            } else if (document.getElementById("bookingTime").value === ""){
                alert("Please enter valid Time");
            } else {
                doGeocodePickupLocation();            
            }
            return false;
        }
        
        function backButton(){
            
            document.getElementById("calculateDistanceAndPriceButton").hidden = false;
            document.getElementById("confirmOrderButton").hidden = true;
            document.getElementById("cancelOrderButton").hidden = true;
            document.getElementById("bookPriceDiv").hidden = true;
            
            document.getElementById("bookedDate").disabled = false;
            document.getElementById("bookingTime").disabled = false;
            document.getElementById("bookingCurrentLocation").disabled = false;
            document.getElementById("bookingDestination").disabled = false;
            document.getElementById("typeVehicle").disabled = false;
            return false;
        }
        
        function doGeocodePickupLocation() {
            var bookingLocation = document.getElementById("bookingCurrentLocation");
            // Get geocoder instance
            var geocoder = new google.maps.Geocoder();
            //alert(bookingLocation.value);
    
            // Geocode the address
            geocoder.geocode({ 
                'address': bookingLocation.value
            }, function(results, status) {
                //alert(status);
                if (status === google.maps.GeocoderStatus.OK && results.length > 0) {
                    // set it to the correct, formatted address if it's valid
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();
                    bookingLat = latitude;
                    bookingLng = longitude;
                    
                    document.getElementById("locationLat").value = encodeURIComponent(latitude);
                    document.getElementById("locationLng").value = encodeURIComponent(longitude);

                    //document.cookie = "bookPickupLatitude = "+encodeURIComponent(latitude);
                    //document.cookie = "bookPickupLongitude = "+encodeURIComponent(longitude);
                    
                    bookingLocation.value = results[0].formatted_address;
                    doGeocodeDestinationLocation();
                } else {
                    // show an error if it's not
                    alert("Please Enter correct pickup location");
                    document.getElementById("bookingCurrentLocation").value="";
                }
            });
        };
        
        function doGeocodeDestinationLocation() {
            var destinationLocation = document.getElementById("bookingDestination");
            // Get geocoder instance
            var geocoder = new google.maps.Geocoder();
            //alert(bookingLocation.value);
    
            // Geocode the address
            geocoder.geocode({ 
                'address': destinationLocation.value
            }, function(results, status) {
                //alert(status);
                if (status === google.maps.GeocoderStatus.OK && results.length > 0) {
                    // set it to the correct, formatted address if it's valid
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();
                    destLat = latitude;
                    destLng = longitude;
                    //document.cookie = "bookDestinationLatitude = "+encodeURIComponent(latitude);
                    //document.cookie = "bookDestinationLongitude = "+encodeURIComponent(longitude);
                    
                    document.getElementById("destLat").value = encodeURIComponent(latitude);
                    document.getElementById("destLng").value = encodeURIComponent(longitude);
                    
                    destinationLocation.value = results[0].formatted_address;
                    calculateDistance();
                } else {
                    // show an error if it's not
                    alert("Please Enter correct destination");
                    document.getElementById("bookingDestination").value="";
                }
            });
        };
        
        function calculateDistance(){
            var service = new google.maps.DistanceMatrixService(); // instantiate Distance Matrix service

            service.getDistanceMatrix({
                origins: [bookingLat+","+bookingLng], // technician locations
                destinations: [destLat+","+destLng], // customer address
                travelMode: google.maps.TravelMode.DRIVING,
                unitSystem: google.maps.UnitSystem.metric,
                avoidHighways: false,
                avoidTolls: false
            }, callback);

            // Callback function used to process Distance Matrix response
            function callback(response, status) {
                if (status === 'OK') {
                    var origins = response.originAddresses;
                    var destinations = response.destinationAddresses;
                    for (var i = 0; i < origins.length; i++) {
                        var results = response.rows[i].elements;
                        for (var j = 0; j < results.length; j++) {
                            var element = results[j];
                            if(element.distance === undefined){
                                alert("Please enter a location that a vehicle can travel to");
                            } else {
                                var distance = element.distance.text;
                                var duration = element.duration.text;
                                var from = origins[i];
                                var to = destinations[j]; 
                                //document.cookie = "distance = "+encodeURIComponent(distance);
                                //document.cookie = "duration = "+encodeURIComponent(duration);
                                document.getElementById("inputDuration").value = encodeURIComponent(duration);
                                document.getElementById("inputDistance").value = encodeURIComponent(distance);
                                //bookRide();
                                document.getElementById("confirmOrderButton").hidden = false;
                                document.getElementById("cancelOrderButton").hidden = false;
                                document.getElementById("calculateDistanceAndPriceButton").hidden = true; 
                                document.getElementById("bookPriceDiv").hidden = false;
                                
                                document.getElementById("carryDate").value = document.getElementById("bookedDate").value;
                                document.getElementById("carryTime").value = document.getElementById("bookingTime").value;
                                document.getElementById("carryLocation").value = document.getElementById("bookingCurrentLocation").value;
                                document.getElementById("carryDestination").value = document.getElementById("bookingDestination").value;
                                document.getElementById("carryVehicle").value = document.getElementById("typeVehicle").value;
                        
                                document.getElementById("bookedDate").disabled = true;
                                document.getElementById("bookingTime").disabled = true;
                                document.getElementById("bookingCurrentLocation").disabled = true;
                                document.getElementById("bookingDestination").disabled = true;
                                document.getElementById("typeVehicle").disabled = true;
                                
                                calculatePrice();
                                
                            }
                        }
                    }
                }
            }
            //bookRide();
        }
        
        function calculatePrice(){
            var price = 0.00;
            var vehicle = document.getElementById("typeVehicle").value;
            
            switch(vehicle){
                case "Cycle":
                    price += 10.00;
                    break;
                case "Car":
                    price += 25.00;
                    break;
                case "Pickup":
                    price += 40.00;
                    break;
            }
            
            var distance = document.getElementById("inputDistance").value.replace("%20km","");
            
            switch (vehicle) {
                case "Cycle":
                    if (distance<=10.0){
                        price += 0.00;
                    } else if ((distance>10.0)&&(distance<=15.0)){
                        price += 0.00+((distance-10.0)*1);
                    } else if ((distance>15.0)&&(distance<=20.0)){
                        price += 0.00+((15.0-10.0)*1)+((distance-15)*2);
                    } else if ((distance>20.0)){
                        price += 0.00+((15.0-10.0)*1)+((20.0-15.0)*2)+((distance-20)*3);
                    } else {
                        price = 0.00;
                    }
                    break;

                case "Car":
                    if (distance<=10.0){
                        price += 0.00;
                    } else if ((distance>10.0)&&(distance<=15.0)){
                        price += 0.00+((distance-10.0)*2);
                    } else if ((distance>15.0)&&(distance<=20.0)){
                        price += 0.00+((15.0-10.0)*2)+((distance-15)*3);
                    } else if ((distance>20.0)){
                        price += 0.00+((15.0-10.0)*2)+((20.0-15.0)*3)+((distance-20)*4);
                    } else {
                        price += 0.00;
                    }
                    break;
                case "Pickup":
                    if (distance<=10.0){
                        price += 0.00;
                    } else if ((distance>10.0)&&(distance<=15.0)){
                        price += 0.00+((distance-10.0)*3);
                    } else if ((distance>15.0)&&(distance<=20.0)){
                        price += 0.00+((15.0-10.0)*3)+((distance-15)*4);
                    } else if ((distance>20.0)){
                        price += 0.00+((15.0-10.0)*3)+((20.0-15.0)*4)+((distance-20)*5);
                    } else {
                        price += 0.00;
                    }
                    break;
            }
            
            document.getElementById("bookPriceLabel").value = "MVR "+price.toFixed(2).toString();
        }
        function goToAbout(){
            document.cookie = "page=about";
            window.location.href = "../jsp/Loading.jsp";
        }
        function goToHelp(){
            document.cookie = "page=help";
            window.location.href = "../jsp/Loading.jsp";
        }
        
        function bookCycle(){
            document.getElementById("form4-l").scrollIntoView({behavior: 'smooth'});
            document.getElementById("typeVehicle").value = "Cycle";
        }
        function bookCar(){
            document.getElementById("form4-l").scrollIntoView({behavior: 'smooth'});
            document.getElementById("typeVehicle").value = "Car";
        }
        function bookPickup(){
            document.getElementById("form4-l").scrollIntoView({behavior: 'smooth'});
            document.getElementById("typeVehicle").value = "Pickup";
        }
    </script>
    <script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0&libraries=places&callback=initGoogle"></script>
    <script src="//maps.googleapis.com/maps/api/js?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0"></script>
</body>
</html>