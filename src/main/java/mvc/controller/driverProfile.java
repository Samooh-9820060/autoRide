/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mvc.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author samoo
 */
public class driverProfile extends HttpServlet {

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

            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            String driverIDString = getDriverID(mail);
            String driverVehicle = vehicleType(getDriverVehicle(driverIDString));

            String firstName = null;
            String lastName = null;
            String mobileNumber = null;
            String idCardNumber = null;
            String address = null;
            String postalCode = "";
            String district = "";
            String island = "";
            String eMail = mail;
            String emergencyContactName = null;
            String emergencyContactNumber = null;
            String vehicleType = driverVehicle;
            String vehicleRegNo = null;
            String licenseNo = null;

            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                    "password");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(
                    "SELECT USERID, FIRSTNAME, LASTNAME, PHONENUMBER, IDNUMBER, ADDRESS, POSTALCODE, DISTRICT, ISLAND, EMERGENCYCONTACTNAME, EMERGENCYCONTACTNUMBER, VEHICLEREGNO, LICENSENO FROM USERDETAILS");
            while (resultSet.next()) {
                String userID = resultSet.getObject(1).toString();
                if (userID.equalsIgnoreCase(driverIDString)) {
                    firstName = resultSet.getObject(2).toString().trim();
                    lastName = resultSet.getObject(3).toString().trim();
                    mobileNumber = resultSet.getObject(4).toString().trim();
                    idCardNumber = resultSet.getObject(5).toString().trim();
                    address = resultSet.getObject(6).toString().trim();
                    postalCode = resultSet.getObject(7) + "".trim();
                    district = resultSet.getObject(8) + "".trim();
                    island = resultSet.getObject(9) + "".trim();
                    emergencyContactName = resultSet.getObject(10).toString().trim();
                    emergencyContactNumber = resultSet.getObject(11).toString().trim();
                    vehicleRegNo = resultSet.getObject(12).toString().trim();
                    licenseNo = resultSet.getObject(13).toString().trim();
                }
            }
            // get all data about driver from database
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phoneNumber", mobileNumber);
            request.setAttribute("idNumber", idCardNumber);
            request.setAttribute("address", address);
            request.setAttribute("postalCode", postalCode);
            request.setAttribute("district", district);
            request.setAttribute("island", island);
            request.setAttribute("emergencyContactName", emergencyContactName);
            request.setAttribute("emergencyContactNumber", emergencyContactNumber);
            request.setAttribute("email", eMail);
            request.setAttribute("vehicle", vehicleType);
            request.setAttribute("vehicleRegNo", vehicleRegNo);
            request.setAttribute("licenseNo", licenseNo);

            RequestDispatcher rd = request.getRequestDispatcher("./jsp/viewDriver.jsp");
            rd.forward(request, response);

        }
    }

    private String getDriverID(String mail) throws SQLException {

        // get driver id by mail
        String driverID = "DR1";

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        while (resultSet.next()) {
            String userId = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);

            if (email.equals(mail)) {
                driverID = userId;
            }
        }

        return driverID;
    }

    private String getDriverVehicle(String id) throws SQLException {
        // get driver vehicle by id
        String vehicle = "0";

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, VEHICLETYPE FROM USERDETAILS");
        while (resultSet.next()) {
            String userId = (String) resultSet.getObject(1);
            String vehicleID = (String) resultSet.getObject(2);

            if (userId.equals(id)) {
                vehicle = vehicleID;
            }
        }

        return vehicle;
    }

    private String vehicleType(String receiptVehicleTypeID) throws SQLException {
        // get vehicle type by vehicle id
        String vehicleName = "";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statementVehicles = connection.createStatement();
        ResultSet resultSetVehicles = statementVehicles.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");

        while (resultSetVehicles.next()) {
            String resultVehicleID = resultSetVehicles.getObject(1).toString().trim();
            String resultVehicleName = resultSetVehicles.getObject(2).toString();
            if (receiptVehicleTypeID.equals(resultVehicleID)) {
                vehicleName = resultVehicleName;
            }
        }

        return vehicleName;
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
            Logger.getLogger(driverProfile.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(driverProfile.class.getName()).log(Level.SEVERE, null, ex);
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
