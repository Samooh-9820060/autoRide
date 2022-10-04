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
public class updatePassenger extends HttpServlet {

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
            //get the inputs from the user
            String firstNameNew = request.getParameter("firstNameInput");
            String lastNameNew = request.getParameter("lastNameInput");
            String mobileNumberNew = request.getParameter("mobileNumberInput");
            String idCardNumberNew = request.getParameter("idCardNumberInput");
            String addressNew = request.getParameter("addressInput");
            String postalCodeNew = request.getParameter("postCodeInput");
            String districtNew = request.getParameter("districtInput");
            String islandNew = request.getParameter("islandInput");
            String emailNew = request.getParameter("emailInput");
            String emergencyContactNameNew = request.getParameter("emergencyContactNameInput");
            String emergencyContactNumberNew = request.getParameter("emergencyContactNumberInput");
            //validate the inputs            
            String blankValue = "-";
            if (idCardNumberNew.isBlank()){
                idCardNumberNew = blankValue;
            }
            if (addressNew.isBlank()){
                addressNew = blankValue;
            }
            if (postalCodeNew.isBlank()){
                postalCodeNew = blankValue;
            }
            if (districtNew.isBlank()){
                districtNew = blankValue;
            }
            if (islandNew.isBlank()){
                islandNew = blankValue;
            }
            if (emergencyContactNameNew.isBlank()){
                emergencyContactNameNew = blankValue;
            }
            if (emergencyContactNumberNew.isBlank()){
                emergencyContactNumberNew = "0";
            }
            
            String currentMobile = getPassengerMobile(mail);
            String currentEmail = mail;
            String currentUserID = getPassengerID(mail);
            String currentPassword = getPassword(mail);
            String userType = getUserType(mail);
            String vehicleType = "0";
            
            Cookie cookie = new Cookie ("statusUpdate", "NA");
            //check if the mobile or email is repeated
            if ((currentMobile.equals(mobileNumberNew))&&(currentEmail.equals(emailNew))){
                //works correctlys
                System.out.println("all equal running");
                deleteUser(currentUserID);
                populateDatabase(currentUserID, firstNameNew, lastNameNew, currentPassword, Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew, userType, vehicleType);
                cookie.setValue("Registered");
                session.setAttribute("session", emailNew);
                Cookie firstName = new Cookie ("firstName", firstNameNew);
                response.addCookie(firstName);
                response.addCookie(cookie);
                response.sendRedirect("./jsp/Loading.jsp");
            } else if ((currentMobile.equals(mobileNumberNew))&&(!currentEmail.equals(emailNew))){
                int repeatValue = checkMailRepeat(emailNew);
                if (repeatValue==0){
                    deleteUser(currentUserID);
                    populateDatabase(currentUserID, firstNameNew, lastNameNew, currentPassword, Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew, userType, vehicleType);
                    cookie.setValue("Registered");
                    session.setAttribute("session", emailNew);
                    Cookie firstName = new Cookie ("firstName", firstNameNew);
                    response.addCookie(firstName);
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");                    
                } else {
                    cookie.setValue("RepeatedPassengerUpdate");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                }
            } else if ((!currentMobile.equals(mobileNumberNew))&&(currentEmail.equals(emailNew))){
                int repeatValue = checkPhoneRepeat(mobileNumberNew);
                if (repeatValue==0){
                    deleteUser(currentUserID);
                    populateDatabase(currentUserID, firstNameNew, lastNameNew, currentPassword, Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew, userType, vehicleType);
                    cookie.setValue("Registered");
                    session.setAttribute("session", emailNew);
                    Cookie firstName = new Cookie ("firstName", firstNameNew);
                    response.addCookie(firstName);
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");                    
                } else {
                    cookie.setValue("RepeatedPassengerUpdate");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                }
            } else {
                int repeatValue = checkRepeat(emailNew, Integer.parseInt(mobileNumberNew));
                if (repeatValue==0){
                    deleteUser(currentUserID);
                    populateDatabase(currentUserID, firstNameNew, lastNameNew, currentPassword, Integer.parseInt(mobileNumberNew), idCardNumberNew, addressNew, postalCodeNew, districtNew, islandNew, emailNew, emergencyContactNameNew, emergencyContactNumberNew, userType, vehicleType);
                    cookie.setValue("Registered");
                    session.setAttribute("session", emailNew);
                    Cookie firstName = new Cookie ("firstName", firstNameNew);
                    response.addCookie(firstName);
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");                    
                } else {
                    cookie.setValue("RepeatedPassengerUpdate");
                    response.addCookie(cookie);
                    response.sendRedirect("./jsp/Loading.jsp");
                }
            }
            
            
        }
    }
    //add the details to the database
    private void populateDatabase(String userId, String firstName, String lastName, String password, int phoneNumber, String idNumber, String address, String postalCode, String district, String island, String emailValue, String emergencyContactName, String emergencyContactNumber, String userType, String vehicleType) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        statement.executeUpdate("INSERT INTO USERDETAILS (USERID,FIRSTNAME,LASTNAME,PASSWORD,PHONENUMBER,IDNUMBER,ADDRESS,POSTALCODE,DISTRICT,ISLAND,EMAIL,EMERGENCYCONTACTNAME,EMERGENCYCONTACTNUMBER,USERTYPE,VEHICLETYPE) VALUES ('"+userId+"', '"+firstName+"', '"+lastName+"', '"+password+"', "+phoneNumber+", '"+idNumber+"', '"+address+"', '"+postalCode+"', '"+district+"', '"+island+"', '"+emailValue+"', '"+emergencyContactName+"', "+emergencyContactNumber+", '"+userType+"', '"+vehicleType+"')");
                        
    }
    //delete the user
    private void deleteUser(String userId) throws SQLException{
            
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
            
        String deleteQueryString = "DELETE FROM USERDETAILS WHERE USERID = '"+userId+"'";
        statement.executeUpdate(deleteQueryString);
    }
    //get the mobile number of passenger using mail
    private String getPassengerMobile(String mail) throws SQLException{
        String phoneNumberValue = "0";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PHONENUMBER FROM USERDETAILS");
        while (resultSet.next()){
            String email = (String) resultSet.getObject(1);
            String phoneNumber = resultSet.getObject(2).toString();
            
            if (email.equals(mail)){
                phoneNumberValue = phoneNumber;
            }
        }
        
        return phoneNumberValue;
    }

    //get the passenger id using mail
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
    //get password by using mail
    private String getPassword(String mail) throws SQLException{
        String passwordString = "PA1";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT PASSWORD, EMAIL FROM USERDETAILS");
        while (resultSet.next()){
            String password = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);
            
            if (email.equals(mail)){
                passwordString = password;
            }
        }
        
        return passwordString;
    }
    //get user type by using passenger mail
    private String getUserType(String mail) throws SQLException{
        String userTypeString = "PA1";
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT USERTYPE, EMAIL FROM USERDETAILS");
        while (resultSet.next()){
            String usertype = (String) resultSet.getObject(1);
            String email = (String) resultSet.getObject(2);
            
            if (email.equals(mail)){
                userTypeString = usertype;
            }
        }
        
        return userTypeString;
    }
    
    //check if the user entered email or phone numbers is repeated
    public int checkRepeat(String email, int phoneNumber) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL, PHONENUMBER FROM USERDETAILS");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
        
        //loop through the selected data in the database
        while (resultSet.next()){
            for (int i = 1; i <= numberOfColumns; i++) {
                String resultEmail = (String) resultSet.getObject(i);
                int resultPhone = Integer.parseInt(resultSet.getObject(i+1).toString());
                
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
    //checkif the mail is repaeted in database
    private int checkMailRepeat(String mail) throws SQLException{
        int value = 0;
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT EMAIL FROM USERDETAILS");
        
        //loop through the selected data in the database
        while (resultSet.next()){
            String email = resultSet.getObject(1).toString();
            
            if (email.equalsIgnoreCase(mail)){
                value = 1;
            }
        }
        
        return value;
    }
    //check if the phone number is repeated in database
    private int checkPhoneRepeat(String phoneNumber) throws SQLException{
        int value = 0;
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT PHONENUMBER FROM USERDETAILS");
        
        //loop through the selected data in the database
        while (resultSet.next()){
            String phone = resultSet.getObject(1).toString();
            
            if (phone.equalsIgnoreCase(phoneNumber)){
                value = 1;
            }
        }
        
        return value;
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
            Logger.getLogger(updatePassenger.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(updatePassenger.class.getName()).log(Level.SEVERE, null, ex);
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
