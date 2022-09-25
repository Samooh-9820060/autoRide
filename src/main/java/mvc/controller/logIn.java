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
public class logIn extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException, SQLException, InterruptedException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            //get mail and password from user input
            String signInMail = request.getParameter("signInEmail");
            String signInPassword = request.getParameter("signInPassword");
            
            //create cookie to store user mail and default it to NA with no mail
            Cookie cookie = new Cookie ("status", "NA");

            //check if mail and password match from database by running checkpassword function
            if (checkPassowrd(signInMail, hashPass(signInPassword))==true){
                //if mail and password match add cookie with user mail
                Thread.sleep(500);
                cookie.setValue(signInMail);
                response.addCookie(cookie);
                
                //add type and first name of user as cookies
                Cookie type = new Cookie("type", getUserType(signInMail));
                Cookie firstName = new Cookie ("firstName", getFirstName(signInMail));
                response.addCookie(firstName);
                response.addCookie(type);
                
                //create a new session for the user with their mail address
                HttpSession session = request.getSession();
                session.setAttribute("session", signInMail);
                
            } else {
                //if incorrect password given go to loading screen with cookie that says NA
                Thread.sleep(500);
                cookie.setValue("IncorrectLoginDetails");
                response.addCookie(cookie);
            }
            response.sendRedirect("./jsp/Loading.jsp");
        }
    }
    
    //function to check if password and mail matches in database
    public boolean checkPassowrd(String email, String password) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PASSWORD FROM USERDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        
        //loop through the selected rows to see if any of them matches
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                String resultPassword = (String) resultSet.getObject(i+1);

                if (resultEmail.equals(email)){
                    //if it matches return true else false
                    return resultPassword.equals(password); //Correct login details
                    //wrong login details
                }
                i++;
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
    public String getFirstName(String email) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, FIRST_NAME FROM USERDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                String resultFirstName = (String) resultSet.getObject(i+1);

                if (resultEmail.equals(email)){
                    return resultFirstName;
                }
                i++;
            }
        }
        return null;
    }
    
    //get type of the user to add it as cookie
    public String getUserType(String email) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, TYPE FROM USERDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                String resultType = (String) resultSet.getObject(i+1);

                if (resultEmail.equals(email)){
                    return resultType;
                }
                i++;
            }
        }
        return null;
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
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(logIn.class.getName()).log(Level.SEVERE, null, ex);
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
