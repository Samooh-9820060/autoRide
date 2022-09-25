<%-- 
    Document   : signIn
    Created on : Sep 9, 2022, 10:15:49 AM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link
      rel="apple-touch-icon"
      sizes="76x76"
      href="../assets/images/mbr-121x121.png"
    />
    <link rel="icon" type="image/png" href="../assets/images/mbr-121x121.png" />
    <title>Sign In</title>
    <!--     Fonts and icons     -->
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
      rel="stylesheet"
    />
    <!-- Nucleo Icons -->
    <link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
    <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script
      src="https://kit.fontawesome.com/42d5adcbca.js"
      crossorigin="anonymous"
    ></script>
    <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link
      id="pagestyle"
      href="../assets/css/soft-ui-dashboard.css?v=1.0.6"
      rel="stylesheet"
    />
  </head>

  <body class="">
    <div class="container position-sticky z-index-sticky top-0">
      <div class="row">
        <div class="col-12">
          <!-- Navbar -->
          <nav
            class="navbar navbar-expand-lg blur blur-rounded top-0 z-index-3 shadow position-absolute my-3 py-2 start-0 end-0 mx-4"
          >
            <div class="container-fluid pe-0">
              <a
                class="navbar-brand font-weight-bolder ms-lg-0 ms-3"
                href="../jsp/signIn.jsp"
              >
                <span>
                  <img
                    src="../assets/images/mbr-121x121.png"
                    alt="Auto Ride Logo"
                    style="height: 3.2rem"
                  />
                  Auto Ride
                </span>
              </a>
              <button
                class="navbar-toggler shadow-none ms-2"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navigation"
                aria-controls="navigation"
                aria-expanded="false"
                aria-label="Toggle navigation"
              >
                <span class="navbar-toggler-icon mt-2">
                  <span class="navbar-toggler-bar bar1"></span>
                  <span class="navbar-toggler-bar bar2"></span>
                  <span class="navbar-toggler-bar bar3"></span>
                </span>
              </button>
              <div class="collapse navbar-collapse" id="navigation">
                <ul class="navbar-nav mx-auto ms-xl-auto me-xl-7"></ul>
                <li class="nav-item d-flex align-items-center">
                  <a
                    class="btn btn-round btn-sm mb-0 btn-outline-primary me-2"
                    href="../index.html"
                    >Sign Up</a
                  >
                </li>
                <ul class="navbar-nav d-lg-block d-none">
                  <li class="nav-item">
                    <a
                      href="../jsp/signIn.jsp"
                      class="btn btn-sm btn-round mb-0 me-1 bg-gradient-dark"
                      >Sign In</a
                    >
                  </li>
                </ul>
              </div>
            </div>
          </nav>
          <!-- End Navbar -->
        </div>
      </div>
    </div>
    <main class="main-content mt-0">
      <section>
        <div class="page-header min-vh-75">
          <div class="container">
            <div class="row">
              <div
                class="col-xl-4 col-lg-5 col-md-6 d-flex flex-column mx-auto"
              >
                <div class="card card-plain mt-8">
                  <div class="card-header pb-0 text-left bg-transparent">
                    <h3 class="font-weight-bolder text-info text-gradient">
                      Welcome back
                    </h3>
                    <p class="mb-0">Enter your email and password to sign in</p>
                  </div>
                  <div class="card-body">
                    <form id="login" method="POST" action="../logIn">
                      <label>Email</label>
                      <div class="mb-3">
                        <input
                          type="email"
                          class="form-control"
                          id="email" 
                          name="signInEmail"
                          required data-validation-required-message="Please enter your email address."
                          placeholder="Email"
                          aria-label="Email"
                          aria-describedby="email-addon"
                        />
                      </div>
                      <label>Password</label>
                      <div class="mb-3">
                        <input
                          type="password"
                          class="form-control"
                          id="password" 
                          name="signInPassword" 
                          required data-validation-required-message="Please enter your password"
                          placeholder="Password"
                          aria-label="Password"
                          aria-describedby="password-addon"
                        />
                      </div>
                      <div class="text-center">
                        <button
                          type="submit"
                          class="btn bg-gradient-info w-100 mt-4 mb-0"
                        >Sign in
                        </button>
                      </div>
                    </form>
                  </div>
                  <div class="card-footer text-center pt-0 px-lg-2 px-1">
                    <p class="mb-4 text-sm mx-auto">
                      Don't have an account?
                      <a
                        href="../index.html"
                        class="text-info text-gradient font-weight-bold"
                        >Sign up</a
                      >
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div
                  class="oblique position-absolute top-0 h-100 d-md-block d-none me-n8"
                >
                  <div
                    class="oblique-image bg-cover position-absolute fixed-top ms-auto h-100 z-index-0 ms-n6"
                    style="
                      background-image: url('../assets/images/1.jpg');
                    "
                  ></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
    <!-- -------- START FOOTER ------- -->
    <footer class="footer py-5">
      <div class="container">
        <div class="row">
          <div class="col-8 mx-auto text-center mt-1">
            <p class="mb-0 text-secondary">
              <br/><br/>Copyright ©
              <script>
                document.write(new Date().getFullYear());
              </script>
              Auto Ride.
            </p>
          </div>
        </div>
      </div>
    </footer>
    <!-- -------- END FOOTER ------- -->
    <!--   Core JS Files   -->
    <script src="../assets/js/core/popper.min.js"></script>
    <script src="../assets/js/core/bootstrap.min.js"></script>
    <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
    <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
    <script>
      var win = navigator.platform.indexOf("Win") > -1;
      if (win && document.querySelector("#sidenav-scrollbar")) {
        var options = {
          damping: "0.5",
        };
        Scrollbar.init(document.querySelector("#sidenav-scrollbar"), options);
      }
    </script>
  </body>
</html>
