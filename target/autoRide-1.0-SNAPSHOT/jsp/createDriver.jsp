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
            if (getCookie("type")!=="admin"){
                window.location.href = "../jsp/signIn.jsp";
            }
        //setTimeout("disableBackButton()", 0);
    </script>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Create Driver</title>
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
            response.sendRedirect("../jsp/adminSignIn.jsp");
        }
      %>
    <div class="container rounded bg-white mt-2 mb-2">
            <div class="row">
                <div class="col-md-8 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-center">Create Driver</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <label class="labels">First Name *</label>
                                <label id="firstNameError" style="color: red; font-size: 12px;" hidden>First Name can't be empty</label>
                                <input type="text" id="firstName" class="form-control" placeholder="First name" value="">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Last Name*</label>
                                <label id="lastNameError" style="color: red; font-size: 12px;" hidden>Last Name can't be empty</label>
                                <input type="text" id="lastName" class="form-control" value="" placeholder="Last name">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Password*</label>
                                <label id="passwordOneError" style="color: red; font-size: 12px;" hidden>Password can't be empty</label>
                                <input type="password" id="passwordOne" class="form-control" value="" placeholder="Password">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Repeat Password*</label>
                                <label id="passwordTwoError" style="color: red; font-size: 12px;" hidden>Password can't be empty</label>
                                <label id="passwordNotMatchError" style="color: red; font-size: 12px;" hidden>Password does not match</label>
                                <input type="password" id="passwordTwo" class="form-control" value="" placeholder="Password">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Mobile Number *</label>
                                <label id="mobileError" style="color: red; font-size: 12px;" hidden>Mobile Number can't be empty</label>
                                <label id="mobileValidationError" style="color: red; font-size: 12px;" hidden>Please enter correct mobile number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="mobileNumber" class="form-control" placeholder="Enter phone number" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">ID Card Number*</label>
                                <label id="idCardError" style="color: red; font-size: 12px;" hidden>ID Card Number can't be empty</label>
                                <input type="text" id="IDCardNumber" class="form-control" placeholder="Enter ID Number" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Address *</label>
                                <label id="addressError" style="color: red; font-size: 12px;" hidden>Address can't be empty</label>
                                <input type="text" id="address" class="form-control" placeholder="Enter Address" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Postcode</label>
                                <input type="text" id="postCode" class="form-control" placeholder="Enter Postal Code" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">District</label>
                                <input type="text" id="district" class="form-control" placeholder="Enter District (eg: Henveiru, Galolhu, Maafannu, etc.)" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Island</label>
                                <input type="text" id="island" class="form-control" placeholder="Enter Island (eg: Male', Hulhumale', Villimale')" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Email*</label>
                                <label id="emailError" style="color: red; font-size: 12px;" hidden>Email can't be empty</label>
                                <label id="emailValidationError" style="color: red; font-size: 12px;" hidden>Please enter valid email</label>
                                <input type="email" id="email" class="form-control" placeholder="Enter Email Address" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Name *</label>
                                <label id="emergencyNameError" style="color: red; font-size: 12px;" hidden>Emergency Contact Name can't be empty</label>
                                <input type="text" id="emergencyContactName" class="form-control" placeholder="Enter Emergency Contact Name" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Number *</label>
                                <label id="emergencyNumberError" style="color: red; font-size: 12px;" hidden>Emergency Contact Number can't be empty</label>
                                <label id="emergencyNumberValidationError" style="color: red; font-size: 12px;" hidden>Please enter correct Number</label>
                                <input type="tel" pattern = "[7-9]{1}[0-9]{6}" id="emergencyContactNumber" class="form-control" placeholder="Enter Emergency Contact Number" value="">
                            </div>
                        </div>
                        <div class="row mt-3">

                        </div>
                        <div class="mt-5 text-center">
                            <a href="../allUsers" class="btn btn-danger">Back</a>
                            <button onclick="verifyForm()" class="btn btn-danger" type="button">Create</button>
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
                            <select class="form-control" id="vehicle">
                                <option value="Cycle">Cycle</option>
                                <option value="Car">Car</option>
                                <option value="Pickup">Pickup</option>
                            </select>
                        </div>
                        <br>
                        <div class="col-md-12">
                            <label class="labels">Vehicle Reg No*</label>
                            <label id="vehicleRegError" style="color: red; font-size: 12px;" hidden>Vehicle Register Number can't be empty</label>
                            <input type="text" id="vehicleRegNo" class="form-control" placeholder="AB0X-1000" value="">
                        </div>
                        <div class="col-md-12">
                            <label class="labels">License No*</label>
                            <label id="licenseNoError" style="color: red; font-size: 12px;" hidden>License Number can't be empty</label>
                            <input type="text" id="licenseNo" class="form-control" placeholder="A000000" value="">
                        </div>
                    </div>
                </div>
            </div>
        <form id="createDriverFunction" method="POST" action="../createDriver" hidden>
            <input type="text" id="firstNameInput" name="firstNameInput" value="">
            <input type="text" id="lastNameInput" name="lastNameInput" value="">
            <input type="text" id="passwordInput" name="passwordInput" value="">
            <input type="text" id="mobileNumberInput" name="mobileNumberInput" value="">
            <input type="text" id="idCardNumberInput" name="idCardNumberInput" value="">
            <input type="text" id="addressInput" name="addressInput" value="">
            <input type="text" id="postCodeInput" name="postCodeInput" value="">
            <input type="text" id="districtInput" name="districtInput" value="">
            <input type="text" id="islandInput" name="islandInput" value="">
            <input type="text" id="emailInput" name="emailInput" value="">
            <input type="text" id="emergencyContactNameInput" name="emergencyContactNameInput" value="">
            <input type="text" id="emergencyContactNumberInput" name="emergencyContactNumberInput" value="">
            <input type="text" id="vehicleTypeInput" name="vehicleTypeInput" value="">
            <input type="text" id="vehicleRegNoInput" name="vehicleRegNoInput" value="">
            <input type="text" id="licenseNoInput" name="licenseNoInput" value="">
        </form>
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
        var myLink = document.querySelector('a[href="#"]');
        myLink.addEventListener('click', function(e) {
            e.preventDefault();
        });
        
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
            
            //check passwordOne
            if (document.getElementById("passwordOne").value===""){
                i = 0;
                document.getElementById("passwordOneError").hidden=false;
            } else {
                document.getElementById("passwordOneError").hidden=true;                
            }
            
            //check passwordTwo
            if (document.getElementById("passwordTwo").value===""){
                i = 0;
                document.getElementById("passwordTwoError").hidden=false;
            } else {
                document.getElementById("passwordTwoError").hidden=true;                
            }
            
            //check for repeated password
            if (document.getElementById("passwordOne").value!==document.getElementById("passwordTwo").value){
                i = 0;
                document.getElementById("passwordNotMatchError").hidden=false;
            } else {
                document.getElementById("passwordNotMatchError").hidden=true;
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
            
            //check IDNumber
            if (document.getElementById("IDCardNumber").value===""){
                i = 0;
                document.getElementById("idCardError").hidden=false;
            } else {
                document.getElementById("idCardError").hidden=true;                
            }
            
            //check address
            if (document.getElementById("address").value===""){
                i = 0;
                document.getElementById("addressError").hidden=false;
            } else {
                document.getElementById("addressError").hidden=true;                
            }
            
            //check email
            if (document.getElementById("email").value===""){
                i = 0;
                document.getElementById("emailError").hidden=false;
            } else {
                document.getElementById("emailError").hidden=true;                
            }
            if (validateEmail(document.getElementById("email").value)===true){
                document.getElementById("emailValidationError").hidden = true;
            } else {
                i = 0;
                document.getElementById("emailValidationError").hidden=false;
            }
            
            //check emergencyName
            if (document.getElementById("emergencyContactName").value===""){
                i = 0;
                document.getElementById("emergencyNameError").hidden=false;
            } else {
                document.getElementById("emergencyNameError").hidden=true;                
            }
            
            //check emergencyNumber
            if (document.getElementById("emergencyContactNumber").value===""){
                i = 0;
                document.getElementById("emergencyNumberError").hidden=false;
            } else {
                document.getElementById("emergencyNumberError").hidden=true;                
            }
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
            
            //check vehicleRegNo
            if (document.getElementById("vehicleRegNo").value===""){
                i = 0;
                document.getElementById("vehicleRegError").hidden=false;
            } else {
                document.getElementById("vehicleRegError").hidden=true;                
            }
            
            //check licenseNo
            if (document.getElementById("licenseNo").value===""){
                i = 0;
                document.getElementById("licenseNoError").hidden=false;
            } else {
                document.getElementById("licenseNoError").hidden=true;                
            }
            
            if (i===1){
                document.getElementById("firstNameInput").value = document.getElementById("firstName").value;
                document.getElementById("lastNameInput").value = document.getElementById("lastName").value;
                document.getElementById("passwordInput").value = document.getElementById("passwordOne").value;
                document.getElementById("mobileNumberInput").value = document.getElementById("mobileNumber").value;
                document.getElementById("idCardNumberInput").value = document.getElementById("IDCardNumber").value;
                document.getElementById("addressInput").value = document.getElementById("address").value;
                document.getElementById("postCodeInput").value = document.getElementById("postCode").value;
                document.getElementById("districtInput").value = document.getElementById("district").value;
                document.getElementById("islandInput").value = document.getElementById("island").value;
                document.getElementById("emailInput").value = document.getElementById("email").value;
                document.getElementById("emergencyContactNameInput").value = document.getElementById("emergencyContactName").value;
                document.getElementById("emergencyContactNumberInput").value = document.getElementById("emergencyContactNumber").value;
                document.getElementById("vehicleTypeInput").value = document.getElementById("vehicle").value;
                document.getElementById("vehicleRegNoInput").value = document.getElementById("vehicleRegNo").value;
                document.getElementById("licenseNoInput").value = document.getElementById("licenseNo").value;
                
                var form = document.getElementById("createDriverFunction");
                form.submit();
            }
            
        }
    </script>

</body>

</html>
