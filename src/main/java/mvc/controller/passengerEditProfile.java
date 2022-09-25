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
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class passengerEditProfile extends HttpServlet {

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
            String passengerIDString = getPassengerID(mail);
            
            String userId = null;
            String firstName = null;
            String lastName = null;
            String phoneNumber = null;
            String idnumber = null;
            String address = null;
            String postalcode = null;
            String district = null;
            String island = null;
            String email = null;
            String emergencyContactName = null;
            String emergencyContactNumber = null;
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT USERID, FIRSTNAME, LASTNAME, PHONENUMBER, IDNUMBER, ADDRESS, POSTALCODE, DISTRICT, ISLAND, EMAIL, EMERGENCYCONTACTNAME, EMERGENCYCONTACTNUMBER FROM USERDETAILS");
            while (resultSet.next()){
                String userid = resultSet.getObject(1)+"".trim();
                if (userid.equals(passengerIDString)){
                    userId = userid;
                    firstName = (resultSet.getObject(2)+"").trim();
                    lastName = (resultSet.getObject(3)+"").trim();
                    phoneNumber = (resultSet.getObject(4)+"").trim();
                    idnumber = (resultSet.getObject(5)+"").replace("null", "");
                    address = (resultSet.getObject(6)+"").replace("null", "");
                    postalcode = (resultSet.getObject(7)+"").replace("null", "");
                    district = (resultSet.getObject(8)+"").replace("null", "");
                    island = (resultSet.getObject(9)+"").replace("null", "");
                    email = (resultSet.getObject(10)+"").trim();
                    emergencyContactName = (resultSet.getObject(11)+"").replace("null", "");
                    emergencyContactNumber = (resultSet.getObject(12)+"").replace("null", "");
                }
            }
            
            request.setAttribute("userId", userId);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("idNumber", idnumber);
            request.setAttribute("address", address);
            request.setAttribute("postalCode", postalcode);
            request.setAttribute("district", district);
            request.setAttribute("island", island);
            request.setAttribute("email", email);
            request.setAttribute("emergencyContactName", emergencyContactName);
            request.setAttribute("emergencyContactNumber", emergencyContactNumber);
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/passengerMyProfile.jsp");
            rd.forward(request, response);

        }
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
            Logger.getLogger(passengerEditProfile.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(passengerEditProfile.class.getName()).log(Level.SEVERE, null, ex);
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
