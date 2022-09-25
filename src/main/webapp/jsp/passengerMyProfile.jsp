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
        //setTimeout("disableBackButton()", 0);
    </script>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Edit Profile</title>
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
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg">
                        <span class="font-weight-bold">${firstName} ${lastName}</span>
                        <span class="text-black-50">${email}</span>
                        <span>@${userId}</span>
                        <button style="margin-top: 20px" onclick="deleteAccount()" class="btn btn-dark" type="button">Delete Account</button>
                    </div>
                </div>
                <div class="col-md-9 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-center">Edit Profile</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <label class="labels">First Name *</label>
                                <label id="firstNameError" style="color: red; font-size: 12px;" hidden>First Name can't be empty</label>
                                <input type="text" id="firstName" class="form-control" placeholder="First name" value="${firstName}">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Last Name*</label>
                                <label id="lastNameError" style="color: red; font-size: 12px;" hidden>Last Name can't be empty</label>
                                <input type="text" id="lastName" class="form-control" value="${lastName}" placeholder="Last name">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Mobile Number *</label>
                                <label id="mobileError" style="color: red; font-size: 12px;" hidden>Mobile Number can't be empty</label>
                                <label id="mobileValidationError" style="color: red; font-size: 12px;" hidden>Please enter correct mobile number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="mobileNumber" class="form-control" placeholder="Enter phone number" value="${phoneNumber}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">ID Card Number</label>
                                <input type="text" id="IDCardNumber" class="form-control" placeholder="Enter ID Number" value="${idNumber}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Address</label>
                                <input type="text" id="address" class="form-control" placeholder="Enter Address" value="${address}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Postcode</label>
                                <input type="text" id="postCode" class="form-control" placeholder="Enter Postal Code" value="${postalCode}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">District</label>
                                <input type="text" id="district" class="form-control" placeholder="Enter District (eg: Henveiru, Galolhu, Maafannu, etc.)" value="${district}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Island</label>
                                <input type="text" id="island" class="form-control" placeholder="Enter Island (eg: Male', Hulhumale', Villimale')" value="${island}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Email*</label>
                                <label id="emailError" style="color: red; font-size: 12px;" hidden>Email can't be empty</label>
                                <label id="emailValidationError" style="color: red; font-size: 12px;" hidden>Please enter valid email</label>
                                <input type="email" id="emailValue" class="form-control" placeholder="Enter Email Address" value="${email}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Name</label>
                                <input type="text" id="emergencyContactName" class="form-control" placeholder="Enter Emergency Contact Name" value="${emergencyContactName}">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Number</label>
                                <label id="emergencyNumberValidationError" style="color: red; font-size: 12px;" hidden>Please enter correct Number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="emergencyContactNumber" class="form-control" placeholder="Enter Emergency Contact Number" value="${emergencyContactNumber}">
                            </div>
                        </div>
                        <div class="row mt-3">

                        </div>
                        <div class="mt-5 text-center">
                            <a href="./jsp/homePage.jsp" class="btn btn-danger">Back</a>
                            <button onclick="verifyForm()" class="btn btn-danger" type="button">Update</button>
                        </div>
                    </div>
                </div>
            </div>
            <form id="updatePassengerDetails" method="POST" action="./updatePassenger" hidden>
                <input type="text" id="firstNameInput" name="firstNameInput" value="">
                <input type="text" id="lastNameInput" name="lastNameInput" value="">
                <input type="text" id="mobileNumberInput" name="mobileNumberInput" value="">
                <input type="text" id="idCardNumberInput" name="idCardNumberInput" value="">
                <input type="text" id="addressInput" name="addressInput" value="">
                <input type="text" id="postCodeInput" name="postCodeInput" value="">
                <input type="text" id="districtInput" name="districtInput" value="">
                <input type="text" id="islandInput" name="islandInput" value="">
                <input type="text" id="emailInput" name="emailInput" value="">
                <input type="text" id="emergencyContactNameInput" name="emergencyContactNameInput" value="">
                <input type="text" id="emergencyContactNumberInput" name="emergencyContactNumberInput" value="">
            </form>
            <form id="deleteAccount" method="POST" action="deleteUser" hidden>
                <input type="text" id="deleteUserID" name="deleteUserID" value="${userId}">
                <input type="text" id="type" name="type" value="Passenger">
            </form>
    </div>
    </div>
    </div>
    <script type='text/javascript' src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript' src='#'></script>
    <script type='text/javascript' src='#'></script>
    <script type='text/javascript' src='#'></script>

    <script type='text/javascript'>
        var myLink = document.querySelector('a[href="#"]');
        myLink.addEventListener('click', function(e) {
            e.preventDefault();
        });
        
        function deleteAccount(){
            var form = document.getElementById("deleteAccount");
            form.submit();
        }
        
        function startsWith(str, word) {
            return str.lastIndexOf(word, 0) === 0;
        }
        
        function validateEmail(email) {
            const res = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return res.test(String(email).toLowerCase());
        }
        
        function verifyForm(){
            var i = 1;
            
            //check firstName
            if (document.getElementById("firstName").value===""){
                i = 0;
                document.getElementById("firstNameError").hidden=false;
            } else {
                document.getElementById("firstNameError").hidden=true;                
            }
            
            //check lastName
            if (document.getElementById("lastName").value===""){
                i = 0;
                document.getElementById("lastNameError").hidden=false;
            } else {
                document.getElementById("lastNameError").hidden=true;                
            }
            
            //check mobileNumber
            if (document.getElementById("mobileNumber").value===""){
                i = 0;
                document.getElementById("mobileError").hidden=false;
            } else {
                document.getElementById("mobileError").hidden=true;                
            }
            if ((document.getElementById("mobileNumber").value).length===7){
                if (/^\d+$/.test(document.getElementById("mobileNumber").value)===true){
                    if ((startsWith(document.getElementById("mobileNumber").value,"7")||(startsWith(document.getElementById("mobileNumber").value,"9")))===true){
                        
                    } else {
                        document.getElementById("mobileValidationError").hidden=false;
                        i = 0;
                    }
                } else {
                    document.getElementById("mobileValidationError").hidden=false;
                    i = 0;
                }
            } else {
                document.getElementById("mobileValidationError").hidden=false;
                i = 0;
            }
            
            //check email
            if (document.getElementById("emailValue").value===""){
                i = 0;
                document.getElementById("emailError").hidden=false;
            } else {
                document.getElementById("emailError").hidden=true;                
            }
            if (validateEmail(document.getElementById("emailValue").value)===true){
                document.getElementById("emailValidationError").hidden = true;
            } else {
                i = 0;
                document.getElementById("emailValidationError").hidden=false;
            }
            
            if ((document.getElementById("emergencyContactNumber").value==="")||(document.getElementById("emergencyContactNumber").value==="0")){
                
            } else {
                if ((document.getElementById("emergencyContactNumber").value).length===7){
                    if (/^\d+$/.test(document.getElementById("emergencyContactNumber").value)===true){
                        if ((startsWith(document.getElementById("emergencyContactNumber").value,"7")||(startsWith(document.getElementById("emergencyContactNumber").value,"9")))===true){
                            document.getElementById("emergencyNumberValidationError").hidden=true;
                        } else {
                            document.getElementById("emergencyNumberValidationError").hidden=false;
                            i = 0;
                        }
                    } else {
                        document.getElementById("emergencyNumberValidationError").hidden=false;
                        i = 0;
                    }
                } else {
                    document.getElementById("emergencyNumberValidationError").hidden=false;
                    i = 0;
                }
            }
            
            
            
            if (i===1){
                document.getElementById("firstNameInput").value = document.getElementById("firstName").value;
                document.getElementById("lastNameInput").value = document.getElementById("lastName").value;
                document.getElementById("mobileNumberInput").value = document.getElementById("mobileNumber").value;
                document.getElementById("idCardNumberInput").value = document.getElementById("IDCardNumber").value;
                document.getElementById("addressInput").value = document.getElementById("address").value;
                document.getElementById("postCodeInput").value = document.getElementById("postCode").value;
                document.getElementById("districtInput").value = document.getElementById("district").value;
                document.getElementById("islandInput").value = document.getElementById("island").value;
                document.getElementById("emailInput").value = document.getElementById("emailValue").value;
                document.getElementById("emergencyContactNameInput").value = document.getElementById("emergencyContactName").value;
                document.getElementById("emergencyContactNumberInput").value = document.getElementById("emergencyContactNumber").value;
                var form = document.getElementById("updatePassengerDetails");
                form.submit();
            }
        }
    </script>

</body>

</html>
