package mvc.controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
import java.text.SimpleDateFormat;  
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date; 
import javax.imageio.ImageIO;


/**
 *
 * @author samoo
 */
public class bookRide extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
            
            String date = request.getParameter("carryDate");
            String time = request.getParameter("carryTime");
            String location = request.getParameter("carryLocation").replace("%20", " ");
            String destination = request.getParameter("carryDestination").replace("%20", " ");
            String pickupLatitude = request.getParameter("locationLat");
            String pickupLongitude = request.getParameter("locationLng");
            String destinationLatitude = request.getParameter("destLat");
            String destinationLongitude = request.getParameter("destLng");
            String vehicleType = request.getParameter("carryVehicle");
            String distance = request.getParameter("inputDistance").replace("%20", " ");
            String duration = request.getParameter("inputDuration").replace("%20", " ");
            String driver= getFirstDriverID();
            
            String firstName = null;
            
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie: cookies) {
                switch (cookie.getName()){
                    case "firstName":
                        firstName = cookie.getValue();
                        break;
                }
            }
            
            String dbVehicle = "0";
            switch (vehicleType) {
                case "Cycle":
                    dbVehicle = "1";
                    break;
                case "Car":
                    dbVehicle = "2";
                    break;
                case "Pickup":
                    dbVehicle = "3";
                    break;
                default:
                    throw new AssertionError();
            }
            
            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            String passengerID = getPassengerID(mail);
            
            SimpleDateFormat formatterDate = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat formatterTime = new SimpleDateFormat("HH:mm:ss");
            Date currentDate = new Date(); 
            String currentDateTime = formatterDate.format(currentDate);
            String currentTime = formatterTime.format(currentDate);
            String totalPrice = String.format("%.2f",(extraDistancePrice(vehicleType,distance)+vehiclePrice(dbVehicle)));
            String vehiclePrice = String.format("%.2f",vehiclePrice(dbVehicle));
            String extraDistancePrice = String.format("%.2f",(extraDistancePrice(vehicleType,distance)));
            String status = "Waiting";
            
            populateBookingsDatabase(passengerID, date, time, location, pickupLatitude, pickupLongitude, destination, 
                    destinationLatitude, destinationLongitude, dbVehicle, distance, duration, currentTime, currentDateTime, vehiclePrice, extraDistancePrice, totalPrice, status, driver);            
            
            

            response.sendRedirect("showInvoice");
            }
    }
    
    public void populateBookingsDatabase(String passengerID, String date, String time, String location, String pickupLat, String pickupLng,
            String destination, String destinationLat, String destinationLng, String vehicleType, String distance,
            String duration, String currentTime, String currentDate, String vehiclePrice, String extraDistancePrice, String price, String status, String driver) throws SQLException{
            
        String nextRow = (getLastRow()+1)+"";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        statement.executeUpdate("INSERT INTO BOOKINGDETAILS VALUES ('"+nextRow+"', '"+passengerID+"', '"+date+"', '"+time+"', '"+location+"', '"+pickupLat+"', '"+pickupLng+"', '"+destination+"', '"
                + ""+destinationLat+"', '"+destinationLng+"', '"+vehicleType+"','"+distance+"', '"+duration+"', '"+currentTime+"', '"+currentDate+"', '"+vehiclePrice+"', '"+extraDistancePrice+"', '"+price+"', '"+status+"', '"+driver+"')");
    }
    
    public int getLastRow() throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT PASSENGERID FROM BOOKINGDETAILS");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        int count = 0;
        while (resultSet.next()){  
                count++;
        }
        return count;
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
            Logger.getLogger(bookRide.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(bookRide.class.getName()).log(Level.SEVERE, null, ex);
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

    private double vehiclePrice(String vehicleType) throws SQLException {
        double price = 0.00;
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT VEHICLEID, VEHICLEPRICE FROM VEHICLES");
        while (resultSet.next()){
            String vehicleID = (String) resultSet.getObject(1);
            String vehiclePrice = (String) resultSet.getObject(2);
            
            if (vehicleID.equals(vehicleType)){
                price = Double.parseDouble(vehiclePrice);
            }
        }
        return price;  
    }
    
    private String getPassengerID(String mail) throws SQLException{
        String passengerID = "PA1";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        while (resultSet.next()){
            String userId = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);
            
            if (email.equals(mail)){
                passengerID = userId;
            }
        }
        
        return passengerID;
    }
    
    private double extraDistancePrice(String vehicleType, String distance){
        double price = 0.00;
        //System.out.println("Distance is "+distance.substring(0,4).trim());
        double distanceDouble = Double.parseDouble(distance.substring(0,4).trim());
        //System.out.println(distanceDouble+"Is double value");
        switch (vehicleType) {
            case "Cycle":
                if (distanceDouble<=10.0){
                    price = 0.00;
                } else if ((distanceDouble>10.0)&&(distanceDouble<=15.0)){
                    price = 0.00+((distanceDouble-10.0)*1);
                } else if ((distanceDouble>15.0)&&(distanceDouble<=20.0)){
                    price = 0.00+((15.0-10.0)*1)+((distanceDouble-15)*2);
                } else if ((distanceDouble>20.0)){
                    price = 0.00+((15.0-10.0)*1)+((20.0-15.0)*2)+((distanceDouble-20)*3);
                } else {
                    price = 0.00;
                }
                break;
            
            case "Car":
                if (distanceDouble<=10.0){
                    price = 0.00;
                } else if ((distanceDouble>10.0)&&(distanceDouble<=15.0)){
                    price = 0.00+((distanceDouble-10.0)*2);
                } else if ((distanceDouble>15.0)&&(distanceDouble<=20.0)){
                    price = 0.00+((15.0-10.0)*2)+((distanceDouble-15)*3);
                } else if ((distanceDouble>20.0)){
                    price = 0.00+((15.0-10.0)*2)+((20.0-15.0)*3)+((distanceDouble-20)*4);
                } else {
                    price = 0.00;
                }
                break;
            case "Pickup":
                if (distanceDouble<=10.0){
                    price = 0.00;
                } else if ((distanceDouble>10.0)&&(distanceDouble<=15.0)){
                    price = 0.00+((distanceDouble-10.0)*3);
                } else if ((distanceDouble>15.0)&&(distanceDouble<=20.0)){
                    price = 0.00+((15.0-10.0)*3)+((distanceDouble-15)*4);
                } else if ((distanceDouble>20.0)){
                    price = 0.00+((15.0-10.0)*3)+((20.0-15.0)*4)+((distanceDouble-20)*5);
                } else {
                    price = 0.00;
                }
                break;
        }
        return price; 
    }
    
    private String getFirstDriverID() throws SQLException{
        String firstDriverID = "DR1";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, USERTYPE FROM USERDETAILS");
        while (resultSet.next()){
            String usertype = resultSet.getObject(2).toString().trim();
            String userid = (String) resultSet.getObject(1);
            
            if (usertype.equals("2")){
                firstDriverID = userid;
                return firstDriverID;
            }
        }
        
        return firstDriverID;
    }

}