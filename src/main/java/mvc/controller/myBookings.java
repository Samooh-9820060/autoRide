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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mvc.model.myBookingsViewModel;

/**
 *
 * @author samoo
 */
public class myBookings extends HttpServlet {

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
            String passengerIDString = getPassengerID(mail);

            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                    "password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(
                    "SELECT PASSENGERID, DATE, TIME, CURRENTDATE, CURRENTTIME, LOCATION, DESTINATION, VEHICLETYPE, DISTANCE, DURATION, TOTALPRICE, DRIVER, STATUS FROM BOOKINGDETAILS");
            // add all bookings that were done by the current passenger to a list
            List<myBookingsViewModel> myBookingsList = new ArrayList<>();
            int i = 1;

            while (resultSet.next()) {
                myBookingsViewModel tempList = new myBookingsViewModel();
                String passengerID = (String) resultSet.getObject(1);

                if (passengerIDString.equals(passengerID)) {
                    tempList.invoiceNum = i + "";
                    tempList.bookDate = (String) resultSet.getObject(2);
                    tempList.bookTime = (String) resultSet.getObject(3);
                    tempList.orderDate = (String) resultSet.getObject(4);
                    tempList.orderTime = (String) resultSet.getObject(5);
                    tempList.location = (String) resultSet.getObject(6);
                    tempList.destination = (String) resultSet.getObject(7);
                    tempList.vehicle = vehicleType(resultSet.getObject(8).toString().trim());
                    tempList.distance = (String) resultSet.getObject(9);
                    tempList.duration = (String) resultSet.getObject(10);
                    tempList.price = (String) resultSet.getObject(11);
                    tempList.driver = (String) resultSet.getObject(12);
                    tempList.status = (String) resultSet.getObject(13);
                    myBookingsList.add(tempList);
                }
                i++;
            }

            // add the list as a respones and redirect to that page
            Collections.reverse(myBookingsList);
            request.setAttribute("myBookingsList", myBookingsList);

            RequestDispatcher rd = request.getRequestDispatcher("./jsp/myBookings.jsp");
            rd.forward(request, response);
        }
    }

    // get vehicle name from vehicle id
    private String vehicleType(String receiptVehicleTypeID) throws SQLException {
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

    // get passenger id from mail
    private String getPassengerID(String mail) throws SQLException {
        String passengerID = "PA1";

        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide", "username",
                "password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        while (resultSet.next()) {
            String userId = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);

            if (email.equals(mail)) {
                passengerID = userId;
            }
        }

        return passengerID;
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
            Logger.getLogger(myBookings.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(myBookings.class.getName()).log(Level.SEVERE, null, ex);
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
