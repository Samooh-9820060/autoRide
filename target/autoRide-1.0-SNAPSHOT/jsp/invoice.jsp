<%-- 
    Document   : invoice
    Created on : Sep 9, 2022, 11:59:09 AM
    Author     : samoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <title>Booking Invoice</title>
        <!-- Invoice styling -->
        <style>
            body {
                font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                text-align: center;
                color: #777;
            }
            
            body h1 {
                font-weight: 300;
                margin-bottom: 0px;
                padding-bottom: 0px;
                color: #000;
            }

            body h3 {
                font-weight: 300;
                margin-top: 10px;
                margin-bottom: 20px;
                font-style: italic;
                color: #555;
            }

            body a {
                color: #06f;
            }

            .invoice-box {
                max-width: 800px;
                margin: auto;
                padding: 30px;
                border: 1px solid #eee;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
                font-size: 16px;
                line-height: 24px;
                font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                color: #555;
            }

            .invoice-box table {
                width: 100%;
                line-height: inherit;
                text-align: left;
                border-collapse: collapse;
		}

            .invoice-box table td {
                padding: 5px;
                vertical-align: top;
            }

            .invoice-box table tr td:nth-child(2) {
                text-align: right;
            }

            .invoice-box table tr.top table td {
                padding-bottom: 20px;
            }

            .invoice-box table tr.top table td.title {
                font-size: 45px;
                line-height: 45px;
                color: #333;
            }

            .invoice-box table tr.information table td {
                padding-bottom: 40px;
            }

            .invoice-box table tr.heading td {
                background: #eee;
                border-bottom: 1px solid #ddd;
                font-weight: bold;
            }

            .invoice-box table tr.details td {
                padding-bottom: 20px;
            }

            .invoice-box table tr.item td {
                border-bottom: 1px solid #eee;
            }

            .invoice-box table tr.item.last td {
                border-bottom: none;    
            }

            .invoice-box table tr.total td:nth-child(2) {
                border-top: 2px solid #eee;
                font-weight: bold;
            }

            @media only screen and (max-width: 600px) {
                .invoice-box table tr.top table td {
                    width: 100%;
                    display: block;
                    text-align: center;
                }

                .invoice-box table tr.information table td {
                    width: 100%;
                    display: block;
                    text-align: center;
                }
            }
        </style>
    </head>

    
    <body>
        <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("../jsp/signIn.jsp");
        }
        %>
        <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma","no-cache");
        response.setHeader("Expires","0");
        
        if(session.getAttribute("session")==null){
            response.sendRedirect("./signIn.jsp");
        }
        %>
        <div class="invoice-box">
            <table>
                <tr class="top">
                    <td colspan="2">
                        <table>
                            <tr>
                                <td class="title">
                                    <img src="./assets/images/logo.png" alt="Company logo" style="width: 100%; max-width: 300px" />
                                </td>
                                <td>
                                    <button style="height:30px;width:150px;margin:30px 0px" onclick="goHome()">Back</button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

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
                    
                    function goHome(){
                        var type = getCookie("type");
                        if (type==="admin"){
                            window.location.href = "./allBookings";
                        } else if (type==="Passenger"){
                            window.location.href = "./jsp/homePage.jsp";
                        } else if (type==="Driver"){
                            window.location.href = "./myOrders";
                        }                         
                    }
                    
                </script>

                <tr class="information">
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    Name: ${receiptFullName}<br />
                                    Phone: ${receiptPhoneNumber}<br />
                                    Email: ${receiptMail}
                                </td>
                                <td>
                                    Invoice: ${invoiceNum}<br />
                                    Created: ${receiptOrderDate}<br />
                                    Time: ${receiptOrderTIme}<br />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr class="heading">
                    <td>Order Details</td>
                    
                    <td>Detail</td>
                </tr>

                <tr class="item">
                    <td>Date</td>

                    <td>${receiptDate}</td>
                </tr>
                
                <tr class="item">
                    <td>Time</td>

                    <td>${receiptTime}</td>
                </tr>
                
                <tr class="item">
                    <td>Location</td>

                    <td>${receiptLocation}</td>
                </tr>
                
                <tr class="item">
                    <td>Destination</td>

                    <td>${receiptDestination}</td>
                </tr>
                
                <tr class="item">
                    <td>Vehicle</td>

                    <td>${receiptVehicleType}</td>
                </tr>
                
                <tr class="item">
                    <td>Distance</td>

                    <td>${receiptDistance}</td>
                </tr>
                
                <tr class="item">
                    <td>Duration</td>

                    <td>${receiptDuration}</td>
                </tr>
                <br />
                <tr class="heading">
                    <td>Payment Details</td>

                    <td>Price</td>
                </tr>

                <tr class="item">
                    <td>${receiptVehicleType}</td>

                    <td>MVR ${vehiclePrice}</td>
                </tr>

                <tr class="item">
                    <td>Extra Distance (5.0 km+)</td>

                    <td>MVR ${extraDistancePrice}</td>
                </tr>

                <tr class="total">
                    <td></td>

                    <td>Total: MVR ${totalPrice}</td>
                </tr>
            </table>
        </div>
    </body>
</html>