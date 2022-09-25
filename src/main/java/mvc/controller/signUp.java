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
public class signUp extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.security.NoSuchAlgorithmException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            if (request.getParameter("signUpButton") != null){
                //get data from the user inputs and store them in string for temporary use
                String signUpFirstName = request.getParameter("signUpFirstName");
                String signUpLastName = request.getParameter("signUpLastName");
                String signUpEmail = request.getParameter("signUpEmail");
                int signUpTelephone = Integer.parseInt(request.getParameter("signUpTelephone"));
                String signUpPassword = hashPass(request.getParameter("signUpPassword"));
                String type = "Passenger";
                String vehicle = null;
                
                Cookie cookie = new Cookie ("status", "NA");
                
                //check if the mail or number has been repeated and show error message if it is repeated else go to login page
                switch (checkRepeat(signUpEmail, signUpTelephone)){
                    case 0:
                        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
                        Statement statement;
                        statement = connection.createStatement();
                        statement.executeUpdate("INSERT INTO USERDATA VALUES ('"+signUpFirstName+"', '"+signUpLastName+"', '"+signUpEmail+"', "+signUpTelephone+",'"+signUpPassword+"', '"+type+"', '"+vehicle+"')");
                        cookie.setValue("Registered");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                        break;
                    case 1:
                        cookie.setValue("Repeated");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                        break;
                    case 2:
                        cookie.setValue("Repeated");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                        break;
                    case 3:
                        cookie.setValue("Repeated");
                        response.addCookie(cookie);
                        response.sendRedirect("./jsp/Loading.jsp");
                        break;
                }
            }
        }
    }
    
    //hash password in SHA 256 format to store in database
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
    
    //check if the user entered email or phone numbers is repeated
    public int checkRepeat(String email, int phoneNumber) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/taxiAppUserData","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PHONE_NUMBER FROM USERDATA");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        
        //loop through the selected data in the database
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                int resultPhone = (int) resultSet.getObject(i+1);
                
                if ((resultEmail.equalsIgnoreCase(email))&&(resultPhone == phoneNumber)){
                    return 3;
                } else if (resultEmail.equalsIgnoreCase(email)){
                    return 2;
                } else if (resultPhone == phoneNumber){
                    return 1;
                }
                i++;
            }
        }        
        return 0;
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
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
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
