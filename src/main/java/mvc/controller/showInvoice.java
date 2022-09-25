/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mvc.controller;

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


/**
 *
 * @author samoo
 */
public class showInvoice extends HttpServlet {

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
            
            //Values needed for receipt
            String receiptOrderDate = null;
            String receiptOrderTIme = null;
            String receiptPassengerID = null;
            String receiptDate = null;
            String receiptTime = null;
            String receiptLocation = null;
            String receiptDestination = null;
            String receiptVehicleTypeID = null;
            String receiptDistance = null;
            String receiptDuration = null;
            String receiptVehiclePrice = null;
            String receiptExtraDistancePrice = null;
            String receiptTotalPrice = null;
            
            String receiptFullName = null;
            String receiptPhoneNumber = null;

            
            HttpSession session = request.getSession();
            String mail = (String) session.getAttribute("session");
            
            String firstName = null;
            String invoiceNumber = "BLANK";
            
            Cookie[] cookies = request.getCookies();
            for (Cookie cookie: cookies) {
                switch (cookie.getName()){
                    case "firstName":
                        firstName = cookie.getValue();
                        break;
                    case "invoiceNo":
                        invoiceNumber = cookie.getValue();
                        cookie.setMaxAge(0);
                        response.addCookie(cookie); 
                        break;
                }
            }
            
            
            //get values from bookingsdata database
            int invoiceNum = getInvoiceNumber(invoiceNumber);
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, CURRENTTIME, PASSENGERID, DATE, TIME, LOCATION, DESTINATION, "
                    + "VEHICLETYPE, DISTANCE, DURATION, VEHICLEPRICE, EXTRADISTANCEPRICE, TOTALPRICE FROM BOOKINGDETAILS");
            int count = 1;
            while (resultSet.next()){
                if (count==invoiceNum){
                    receiptOrderDate = (String) resultSet.getObject(1);
                    receiptOrderTIme = (String) resultSet.getObject(2);
                    receiptPassengerID = (String) resultSet.getObject(3);
                    receiptDate = (String) resultSet.getObject(4);
                    receiptTime = (String) resultSet.getObject(5);
                    receiptLocation = (String) resultSet.getObject(6);
                    receiptDestination = (String) resultSet.getObject(7);
                    receiptVehicleTypeID = resultSet.getObject(8).toString().trim();
                    receiptDistance = (String) resultSet.getObject(9);
                    receiptDuration = (String) resultSet.getObject(10);
                    receiptVehiclePrice = (String) resultSet.getObject(11);
                    receiptExtraDistancePrice = (String) resultSet.getObject(12);
                    receiptTotalPrice = (String) resultSet.getObject(13);

                }
                count++;
            }
            
            //get vehicle name from vehicle type
            String receiptVehicleName = null;
            Statement statementVehicles = connection.createStatement();
            ResultSet resultSetVehicles = statementVehicles.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");
            while (resultSetVehicles.next()){
                String resultVehicleID = resultSetVehicles.getObject(1).toString().trim();
                String resultVehicleName = resultSetVehicles.getObject(2).toString();
                if (receiptVehicleTypeID.equals(resultVehicleID)){
                    receiptVehicleName = resultVehicleName;
                }
            }
            
            //Send values for invoice
            request.setAttribute("invoiceNum", invoiceNum);
            request.setAttribute("receiptOrderDate", receiptOrderDate);
            request.setAttribute("receiptOrderTIme", receiptOrderTIme);
            request.setAttribute("receiptMail", getEmail(receiptPassengerID));
            request.setAttribute("receiptDate", receiptDate);
            request.setAttribute("receiptTime", receiptTime);
            request.setAttribute("receiptLocation", receiptLocation);
            request.setAttribute("receiptDestination", receiptDestination);
            request.setAttribute("receiptVehicleType", receiptVehicleName);
            request.setAttribute("receiptDistance", receiptDistance);
            request.setAttribute("receiptDuration", receiptDuration);
            request.setAttribute("receiptFullName", getFullName(receiptPassengerID));
            request.setAttribute("receiptPhoneNumber", getPhoneNumber(receiptPassengerID));
            request.setAttribute("vehiclePrice", receiptVehiclePrice);
            request.setAttribute("extraDistancePrice", receiptExtraDistancePrice);
            request.setAttribute("totalPrice", receiptTotalPrice);
            
            /*out.println(invoiceNum+receiptOrderDate+receiptOrderTIme+receiptMail+receiptDate+receiptTime+
                    receiptLocation+receiptDestination+receiptVehicleType+receiptDistance+receiptDuration+receiptFullName+
                    receiptPhoneNumber+receiptVehiclePrice+receiptExtraDistancePrice+receiptTotalPrice);
            */
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/invoice.jsp");
            rd.forward(request, response);
        }
    }
    
    public String getEmail(String id) throws SQLException{
        String mail = "";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, EMAIL FROM USERDETAILS");
        
        while (resultSet.next()){
            String userID = resultSet.getObject(1).toString().trim();
            
            if (userID.equals(id)){
                mail = resultSet.getObject(2).toString().trim();
            }
        }
        
        return mail;
    }
    
    public String getFullName(String id) throws SQLException{
        String fullName = "";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, FIRSTNAME, LASTNAME FROM USERDETAILS");
        
        while (resultSet.next()){
            String userID = resultSet.getObject(1).toString().trim();
            if (userID.equals(id)){
                String firstName = resultSet.getObject(2).toString().trim();
                String lastName = resultSet.getObject(3).toString().trim();
                
                fullName = firstName+" "+lastName;
            }
        }
        return fullName;
    }
        
    public String getPhoneNumber(String id) throws SQLException{
        String phoneNumber = "";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERID, PHONENUMBER FROM USERDETAILS");
        
        while (resultSet.next()){
            String userID = resultSet.getObject(1).toString().trim();
            
            if (userID.equals(id)){
                phoneNumber = resultSet.getObject(2).toString().trim();
            }
        }
        
        return phoneNumber;
    }
    
    public int getInvoiceNumber(String invoiceNumber) throws SQLException{
        
        if (invoiceNumber.equals("BLANK")){
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT PASSENGERID FROM BOOKINGDETAILS");
            ResultSetMetaData metaData = resultSet.getMetaData();
            int numberOfColumns = metaData.getColumnCount();
            int count = 0;
            while (resultSet.next()){
                for (int i = 1; i <= numberOfColumns; i++) {

                    i++;
                }
                count++;
            }
            return count;   
        } else {
            return Integer.parseInt(invoiceNumber);
        }
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
            Logger.getLogger(showInvoice.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(showInvoice.class.getName()).log(Level.SEVERE, null, ex);
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
