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
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
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
            HttpSession session = request.getSession(false);
            
            String usernameInput = null;
            String passwordInput = null;
            String alreadyCreated = "0";
            
            if (session==null){
                response.sendRedirect("./jsp/adminSignIn.jsp");
            }
            
            usernameInput = request.getParameter("adminUserNameField");
            alreadyCreated = request.getParameter("alreadyCreated");
            
            if (alreadyCreated.equals("0")){
                passwordInput = request.getParameter("signInPassword");
                //create cookie to store user mail and default it to NA with no mail
                Cookie cookie = new Cookie ("status", "NA");

                if (checkPassowrd(usernameInput, hashPass(passwordInput))==true){
                    Thread.sleep(500);
                    cookie.setValue(usernameInput);
                    response.addCookie(cookie);

                    //add type of user as cookie
                    Cookie type = new Cookie("type", "admin");
                    response.addCookie(type);
                    session.setAttribute("session", usernameInput);


                    //add data for dash board
                    request.setAttribute("totalRevenue", totalRevenue());
                    request.setAttribute("todaysRevenue", todaysRevenue());
                    request.setAttribute("totalBookings", totalBookings());
                    request.setAttribute("todaysBookings", todaysBookings());
                    request.setAttribute("totalDistance", totalDistance());
                    request.setAttribute("todaysDistance", todaysDistance());
                    request.setAttribute("totalDuration", totalTime());
                    request.setAttribute("todaysDuration", todaysTime());



                    RequestDispatcher rd = request.getRequestDispatcher("./jsp/adminPage.jsp");
                    rd.forward(request, response);

                } else {
                    Thread.sleep(500);
                    cookie.setValue("IncorrectLoginDetails");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                }   
            } else if (alreadyCreated.equals("1")){
                    //add data for dash board
                    request.setAttribute("totalRevenue", totalRevenue());
                    request.setAttribute("todaysRevenue", todaysRevenue());
                    request.setAttribute("totalBookings", totalBookings());
                    request.setAttribute("todaysBookings", todaysBookings());
                    request.setAttribute("totalDistance", totalDistance());
                    request.setAttribute("todaysDistance", todaysDistance());
                    request.setAttribute("totalDuration", totalTime());
                    request.setAttribute("todaysDuration", todaysTime());



                    RequestDispatcher rd = request.getRequestDispatcher("./jsp/adminPage.jsp");
                    rd.forward(request, response);
            }
            
            
           
            
        } catch (SQLException | NoSuchAlgorithmException | InterruptedException ex) {
            Logger.getLogger(adminLogIn.class.getName()).log(Level.SEVERE, null, ex);
        }            
    }
    
    
    
    //validate username and password from database
    public boolean checkPassowrd(String username, String password) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERNAME, PASSWORD FROM ADMINDETAILS");
        
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
    
    //convert the entered password into a hash to compare the passwords in the database
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
    
    public String totalRevenue() throws SQLException{
        //get total revenue of all days
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT TOTALPRICE, STATUS FROM BOOKINGDETAILS");
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String status = resultSet.getObject(2).toString();
            if (status.equals("Complete")){
                totalValue += Double.parseDouble(resultSet.getObject(1).toString());                
            }
        }
        total = roundTwoDecimals(totalValue)+"";
        
        return total;
    }
    
    public String todaysRevenue() throws SQLException{
        //get current days total revenue
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, TOTALPRICE, STATUS FROM BOOKINGDETAILS");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            String value = resultSet.getObject(2).toString();
            String status = resultSet.getObject(3).toString();
            if (status.equalsIgnoreCase("Complete")){
                if (formattedDate.equals(date)){
                    totalValue += Double.parseDouble(value);
                }
            }

        }
        total = roundTwoDecimals(totalValue)+"";
        
        return total;
    }

    public String totalBookings() throws SQLException{
        //get the total number of bookings done by all passengers on all days
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, STATUS FROM BOOKINGDETAILS");
        
        int totalValue = 0;
        while (resultSet.next()){
            String status = resultSet.getObject(2).toString();
            if (status.equalsIgnoreCase("Complete")){
                totalValue++;    
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String todaysBookings() throws SQLException{
        // get current days total number of bookings done by passengers
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, STATUS FROM BOOKINGDETAILS");
        
        int totalValue = 0;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        while (resultSet.next()){
            String date = resultSet.getObject(1).toString();
            String status = resultSet.getObject(2).toString();
            if (status.equalsIgnoreCase("Complete")){
                if (formattedDate.equals(date)){
                    totalValue ++;
                }    
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String totalDistance() throws SQLException{
        //get the total distance of all drivers for all days
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT DISTANCE, STATUS FROM BOOKINGDETAILS");
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String status = resultSet.getObject(2).toString();
            if (status.equalsIgnoreCase("Complete")){
                totalValue += Double.parseDouble(resultSet.getObject(1).toString().replace(" km", ""));
            }
        }
        total = roundTwoDecimals(totalValue);
        
        return total;
    }
    
    public String todaysDistance() throws SQLException{
        //get the current days distacnce from all drivers
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, DISTANCE, STATUS FROM BOOKINGDETAILS");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        Double totalValue = 0.00;
        while (resultSet.next()){
            String status = resultSet.getObject(3).toString();
            String date = resultSet.getObject(1).toString();
            String distance = resultSet.getObject(2).toString().replace(" km", "");
            if (status.equalsIgnoreCase("Complete")){
                if (formattedDate.equals(date)){
                    totalValue += Double.parseDouble(distance);
                }
            }
        }
        total = roundTwoDecimals(totalValue);
        
        return total;
    }
    
    public String totalTime() throws SQLException{
        //get the total time for all drivers for all dates
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT DURATION, STATUS FROM BOOKINGDETAILS");
        
        int totalValue = 0;
        while (resultSet.next()){
            String status = resultSet.getObject(2).toString();
            if (status.equalsIgnoreCase("Complete")){
                totalValue += Double.parseDouble(resultSet.getObject(1).toString().replace(" mins", "").replace(" min", ""));                
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String todaysTime() throws SQLException{
        //get the total time travelled at the current day
        String total = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, DURATION, STATUS FROM BOOKINGDETAILS");
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date currentDate = new Date();
        String formattedDate = formatter.format(currentDate);
        
        int totalValue = 0;
        while (resultSet.next()){
            String status = resultSet.getObject(3).toString();
            String date = resultSet.getObject(1).toString();
            String duration = resultSet.getObject(2).toString().replace(" mins", "");
            if (status.equalsIgnoreCase("Complete")){
                if (formattedDate.equals(date)){
                    totalValue += Double.parseDouble(duration);
                }
            }
        }
        total = totalValue+"";
        
        return total;
    }
    
    public String roundTwoDecimals(double d) {
        //round values to 2 dp
        DecimalFormat twoDForm = new DecimalFormat("#.##");
        return twoDForm.format(d);
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
