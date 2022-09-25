package mvc.controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.RequestDispatcher;
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
import java.util.Date; 


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
            String date = null;
            String time = null;
            String location = null;
            String destination = null;
            String pickupLatitude = null;
            String pickupLongitude = null;
            String destinationLatitude = null;
            String destinationLongitude = null;
            String vehicleType = null;
            String distance = null;
            String duration = null;
            
            String firstName = null;
            
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie: cookies) {
                switch (cookie.getName()){
                    case "bookDate":
                        date = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookTime":
                        time = cookie.getValue().replace("%3A", ":");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookLocation":
                        location = cookie.getValue().replace("%20", " ").replace("%2C", ",").replace("%C3%A9","é").replace("%2B", "+");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookDestination":
                        destination = cookie.getValue().replace("%20", " ").replace("%2C", ",").replace("%C3%A9","é").replace("%2B", "+");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookPickupLatitude":
                        pickupLatitude = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookPickupLongitude":
                        pickupLongitude = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookDestinationLatitude":
                        destinationLatitude = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "bookDestinationLongitude":
                        destinationLongitude = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "vehicleType":
                        vehicleType = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;  
                    case "distance":
                        distance = cookie.getValue().replace("%20", " ");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    case "duration":
                        duration = cookie.getValue().replace("%20", " ");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break; 
                    case "firstName":
                        firstName = cookie.getValue();
                        break;
                }
                //insertData(mail, date, time, location, pickupLatitude, pickupLongitude, destination, destinationLatitude, destinationLongitude, vehicleType);
                //response.sendRedirect("Loading.html");
            }
            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            
            SimpleDateFormat formatterDate = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat formatterTime = new SimpleDateFormat("HH:mm:ss");
            Date currentDate = new Date(); 
            String currentDateTime = formatterDate.format(currentDate);
            String currentTime = formatterTime.format(currentDate);
            
        
            populateBookingsDatabase(mail, date, time, location, pickupLatitude, pickupLongitude, destination, 
                    destinationLatitude, destinationLongitude, vehicleType, distance, duration, currentTime, currentDateTime);
            int invoiceNum = getLastRow();
            
            //Values needed for receipt
            String receiptOrderDate = currentDateTime;
            String receiptOrderTIme = currentTime;
            String receiptMail = mail;
            String receiptDate = date;
            String receiptTime = time;
            String receiptLocation = location;
            String receiptDestination = destination;
            String receiptVehicleType = vehicleType;
            String receiptDistance = distance;
            String receiptDuration = duration;
            String receiptFullName = null;
            String receiptPhoneNumber = null;
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT EMAIL, LAST_NAME, PHONE_NUMBER FROM USERDATA");
            ResultSetMetaData metaData = resultSet.getMetaData();
            int numberOfColumns = metaData.getColumnCount();

            while (resultSet.next()){
                for (int i = 1; i <= numberOfColumns; i++) {
                    String resultEmail = (String) resultSet.getObject(i);
                    String resultLastName = (String) resultSet.getObject(i+1);
                    int resultPhone = (int) resultSet.getObject(i+2);
                    
                    if (resultEmail.equals(mail)){
                        receiptFullName = firstName+" "+resultLastName;
                        receiptPhoneNumber = resultPhone+"";
                    }
                    i=i+3;
                }
            }
            
            
            
            //Send values for invoice
            request.setAttribute("invoiceNum", invoiceNum);
            request.setAttribute("receiptOrderDate", receiptOrderDate);
            request.setAttribute("receiptOrderTIme", receiptOrderTIme);
            request.setAttribute("receiptMail", receiptMail);
            request.setAttribute("receiptDate", receiptDate);
            request.setAttribute("receiptTime", receiptTime);
            request.setAttribute("receiptLocation", receiptLocation);
            request.setAttribute("receiptDestination", receiptDestination);
            request.setAttribute("receiptVehicleType", receiptVehicleType);
            request.setAttribute("receiptDistance", receiptDistance);
            request.setAttribute("receiptDuration", receiptDuration);
            request.setAttribute("receiptFullName", receiptFullName);
            request.setAttribute("receiptPhoneNumber", receiptPhoneNumber);
            request.setAttribute("vehiclePrice", String.format("%.2f",(vehiclePrice(vehicleType))));
            request.setAttribute("extraDistancePrice", String.format("%.2f",(extraDistancePrice(vehicleType,distance))));
            request.setAttribute("totalPrice", String.format("%.2f",(extraDistancePrice(vehicleType,distance)+vehiclePrice(vehicleType))));
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/invoice.jsp");
            rd.forward(request, response);
        }
    }
    
    public void populateBookingsDatabase(String mail, String date, String time, String location, String pickupLat, String pickupLng,
            String destination, String destinationLat, String destinationLng, String vehicleType, String distance,
            String duration, String currentTime, String currentDate) throws SQLException{
            
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement = connection.createStatement();
        statement.executeUpdate("INSERT INTO BOOKINGSDATA VALUES ('"+mail+"', '"+date+"', '"+time+"', '"+location+"', '"+pickupLat+"', '"+pickupLng+"', '"+destination+"', '"
                + ""+destinationLat+"', '"+destinationLng+"', '"+vehicleType+"','"+distance+"', '"+duration+"', '"+currentTime+"', '"+currentDate+"')");
    }
    
    public int getLastRow() throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT MAIL FROM BOOKINGSDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        int count = 0;
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                
                i++;
            }
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

    private double vehiclePrice(String vehicleType) {
        double price = 0.00;
        switch (vehicleType) {
            case "Car":
                price = 25.00;
                break;
            case "Cycle":
                price = 10.00;
                break;
            case "Pickup":
                price = 40.00;
                break;
        }
        return price;  
    }
    
    private double extraDistancePrice(String vehicleType, String distance){
        double price = 0.00;
        System.out.println("Distance is "+distance.substring(0,4).trim());
        double distanceDouble = Double.parseDouble(distance.substring(0,4).trim());
        System.out.println(distanceDouble+"Is double value");
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

}