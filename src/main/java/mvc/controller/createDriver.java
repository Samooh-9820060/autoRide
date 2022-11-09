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
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
public class createDriver extends HttpServlet {

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
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // get values from form
            String firstName = request.getParameter("firstNameInput");
            String lastName = request.getParameter("lastNameInput");
            String password = request.getParameter("passwordInput");
            int mobileNumber = Integer.parseInt(request.getParameter("mobileNumberInput"));
            String idCardNumber = request.getParameter("idCardNumberInput");
            String address = request.getParameter("addressInput");
            String postalcode = request.getParameter("postCodeInput");
            String district = request.getParameter("districtInput");
            String island = request.getParameter("islandInput");
            String email = request.getParameter("emailInput");
            String emergencyContactName = request.getParameter("emergencyContactNameInput");
            String emergencyContactNumber = request.getParameter("emergencyContactNumberInput");
            String vehicleType = request.getParameter("vehicleTypeInput").trim();
            String vehicleRegNo = request.getParameter("vehicleRegNoInput");
            String licenseNo = request.getParameter("licenseNoInput");
            int userType = 2;
            int vehicleCode = getVehicleCode(vehicleType);

            Cookie cookie = new Cookie("status", "NA");
            // check for any repeats
            // check if the mail or number has been repeated and show error message if it is
            // repeated else go to login page
            switch (checkRepeat(email, mobileNumber)) {
                case 0:
                    Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide",
                            "username", "password");
                    Statement statement;
                    statement = connection.createStatement();
                    String userID = "DR" + (getLastDriver() + 1);
                    String query = "INSERT INTO USERDETAILS VALUES ('" + userID + "', '" + firstName + "', '" + lastName
                            + "', '" + hashPass(password) + "', " + mobileNumber + ", '" + idCardNumber + "', '"
                            + address + "', '" + postalcode + "', '" + district + "', '" + island + "', '" + email
                            + "', '" + emergencyContactName + "', " + emergencyContactNumber + ", '" + userType + "', '"
                            + vehicleCode + "', '" + vehicleRegNo + "', '" + licenseNo + "')";
                    System.out.println(query);
                    statement.executeUpdate(query);
                    response.sendRedirect("./allUsers");
                    break;
                case 1:
                    cookie.setValue("RepeatedDriver");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                    break;
                case 2:
                    cookie.setValue("RepeatedDriver");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                    break;
                case 3:
                    cookie.setValue("RepeatedDriver");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                    break;
            }
        }
    }

    // hash password in SHA 256 format to store in database
    public String hashPass(String password) throws NoSuchAlgorithmException {
        // function to hash password
        String hashedPass = "";
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        // convert bytes to hexadecimal
        StringBuilder s = new StringBuilder();
        for (byte b : hash) {
            s.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
        }
        hashedPass = s.toString();

        return hashedPass;

    }

    public int getLastDriver() throws SQLException {
        int i = 0;
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERTYPE FROM USERDETAILS");
        while (resultSet.next()) {
            String type = resultSet.getObject(1).toString().trim();
            if (type.equals("2")) {
                i++;
            }
        }
        return i;
    }

    public int getVehicleCode(String vehicleName) throws SQLException {
        // get vehicle id by name
        int i = 0;

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");
        while (resultSet.next()) {
            String name = resultSet.getObject(2).toString();
            if (name.equalsIgnoreCase(vehicleName)) {
                i = Integer.parseInt(resultSet.getObject(1).toString());
            }
        }

        return i;
    }

    // check if the user entered email or phone numbers is repeated
    public int checkRepeat(String email, int phoneNumber) throws SQLException {
        // function to check repeated mail and phone number
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
        } catch (SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(createDriver.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(createDriver.class.getName()).log(Level.SEVERE, null, ex);
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
