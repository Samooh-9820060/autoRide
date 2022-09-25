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
import jakarta.servlet.http.HttpSession;
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
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class adminLogIn extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String usernameInput = request.getParameter("adminUserNameField");
            String passwordInput = request.getParameter("signInPassword");
            
            //create cookie to store user mail and default it to NA with no mail
            Cookie cookie = new Cookie ("status", "NA");
            
            if (checkPassowrd(usernameInput, hashPass(passwordInput))==true){
                Thread.sleep(500);
                cookie.setValue(usernameInput);
                response.addCookie(cookie);
                
                //add type of user as cookie
                Cookie type = new Cookie("type", "admin");
                response.addCookie(type);

                //add data for dashboard as cookies
                
                Cookie totalRevenueCookie = new Cookie("totalRevenue", totalRevenue());
                Cookie todaysRevenueCookie = new Cookie("todaysRevenue", todaysRevenue());
                Cookie totalBookingsCookie = new Cookie("totalBookings", totalBookings());
                Cookie todaysBookingsCookie = new Cookie("todaysBookings", todaysBookings());
                Cookie totalDistanceCookie = new Cookie("totalDistance", totalDistance());
                Cookie todaysDistanceCookie = new Cookie("todaysDistance", todaysDistance());
                Cookie totalDurationCookie = new Cookie("totalDuration", totalTime());
                Cookie todaysDurationCookie = new Cookie("todaysDuration", todaysTime());

                response.addCookie(totalRevenueCookie);
                response.addCookie(todaysRevenueCookie);
                response.addCookie(totalBookingsCookie);
                response.addCookie(todaysBookingsCookie);
                response.addCookie(totalDistanceCookie);
                response.addCookie(todaysDistanceCookie);
                response.addCookie(totalDurationCookie);
                response.addCookie(todaysDurationCookie);
                
                
                HttpSession session = request.getSession();
                session.setAttribute("session", usernameInput);
                    

            } else {
                Thread.sleep(500);
                cookie.setValue("IncorrectLoginDetails");
                response.addCookie(cookie);
            }
            response.sendRedirect("./jsp/Loading.jsp");
            
           
            
        } catch (SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(adminLogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(adminLogIn.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    //function to check if password and mail matches in database
    public boolean checkPassowrd(String username, String password) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERNAME, PASSWORD FROM ADMINDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        
        //loop through the selected rows to see if any of them matches
        while (resultSet.next()){
                String resultUsername = (String) resultSet.getObject(1);
                String resultPassword = (String) resultSet.getObject(2);

                if (resultUsername.equals(username)){
                    //if it matches return true else false
                    return resultPassword.equals(password); //Correct login details
                    //wrong login details
                }
        }        
        return false;
    }
    
    //hash the user entered password so that it can be compared to the one in the database
    public String hashPass(String password) throws NoSuchAlgorithmException{
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
    
    //get first name from the database to add it as cookie
    public String getFirstName(String username) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERNAME, NAME FROM ADMINDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        
        while (resultSet.next()){
                String resultUserName = (String) resultSet.getObject(1);
                String resultName = (String) resultSet.getObject(2);

                if (resultUserName.equals(username)){
                    return resultName;
                }
        }
        return null;
    }
    
    public String totalRevenue() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT TOTAL_PRICE FROM BOOKINGSDATA");
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            totalValue += Double.parseDouble(resultSet.getObject(1).toString());
        }
        total = totalValue.toString();
        
        return total;
    }
    
    public String todaysRevenue() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT ORDERDATE, TOTAL_PRICE FROM BOOKINGSDATA");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            String value = resultSet.getObject(2).toString();
            if (formattedDate.equals(date)){
                totalValue += Double.parseDouble(value);
            }
        }
        total = totalValue.toString();
        
        return total;
    }

    public String totalBookings() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT ORDERDATE FROM BOOKINGSDATA");
        
        int totalValue = 0;
        while (resultSet.next()){
            totalValue++;
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String todaysBookings() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT ORDERDATE FROM BOOKINGSDATA");
        
        int totalValue = 0;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            if (formattedDate.equals(date)){
                totalValue ++;
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String totalDistance() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT DISTANCE FROM BOOKINGSDATA");
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            totalValue += Double.parseDouble(resultSet.getObject(1).toString().replace(" km", ""));
        }
        total = roundTwoDecimals(totalValue)+"";
        
        return total;
    }
    
    public String todaysDistance() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT ORDERDATE, DISTANCE FROM BOOKINGSDATA");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            String distance = resultSet.getObject(2).toString().replace(" km", "");
            if (formattedDate.equals(date)){
                totalValue += Double.parseDouble(distance);
            }
        }
        total = roundTwoDecimals(totalValue)+"";
        
        return total;
    }
    
    public String totalTime() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT DURATION FROM BOOKINGSDATA");
        
        int totalValue = 0;
        while (resultSet.next()){
            totalValue += Double.parseDouble(resultSet.getObject(1).toString().replace(" mins", ""));
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String todaysTime() throws SQLException{
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT ORDERDATE, DURATION FROM BOOKINGSDATA");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        int totalValue = 0;
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            String duration = resultSet.getObject(2).toString().replace(" mins", "");
            if (formattedDate.equals(date)){
                totalValue += Double.parseDouble(duration);
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public double roundTwoDecimals(double d) {
        DecimalFormat twoDForm = new DecimalFormat("#.##");
        return Double.valueOf(twoDForm.format(d));
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
        processRequest(request, response);
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
        processRequest(request, response);
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
