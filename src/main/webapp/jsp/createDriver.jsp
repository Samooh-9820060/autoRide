<%-- 
    Document   : createDriver
    Created on : Sep 19, 2022, 7:13:19 PM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>

<head>
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
    <div class="container rounded bg-white mt-2 mb-2">
        <form method="POST" action="createDriver">
            <div class="row">
                <div class="col-md-8 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-center">Create Driver</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <label class="labels">First Name *</label>
                                <input type="text" class="form-control" placeholder="First name" value="">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Last Name*</label>
                                <input type="text" class="form-control" value="" placeholder="Last name">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Password*</label>
                                <input type="password" class="form-control" value="" placeholder="Password">
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Repeat Password*</label>
                                <input type="password" class="form-control" value="" placeholder="Password">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label class="labels">Mobile Number *</label>
                                <input type="text" class="form-control" placeholder="Enter phone number" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">ID Card Number*</label>
                                <input type="text" class="form-control" placeholder="Enter ID Number" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Address *</label>
                                <input type="text" class="form-control" placeholder="Enter Address" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Postcode</label>
                                <input type="text" class="form-control" placeholder="Enter Postal Code" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">District</label>
                                <input type="text" class="form-control" placeholder="Enter District (eg: Henveiru, Galolhu, Maafannu, etc.)" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Island *</label>
                                <input type="text" class="form-control" placeholder="Enter Island (eg: Male', Hulhumale', Villimale')" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Email ID *</label>
                                <input type="text" class="form-control" placeholder="Enter Email Address" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Name *</label>
                                <input type="text" class="form-control" placeholder="Enter Emergency Contact Name" value="">
                            </div>
                            <div class="col-md-12">
                                <label class="labels">Emergency Contact Number *</label>
                                <input type="text" class="form-control" placeholder="Enter Emergency Contact Number" value="">
                            </div>
                        </div>
                        <div class="row mt-3">

                        </div>
                        <div class="mt-5 text-center">
                            <button class="btn btn-danger" type="button">Create</button>
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
                            <select class="form-control">
                                <option>Cycle</option>
                                <option>Car</option>
                                <option>Pickup</option>
                            </select>
                        </div>
                        <br>
                        <div class="col-md-12">
                            <label class="labels">Vehicle Reg No*</label>
                            <input type="text" class="form-control" placeholder="AB0X-1000" value="">
                        </div>
                        <div class="col-md-12">
                            <label class="labels">License No*</label>
                            <input type="text" class="form-control" placeholder="A000000" value="">
                        </div>
                    </div>
                </div>
            </div>
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
    </script>

</body>

</html>
