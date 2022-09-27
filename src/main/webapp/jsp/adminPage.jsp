<%-- 
    Document   : myBookings
    Created on : Sep 16, 2022, 7:11:27 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
      <meta charset="UTF-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="generator" content="homePageAutoRide" />
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:image:src" content="" />
      <meta property="og:image" content="" />
      <meta name="twitter:title" content="Home" />
      <meta
        name="viewport"
        content="width=device-width, initial-scale=1, minimum-scale=1"
      />
      <link
        rel="shortcut icon"
        href="./assets/images/mbr-121x121.png"
        type="image/x-icon"
      />
      <meta name="description" content="" />
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"/>
      <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
      <!-- Material Icons -->
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet"/>
      <!-- CSS Files -->
      <link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet"/>

      <title>Home</title>
            <link
        rel="preload"
        as="style"
        href="./assets/mobirise/css/mbr-additional.css"
      />
      <link
        rel="stylesheet"
        href="./assets/mobirise/css/mbr-additional.css"
        type="text/css"
      />
      <link rel="stylesheet" href="./assets/web/assets/mobirise-icons2/mobirise2.css"/>
      <link rel="stylesheet" href="./assets/web/assets/mobirise-icons/mobirise-icons.css"/>
      <link rel="stylesheet" href="./assets/web/assets/mobirise-icons-bold/mobirise-icons-bold.css"/>
      <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css" />
      <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap-grid.min.css"/>
      <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap-reboot.min.css"/>
      <link rel="stylesheet" href="./assets/dropdown/css/style.css" />
      <link rel="stylesheet" href="./assets/socicon/css/styles.css" />
      <link rel="stylesheet" href="./assets/theme/css/style.css" />
      <link
        rel="preload"
        href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap"
        as="style"
        onload="this.onload=null;this.rel='stylesheet'"
      />
      <noscript
        ><link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,800,900,100i,200i,300i,400i,500i,600i,700i,800i,900i&display=swap"
      /></noscript>

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
            response.setHeader("Pragma","no-cache"); response.setHeader("Expires","0");
            if(session.getAttribute("session")==null){
                response.sendRedirect("adminSignIn.jsp"); 
            }
        %>

        <section
          data-bs-version="5.1"
          class="menu cid-s48OLK6784"
          once="menu"
          id="menu1-h"
        >
        <nav class="navbar navbar-dropdown navbar-fixed-top navbar-expand-lg">
          <div class="container">
            <div class="navbar-brand">
              <span class="navbar-logo">
                <img
                  src="./assets/images/mbr-121x121.png"
                  alt="Auto Ride Logo"
                  style="height: 3.8rem;"
                />
              </span>
              <span class="navbar-caption-wrap"
                ><a
                  class="navbar-caption text-black display-7"
                  href="./jsp/homePage.jsp"
                  >Auto Ride</a
                ></span
              >
            </div>
            <button
              class="navbar-toggler"
              type="button"
              data-toggle="collapse"
              data-bs-toggle="collapse"
              data-target="#navbarSupportedContent"
              data-bs-target="#navbarSupportedContent"
              aria-controls="navbarNavAltMarkup"
              aria-expanded="false"
              aria-label="Toggle navigation"
            >
              <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
              </div>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav nav-dropdown" data-app-modern-menu="true">
                <li class="nav-item">
                  <a
                    class="nav-link link text-black display-4"
                    href="./allUsers"
                    ><span
                      class="mobi-mbri mobi-mbri-browse mbr-iconfont mbr-iconfont-btn"
                    ></span
                    >Users</a
                  >
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link link text-black display-4"
                    href="./allQueries"
                    ><span class="mbrib-info mbr-iconfont mbr-iconfont-btn"></span
                    >Queries</a
                  >
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link link text-black display-4"
                    href="./allBookings"
                    ><span class="mbri-browse mbr-iconfont mbr-iconfont-btn"></span
                    >Bookings</a
                  >
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link link text-black show display-4"
                    href="./reportsData"
                    aria-expanded="true"
                    ><span
                      class="mobi-mbri mobi-mbri-calendar mbr-iconfont mbr-iconfont-btn"
                    ></span
                    >Reports</a
                  >
                </li>
              </ul>
              <form id="logOutForm">
                <div class="navbar-buttons mbr-section-btn">
                  <a class="btn btn-secondary display-4" id="logOut" href="./logOut">Log Out</a>
                </div>
              </form>
            </div>
          </div>
        </nav>
      </section>

      <section
        data-bs-version="5.1"
        class="header1 cid-s48MCQYojq"
        data-bg-video="http://www.youtube.com/watch?v=uNCr7NdOJgw"
        id="header1-f"
      >
        <div
          class="mbr-overlay"
          style="opacity: 0.8; background-color: rgb(255, 255, 255);"
        ></div>
        <div class="align-center container-fluid">
          <div class="row justify-content-center">
            <div class="col-12 col-lg-8">
              <h1
                class="mbr-section-title mbr-fonts-style mb-3 display-1"
                id="HiName"
              >
                  <strong style="color: #FF6666">Hi, Admin</strong>
              </h1>
              <h2 class="mbr-section-title mbr-fonts-style mb-3 display-5" id="ok" style="color: #FF6666">
                Here are some stats
              </h2>
            </div>
          </div>
        </div>
      </section>
      <section>
        <div class="container-fluid py-4">
          <div class="row">
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
              <div class="card">
                <div class="card-header p-3 pt-2">
                  <div
                    class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                    <i class="material-icons opacity-10">weekend</i>
                  </div>
                  <div class="text-end pt-1">
                    <p class="text-sm mb-0 text-capitalize">Total Revenue</p>
                    <h4 class="mb-0" id="totalRevenue">MVR ${totalRevenue}</h4>
                  </div>
                </div>
                <hr class="dark horizontal my-0" />
                <div class="card-footer p-3">
                  <p class="mb-0">
                    <span class="text-success text-sm font-weight-bolder"
                      id="todaysRevenue">MVR ${todaysRevenue}</span
                    > : Today's Revenue
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
              <div class="card">
                <div class="card-header p-3 pt-2">
                  <div
                    class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute"
                  >
                    <i class="material-icons opacity-10">person</i>
                  </div>
                  <div class="text-end pt-1">
                    <p class="text-sm mb-0 text-capitalize">Total Bookings</p>
                    <h4 class="mb-0" id="totalBookings">${totalBookings}</h4>
                  </div>
                </div>
                <hr class="dark horizontal my-0" />
                <div class="card-footer p-3">
                  <p class="mb-0">
                      <span class="text-success text-sm font-weight-bolder" id="todaysBookings">${todaysBookings} </span
                    > : Today's Bookings
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
              <div class="card">
                <div class="card-header p-3 pt-2">
                  <div
                    class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute"
                  >
                    <i class="material-icons opacity-10">person</i>
                  </div>
                  <div class="text-end pt-1">
                    <p class="text-sm mb-0 text-capitalize">Total Distance</p>
                    <h4 class="mb-0" id="totalDistance">${totalDistance} km</h4>
                  </div>
                </div>
                <hr class="dark horizontal my-0" />
                <div class="card-footer p-3">
                  <p class="mb-0">
                      <span class="text-danger text-sm font-weight-bolder" id="todaysDistance">${todaysDistance} km</span>
                     : Today's Distance
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-sm-6">
              <div class="card">
                <div class="card-header p-3 pt-2">
                  <div
                    class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute"
                  >
                    <i class="material-icons opacity-10">weekend</i>
                  </div>
                  <div class="text-end pt-1">
                    <p class="text-sm mb-0 text-capitalize">Total Duration</p>
                    <h4 class="mb-0" id="totalDuration">${totalDuration} mins</h4>
                  </div>
                </div>
                <hr class="dark horizontal my-0" />
                <div class="card-footer p-3">
                  <p class="mb-0">
                      <span class="text-success text-sm font-weight-bolder" id="todaysDuration">${todaysDuration} mins </span
                    > : Today's Duration
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      </<section>
          
          
      </section>
      <section
        data-bs-version="5.1"
        class="content17 cid-tcYqGPaT9g"
        id="content17-p"
      >
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-12 col-md-10">
              <div class="section-head align-center mb-4">
                <h3 class="mbr-section-title mb-0 mbr-fonts-style display-2" style="color: #FF6666">
                  <strong>Toggle FAQ</strong>
                </h3>
              </div>
              <div
                id="bootstrap-toggle"
                class="toggle-panel accordionStyles tab-content"
              >
                <div class="card mb-3">
                  <div class="card-header" role="tab" id="headingOne">
                    <a
                      role="button"
                      class="collapsed panel-title text-black"
                      data-toggle="collapse"
                      data-bs-toggle="collapse"
                      data-core=""
                      href="#collapse1_13"
                      aria-expanded="false"
                      aria-controls="collapse1"
                    >
                      <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7">
                        <strong>How to create new driver accounts?</strong>
                      </h6>
                      <span class="sign mbr-iconfont mbri-arrow-down"></span>
                    </a>
                  </div>
                  <div
                    id="collapse1_13"
                    class="panel-collapse noScroll collapse"
                    role="tabpanel"
                    aria-labelledby="headingOne"
                  >
                    <div class="panel-body">
                      <p class="mbr-fonts-style panel-text display-7">
                        Go to the Users tab and create a driver from there.&nbsp;
                      </p>
                    </div>
                  </div>
                </div>
                <div class="card mb-3">
                  <div class="card-header" role="tab" id="headingTwo">
                    <a
                      role="button"
                      class="collapsed panel-title text-black"
                      data-toggle="collapse"
                      data-bs-toggle="collapse"
                      data-core=""
                      href="#collapse2_13"
                      aria-expanded="false"
                      aria-controls="collapse2"
                    >
                      <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7">
                        <strong>In which areas do Auto Ride operate?</strong>
                      </h6>
                      <span class="sign mbr-iconfont mbri-arrow-down"></span>
                    </a>
                  </div>
                  <div
                    id="collapse2_13"
                    class="panel-collapse noScroll collapse"
                    role="tabpanel"
                    aria-labelledby="headingTwo"
                  >
                    <div class="panel-body">
                      <p class="mbr-fonts-style panel-text display-7">
                        We currently operate in the Greater Male Region. We are
                        working on expanding our services to other islands within
                        the upcoming years.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="card mb-3">
                  <div class="card-header" role="tab" id="headingThree">
                    <a
                      role="button"
                      class="collapsed panel-title text-black"
                      data-toggle="collapse"
                      data-bs-toggle="collapse"
                      data-core=""
                      href="#collapse3_13"
                      aria-expanded="false"
                      aria-controls="collapse3"
                    >
                      <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7">
                        <strong
                          >How to generate payment and booking
                          history?&nbsp;</strong
                        >
                      </h6>
                      <span class="sign mbr-iconfont mbri-arrow-down"></span>
                    </a>
                  </div>
                  <div
                    id="collapse3_13"
                    class="panel-collapse noScroll collapse"
                    role="tabpanel"
                    aria-labelledby="headingThree"
                  >
                    <div class="panel-body">
                      <p class="mbr-fonts-style panel-text display-7">
                        You can generate your booking history by clicking on My
                        Bookings.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="card mb-3">
                  <div class="card-header" role="tab" id="headingThree">
                    <a
                      role="button"
                      class="collapsed panel-title text-black"
                      data-toggle="collapse"
                      data-bs-toggle="collapse"
                      data-core=""
                      href="#collapse4_13"
                      aria-expanded="false"
                      aria-controls="collapse4"
                    >
                      <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7">
                        <strong>How to contact us?</strong>
                      </h6>
                      <span class="sign mbr-iconfont mbri-arrow-down"></span>
                    </a>
                  </div>
                  <div
                    id="collapse4_13"
                    class="panel-collapse noScroll collapse"
                    role="tabpanel"
                    aria-labelledby="headingThree"
                  >
                    <div class="panel-body">
                      <p class="mbr-fonts-style panel-text display-7">
                        You can contact us via the help page.
                      </p>
                    </div>
                  </div>
                </div>
                <div class="card mb-3">
                  <div class="card-header" role="tab" id="headingThree">
                    <a
                      role="button"
                      class="collapsed panel-title text-black"
                      data-toggle="collapse"
                      data-bs-toggle="collapse"
                      data-core=""
                      href="#collapse5_13"
                      aria-expanded="false"
                      aria-controls="collapse5"
                    >
                      <h6 class="panel-title-edit mbr-fonts-style mb-0 display-7">
                        <strong>How do i deactivate my account?</strong>
                      </h6>
                      <span
                        class="mbr-iconfont mobi-mbri-arrow-down mobi-mbri"
                      ></span>
                    </a>
                  </div>
                  <div
                    id="collapse5_13"
                    class="panel-collapse noScroll collapse"
                    role="tabpanel"
                    aria-labelledby="headingThree"
                  >
                    <div class="panel-body">
                      <p class="mbr-fonts-style panel-text display-7">
                        Go to my profile and click on deactivate account.
                      </p>
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
          <div class="google-map">
            <iframe
              frameborder="0"
              style="border:0"
              src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBzKfAnJIEIM6tjK_lA0g-zgMyKrjr2sf0&amp;q=villa college"
              allowfullscreen=""
            ></iframe>
          </div>
        </div>
      </section>

      <section
        class="display-7"
        style="padding: 0;align-items: center;justify-content: center;flex-wrap: wrap;    align-content: center;display: flex;position: relative;height: 4rem;"
      >
        <a
          href="https://mobiri.se/"
          onclick="return false;"
          style="flex: 1 1;height: 4rem;position: absolute;width: 100%;z-index: 1;"
        >
          <img
            alt=""
            style="height: 4rem;"
            src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
          />
        </a>
        <p style="margin: 0;text-align: center;" class="display-7">
          © Copyright 2022 Auto Ride. All Rights Reserved.
        </p>
        <a href="https://mobirise" onclick="return false;"></a>
      </section>

      <!--Modal-->
      <div
        class="modal fade"
        id="location-modal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="location-modal"
        aria-hidden="true"
      >
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header bg-info text-white">
              <h5 class="modal-title" id="address-label">Choose Location</h5>
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="close"
              >
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
      <script src="./assets/bootstrap/js/bootstrap.bundle.min.js"></script>
      <script src="./assets/smoothscroll/smooth-scroll.js"></script>
      <script src="./assets/ytplayer/index.js"></script>
      <script src="./assets/vimeoplayer/player.js"></script>
      <script src="./assets/embla/embla.min.js"></script>
      <script src="./assets/embla/script.js"></script>
      <script src="./assets/mbr-switch-arrow/mbr-switch-arrow.js"></script>
      <script src="./assets/dropdown/js/navbar-dropdown.js"></script>
      <script src="./assets/theme/js/script.js"></script>
      <script src="./assets/formoid/formoid.min.js"></script>

      <script>
        if(performance.navigation.type === 2){
           location.reload(true);
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
        
        let type = getCookie("type");
        if (type!=="admin"){
            document.forms[0].action="../logOut";
            document.forms[0].submit();
        }
        </script>
    </body>
</html>