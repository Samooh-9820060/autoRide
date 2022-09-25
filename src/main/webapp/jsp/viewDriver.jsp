<%-- 
    Document   : createDriver
    Created on : Sep 19, 2022, 7:13:19 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>

<head>
    <script type = "text/javascript">
        function disableBackButton() {
            window.history.forward();
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
        if (getCookie("type")!=="Driver"){
            window.location.href = "../jsp/signIn.jsp";
        }
        
        
        //setTimeout("disableBackButton()", 0);
    </script>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Edit Driver Details</title>
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css' rel='stylesheet'>
    <link href='#' rel='stylesheet'>
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <style>
        ::-webkit-scrollbar {
            width: 8px;
        }
        /* Track */
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        /* Handle */
        
        ::-webkit-scrollbar-thumb {
            background: #888;
        }
        /* Handle on hover */
        
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        body {
            background: #ff8080
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #e3bc6d
        }
        .profile-button {
            background: rgb(255, 188, 3);
            box-shadow: none;
            border: none
        }
        .profile-button:hover {
            background: #ffbc03
        }
        .profile-button:focus {
            background: #ffbc03;
            box-shadow: none
        }
        .profile-button:active {
            background: #ffbc03;
            box-shadow: none
        }
        .back:hover {
            color: #ffbc03;
            cursor: pointer
        }
        .labels {
            font-size: 11px
        }
        .add-experience:hover {
            background: #e3bc6d;
            color: #fff;
            cursor: pointer;
            border: solid 1px #e3bc6d
        }
    </style>
</head>

<body className='snippet-body'>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("../jsp/signIn.jsp");
        }
      %>
    <div class="container rounded bg-white mt-2 mb-2">
            <div class="row">
                <div class="col-md-8 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-center">Driver Details</h4>
                            <p style="color: red">To update anything here contact admin</p>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <label class="labels">First Name</label>
                                <input type="text" id="firstName" class="form-control" value="${firstName}" disabled>
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Last Name</label>
                                <input type="text" id="lastName" class="form-control" value="${lastName}" disabled>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Mobile Number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="mobileNumber" class="form-control" value="${phoneNumber}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">ID Card Number</label>
                                <input type="text" id="IDCardNumber" class="form-control" placeholder="Enter ID Number" value="${idNumber}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Address</label>
                                <input type="text" id="address" class="form-control" value="${address}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Postcode</label>
                                <input type="text" id="postCode" class="form-control" placeholder="Enter Postal Code" value="${postalCode}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">District</label>
                                <input type="text" id="district" class="form-control" value="${district}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Island</label>
                                <input type="text" id="island" class="form-control" value="${island}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Email</label>
                                <input type="email" id="email" class="form-control" value="${email}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Name</label>
                                <input type="text" id="emergencyContactName" class="form-control" value="${emergencyContactName}" disabled>
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="emergencyContactNumber" class="form-control" value="${emergencyContactNumber}" disabled>
                            </div>
                        </div>
                        <div class="row mt-3">

                        </div>
                        <div class="mt-5 text-center">
                            <a href="./driverHomePage" class="btn btn-danger">Back</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center experience"><span>Vehicle & License Details</span><span class="border px-3 p-1 add-experience"><i class="fa fa-plus"></i>&nbsp;Vehicles</span>
                        </div>
                        <br>
                        <div class="col-md-12">
                            <label class="labels">Type</label>
                            <input type="text" id="vehicleType" class="form-control" value="${vehicle}" disabled>
                        </div>
                        <br>
                        <div class="col-md-12">
                            <label class="labels">Vehicle Reg No</label>
                            <input type="text" id="vehicleRegNo" class="form-control" value="${vehicleRegNo}" disabled>
                        </div>
                        <div class="col-md-12">
                            <label class="labels">License No</label>
                            <input type="text" id="licenseNo" class="form-control" value="${licenseNo}" disabled>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    </div>
    </div>
    <script type='text/javascript' src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript' src='#'></script>
    <script type='text/javascript' src='#'></script>
    <script type='text/javascript' src='#'></script>
    <script type='text/javascript'>
        #
    </script>
    <script type='text/javascript'>
        
    </script>

</body>

</html>
