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
import mvc.model.driverRidesViewModel;

/**
 *
 * @author samoo
 */

public class driverHomePage extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            String driverIDString = getDriverID(mail);
            String driverVehicle = vehicleType(getDriverVehicle(driverIDString));
            
            
            //get pending rides for this driver
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSetPendingRides = statement.executeQuery("SELECT DRIVER, STATUS, VEHICLETYPE, DATE, TIME, LOCATION, DESTINATION, TOTALPRICE FROM BOOKINGDETAILS");
            
            List<driverRidesViewModel> pendingRides = new ArrayList<>();
            int i =1;
            
            while (resultSetPendingRides.next()){
                driverRidesViewModel tempList = new driverRidesViewModel();
                String driver = resultSetPendingRides.getObject(1).toString();
                String status = resultSetPendingRides.getObject(2).toString();
                String vehicle = vehicleType(resultSetPendingRides.getObject(3).toString().trim());
                
                
                if ((driverIDString.equals(driver))&&(status.equalsIgnoreCase("Waiting"))&&(driverVehicle.equals(vehicle))){
                    tempList.id=i+"";
                    tempList.bookDate = (String) resultSetPendingRides.getObject(4);
                    tempList.bookTime = (String) resultSetPendingRides.getObject(5);
                    tempList.location = (String) resultSetPendingRides.getObject(6);
                    tempList.destination = (String) resultSetPendingRides.getObject(7);
                    tempList.price = (String) resultSetPendingRides.getObject(8);
                    pendingRides.add(tempList);
                }
                i++;
            }
            request.setAttribute("pendingRides", pendingRides);
            
            //get pending rides for this driver
            ResultSet resultSetOngoingRides = statement.executeQuery("SELECT DRIVER, STATUS, VEHICLETYPE, DATE, TIME, LOCATION, DESTINATION, TOTALPRICE FROM BOOKINGDETAILS");
            
            List<driverRidesViewModel> ongoingRides = new ArrayList<>();
            int y = 1;
            
            while (resultSetOngoingRides.next()){
                driverRidesViewModel tempList = new driverRidesViewModel();
                String driver = resultSetOngoingRides.getObject(1).toString();
                String status = resultSetOngoingRides.getObject(2).toString();
                String vehicle = vehicleType(resultSetOngoingRides.getObject(3).toString().trim());
                
                
                if ((driverIDString.equals(driver))&&(status.equalsIgnoreCase("Driver_Assigned"))&&(driverVehicle.equals(vehicle))){
                    tempList.id=y+"";
                    tempList.bookDate = (String) resultSetOngoingRides.getObject(4);
                    tempList.bookTime = (String) resultSetOngoingRides.getObject(5);
                    tempList.location = (String) resultSetOngoingRides.getObject(6);
                    tempList.destination = (String) resultSetOngoingRides.getObject(7);
                    tempList.price = (String) resultSetOngoingRides.getObject(8);
                    ongoingRides.add(tempList);
                }
                y++;
            }
            request.setAttribute("ongoingRides", ongoingRides);
            //set pending and ongoing number
            request.setAttribute("pendingRidesNum", pendingRides.size());
            request.setAttribute("ongoingRidesNum", ongoingRides.size());
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/driverHomePage.jsp");
            rd.forward(request, response);
        }
    }
    
    private String getDriverID(String mail) throws SQLException{
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
            Logger.getLogger(driverHomePage.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(driverHomePage.class.getName()).log(Level.SEVERE, null, ex);
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
