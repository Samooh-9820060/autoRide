/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mvc.controller;

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
public class rideStatusUpdate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            String driverIDString = getDriverID(mail);
            
            String updateType = request.getParameter("updateType");
            String updateBookingNumber = request.getParameter("bookingNumberRide");
            //get the next driver in line 
            String nextDriver = getNextDriver(driverIDString, getDriverVehicle(driverIDString));
            if (nextDriver.equals(driverIDString)){
                nextDriver = getFirstDriver(driverIDString, getDriverVehicle(driverIDString));
            }
            
            //get the button the user pressed
            switch (updateType) {
                case "Accept":
                    //accept the booking and move it to ongoing bookings
                    acceptBooking(updateBookingNumber);
                    break;
                case "Reject":
                    //reject the booking and send it to the driver with the same vehicle next in line
                    rejectBooking(updateBookingNumber, nextDriver);
                    break;
                case "Complete":
                    //complete the booking from ongoing booking
                    completeBooking(updateBookingNumber);
                    break;
            }
            
            response.sendRedirect("./driverHomePage");
            
            out.println(updateType+" "+updateBookingNumber);
        }
    }
    
    private void acceptBooking(String bookingNo) throws SQLException{
        //accept the booking and move it to the ongoing booking
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        statement.executeUpdate("UPDATE BOOKINGDETAILS SET STATUS = 'Driver_Assigned' WHERE ID = '"+bookingNo+"'");
    }
    
    private void rejectBooking(String bookingNo, String nextDriver) throws SQLException{
        //reject the booking and send it to the next driver in line
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        statement.executeUpdate("UPDATE BOOKINGDETAILS SET DRIVER = '"+nextDriver+"' WHERE ID = '"+bookingNo+"'");
    }
    
    private void completeBooking(String bookingNo) throws SQLException{
        //complete the booking and mark it as paid
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        statement.executeUpdate("UPDATE BOOKINGDETAILS SET STATUS = 'Complete' WHERE ID = '"+bookingNo+"'");
    }
    
    private String getNextDriver(String currentDriver, String vehicleType) throws SQLException{
        //get the next driver with the same vehicle
        String nextDriver = currentDriver;
        boolean passedCurrentDriver = false;
        
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, USERTYPE, VEHICLETYPE FROM USERDETAILS");
        while (resultSet.next()){
            String userId = resultSet.getObject(1).toString().trim();
            String userType = resultSet.getObject(2).toString().trim();
           
            if (passedCurrentDriver == true){
                if (userId.startsWith("DR")){
                    String vehicle = resultSet.getObject(3).toString().trim();
                    if ((userType.equals("2"))&&(vehicleType.equals(vehicle))){
                        nextDriver = userId;
                        return nextDriver;
                    }                    
                }
            }
            
            if (userId.equals(currentDriver)){
                passedCurrentDriver = true;
            } 
        }
        
        return nextDriver;
    }
    
    private String getFirstDriver(String currentDriver, String vehicleID) throws SQLException{
        //get the first driver with the same vehicle
        String firstDriver = currentDriver;
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, USERTYPE, VEHICLETYPE FROM USERDETAILS");
        while (resultSet.next()){
            String userType = resultSet.getObject(2).toString().trim();
            String vehicleType = resultSet.getObject(3).toString().trim();
            
            if ((userType.equals("2"))&&((vehicleType.equals(vehicleID)))){
                String userID = resultSet.getObject(1).toString().trim();
                return userID;
            }
        }
        return firstDriver;
    }

    private String getDriverID(String mail) throws SQLException{
        //get driver id by mail
        String driverID = "DR1";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        while (resultSet.next()){
            String userId = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);
            
            if (email.equals(mail)){
                driverID = userId;
            }
        }
        
        return driverID;
    }
    
    private String getDriverVehicle(String id) throws SQLException{
        //get driver vehicle by id
        String vehicle = "0";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, VEHICLETYPE FROM USERDETAILS");
        while (resultSet.next()){
            String userId = (String) resultSet.getObject(1);
            String vehicleID = (String) resultSet.getObject(2);
            
            if (userId.equals(id)){
                vehicle = vehicleID;
            }
        }
        
        return vehicle;
    }
    
    private String vehicleType(String receiptVehicleTypeID) throws SQLException{
        //get vehicle name by vehicle id
        String vehicleName = "";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statementVehicles = connection.createStatement();
        ResultSet resultSetVehicles = statementVehicles.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");

        while (resultSetVehicles.next()){
            String resultVehicleID = resultSetVehicles.getObject(1).toString().trim();
            String resultVehicleName = resultSetVehicles.getObject(2).toString();
            if (receiptVehicleTypeID.equals(resultVehicleID)){
                vehicleName = resultVehicleName;
            }
        }
        
        
        return vehicleName;
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(rideStatusUpdate.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(rideStatusUpdate.class.getName()).log(Level.SEVERE, null, ex);
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
