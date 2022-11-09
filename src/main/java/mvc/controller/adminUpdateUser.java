/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author samoo
 */

public class adminUpdateUser extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String userType = request.getParameter("userType").trim();
            if (userType.equals("1")) {
                // Passenger

                // get data from the form
                String firstNameNew = request.getParameter("firstNameInput");
                String lastNameNew = request.getParameter("lastNameInput");
                String mobileNumberNew = request.getParameter("mobileNumberInput");
                String idCardNumberNew = request.getParameter("idCardNumberInput");
                String addressNew = request.getParameter("addressInput");
                String postalCodeNew = request.getParameter("postCodeInput");
                String districtNew = request.getParameter("districtInput");
                String islandNew = request.getParameter("islandInput");
                String emailNew = request.getParameter("emailInput");
                String emergencyContactNameNew = request.getParameter("emergencyContactNameInput");
                String emergencyContactNumberNew = request.getParameter("emergencyContactNumberInput");
                String userID = request.getParameter("userID").trim();

                // separate blank values and values that needs to change
                String blankValue = "-";
                if (idCardNumberNew.isBlank()) {
                    idCardNumberNew = blankValue;
                }
                if (addressNew.isBlank()) {
                    addressNew = blankValue;
                }
                if (postalCodeNew.isBlank()) {
                    postalCodeNew = blankValue;
                }
                if (districtNew.isBlank()) {
                    districtNew = blankValue;
                }
                if (islandNew.isBlank()) {
                    islandNew = blankValue;
                }
                if (emergencyContactNameNew.isBlank()) {
                    emergencyContactNameNew = blankValue;
                }
                if (emergencyContactNumberNew.isBlank()) {
                    emergencyContactNumberNew = "0";
                }

                String mail = getUserMail(userID);
                String currentMobile = getUserMobile(mail);
                String currentUserID = userID;
                String currentEmail = mail;

                Cookie cookie = new Cookie("statusUpdateAdmin", "NA");

                // verify if there is repeats and udpate
                if ((currentMobile.equals(mobileNumberNew)) && (currentEmail.equals(emailNew))) {
                    populateDatabase(currentUserID, firstNameNew, lastNameNew, Integer.parseInt(mobileNumberNew),
                            idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew,
                            emergencyContactNameNew, emergencyContactNumberNew);
                    response.sendRedirect("./allUsers");
                } else if ((currentMobile.equals(mobileNumberNew)) && (!currentEmail.equals(emailNew))) {
                    int repeatValue = checkMailRepeat(emailNew);
                    if (repeatValue == 0) {
                        populateDatabase(currentUserID, firstNameNew, lastNameNew, Integer.parseInt(mobileNumberNew),
                                idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew,
                                emergencyContactNameNew, emergencyContactNumberNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                } else if ((!currentMobile.equals(mobileNumberNew)) && (currentEmail.equals(emailNew))) {
                    int repeatValue = checkPhoneRepeat(mobileNumberNew);
                    if (repeatValue == 0) {
                        populateDatabase(currentUserID, firstNameNew, lastNameNew, Integer.parseInt(mobileNumberNew),
                                idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew,
                                emergencyContactNameNew, emergencyContactNumberNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                } else {
                    int repeatValue = checkRepeat(emailNew, Integer.parseInt(mobileNumberNew));
                    if (repeatValue == 0) {
                        populateDatabase(currentUserID, firstNameNew, lastNameNew, Integer.parseInt(mobileNumberNew),
                                idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew,
                                emergencyContactNameNew, emergencyContactNumberNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                }
            } else if (userType.equals("2")) {
                // get details from form (Driver)
                String firstNameNew = request.getParameter("firstNameInput");
                String lastNameNew = request.getParameter("lastNameInput");
                String mobileNumberNew = request.getParameter("mobileNumberInput");
                String idCardNumberNew = request.getParameter("idCardNumberInput");
                String addressNew = request.getParameter("addressInput");
                String postalCodeNew = request.getParameter("postCodeInput");
                String districtNew = request.getParameter("districtInput");
                String islandNew = request.getParameter("islandInput");
                String emailNew = request.getParameter("emailInput");
                String emergencyContactNameNew = request.getParameter("emergencyContactNameInput");
                String emergencyContactNumberNew = request.getParameter("emergencyContactNumberInput");
                String vehicleTypeNew = getVehicleID(request.getParameter("vehicleTypeInput"));
                String vehicleRegNoNew = request.getParameter("vehicleRegNoInput");
                String licenseNoNew = request.getParameter("licenseNoInput");
                String userID = request.getParameter("userID").trim();

                String blankValue = "-";
                if (postalCodeNew.isBlank()) {
                    postalCodeNew = blankValue;
                }
                if (districtNew.isBlank()) {
                    districtNew = blankValue;
                }
                if (islandNew.isBlank()) {
                    islandNew = blankValue;
                }

                String mail = getUserMail(userID);
                String currentMobile = getUserMobile(mail);
                String currentUserID = userID;
                String currentEmail = mail;

                Cookie cookie = new Cookie("statusUpdateAdmin", "NA");
                // verify repeats and udpate data
                if ((currentMobile.equals(mobileNumberNew)) && (currentEmail.equals(emailNew))) {
                    populateDriverDatabase(currentUserID, firstNameNew, lastNameNew, Integer.parseInt(mobileNumberNew),
                            idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew,
                            emergencyContactNameNew, emergencyContactNumberNew, vehicleTypeNew, vehicleRegNoNew,
                            licenseNoNew);
                    response.sendRedirect("./allUsers");
                } else if ((currentMobile.equals(mobileNumberNew)) && (!currentEmail.equals(emailNew))) {
                    int repeatValue = checkMailRepeat(emailNew);
                    if (repeatValue == 0) {
                        populateDriverDatabase(currentUserID, firstNameNew, lastNameNew,
                                Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew,
                                districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew,
                                vehicleTypeNew, vehicleRegNoNew, licenseNoNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                } else if ((!currentMobile.equals(mobileNumberNew)) && (currentEmail.equals(emailNew))) {
                    int repeatValue = checkPhoneRepeat(mobileNumberNew);
                    if (repeatValue == 0) {
                        populateDriverDatabase(currentUserID, firstNameNew, lastNameNew,
                                Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew,
                                districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew,
                                vehicleTypeNew, vehicleRegNoNew, licenseNoNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                } else {
                    int repeatValue = checkRepeat(emailNew, Integer.parseInt(mobileNumberNew));
                    if (repeatValue == 0) {
                        populateDriverDatabase(currentUserID, firstNameNew, lastNameNew,
                                Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew,
                                districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew,
                                vehicleTypeNew, vehicleRegNoNew, licenseNoNew);
                        response.sendRedirect("./allUsers");
                    } else {
                        cookie.setValue("RepeatedPassengerAdminUpdate");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                    }
                }
            }
        }
    }

    // funcction to add all data to database for passengers
    private void populateDatabase(String userId, String firstName, String lastName, int phoneNumber, String idNumber,
            String address, String postalCode, String district, String island, String emailValue,
            String emergencyContactName, String emergencyContactNumber) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        String updateString = "UPDATE USERDETAILS SET FIRSTNAME='" + firstName + "', LASTNAME='" + lastName
                + "', PHONENUMBER=" + phoneNumber + ", IDNUMBER='" + idNumber + "', ADDRESS='" + address
                + "', POSTALCODE='" + postalCode + "', DISTRICT='" + district + "', ISLAND='" + island + "', EMAIL='"
                + emailValue + "', EMERGENCYCONTACTNAME='" + emergencyContactName + "', EMERGENCYCONTACTNUMBER="
                + emergencyContactNumber + "  where USERID='" + userId + "'";
        statement.executeUpdate(updateString);
    }

    // function to add data to database for drivers
    private void populateDriverDatabase(String userId, String firstName, String lastName, int phoneNumber,
            String idNumber, String address, String postalCode, String district, String island, String emailValue,
            String emergencyContactName, String emergencyContactNumber, String vehicleType, String vehicleRegNo,
            String licenseNo) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        String updateString = "UPDATE USERDETAILS SET FIRSTNAME='" + firstName + "', LASTNAME='" + lastName
                + "', PHONENUMBER=" + phoneNumber + ", IDNUMBER='" + idNumber + "', ADDRESS='" + address
                + "', POSTALCODE='" + postalCode + "', DISTRICT='" + district + "', ISLAND='" + island + "', EMAIL='"
                + emailValue + "', EMERGENCYCONTACTNAME='" + emergencyContactName + "', EMERGENCYCONTACTNUMBER="
                + emergencyContactNumber + ", VEHICLETYPE='" + vehicleType + "', VEHICLEREGNO='" + vehicleRegNo
                + "', LICENSENO='" + licenseNo + "'  where USERID='" + userId + "'";
        statement.executeUpdate(updateString);
        // statement.executeUpdate("INSERT INTO USERDETAILS
        // (USERID,FIRSTNAME,LASTNAME,PASSWORD,PHONENUMBER,IDNUMBER,ADDRESS,POSTALCODE,DISTRICT,ISLAND,EMAIL,EMERGENCYCONTACTNAME,EMERGENCYCONTACTNUMBER,USERTYPE,VEHICLETYPE)
        // VALUES ('"+userId+"', '"+firstName+"', '"+lastName+"', '"+password+"',
        // "+phoneNumber+", '"+idNumber+"', '"+address+"', '"+postalCode+"',
        // '"+district+"', '"+island+"', '"+emailValue+"', '"+emergencyContactName+"',
        // "+emergencyContactNumber+", '"+userType+"', '"+vehicleType+"')");

    }

    // function to get mobile number of user by searching with mail
    private String getUserMobile(String mail) throws SQLException {
        String phoneNumberValue = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PHONENUMBER FROM USERDETAILS");
        while (resultSet.next()) {
            String email = (String) resultSet.getObject(1);
            String phoneNumber = resultSet.getObject(2).toString();
            if (email.equals(mail)) {
                phoneNumberValue = phoneNumber;
            }
        }

        return phoneNumberValue;
    }

    // function to get user email by id
    private String getUserMail(String id) throws SQLException {
        String emailValue = "PA1";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        while (resultSet.next()) {
            String userId = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);

            if (id.equals(userId)) {
                emailValue = email;
            }
        }

        return emailValue;
    }

    // function to get vehicle id by name
    private String getVehicleID(String name) throws SQLException {
        String idValue = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");
        while (resultSet.next()) {
            String vehicleID = (String) resultSet.getObject(1);
            String vehicleName = (String) resultSet.getObject(2);

            if (vehicleName.equals(name)) {
                idValue = vehicleID;
            }
        }

        return idValue;
    }

    // check if the user entered email or phone numbers is repeated
    public int checkRepeat(String email, int phoneNumber) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PHONENUMBER FROM USERDETAILS");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();

        // loop through the selected data in the database
        while (resultSet.next()) {
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                int resultPhone = Integer.parseInt(resultSet.getObject(i + 1).toString());

                if ((resultEmail.equalsIgnoreCase(email)) && (resultPhone == phoneNumber)) {
                    return 3;
                } else if (resultEmail.equalsIgnoreCase(email)) {
                    return 2;
                } else if (resultPhone == phoneNumber) {
                    return 1;
                }
                i++;
            }
        }
        return 0;
    }

    // check if the mail has been repeated in database
    private int checkMailRepeat(String mail) throws SQLException {
        int value = 0;

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL FROM USERDETAILS");

        // loop through the selected data in the database
        while (resultSet.next()) {
            String email = resultSet.getObject(1).toString();

            if (email.equalsIgnoreCase(mail)) {
                value = 1;
            }
        }

        return value;
    }

    // check if the phone number has been repeated in the database
    private int checkPhoneRepeat(String phoneNumber) throws SQLException {
        int value = 0;

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT PHONENUMBER FROM USERDETAILS");

        // loop through the selected data in the database
        while (resultSet.next()) {
            String phone = resultSet.getObject(1).toString();

            if (phone.equalsIgnoreCase(phoneNumber)) {
                value = 1;
            }
        }

        return value;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(adminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(adminUpdateUser.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
