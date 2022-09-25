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
public class editUser extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String id = request.getParameter("editUserID");
            String type = request.getParameter("editUserType");
            
            String userID = id;
            String firstName = null;
            String lastName = null;
            String phoneNumber = null;
            String idNumber = null;
            String address = null;
            String postalCode = null;
            String district = null;
            String island = null;
            String email = null;
            String emergencyContactName = null;
            String emergencyContactNumber = null;
            String vehicleType = null;
            String vehicleRegNo = null;
            String licenseNo  = null;
            String userType = null;
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT USERID, FIRSTNAME, LASTNAME, PHONENUMBER, IDNUMBER, ADDRESS, POSTALCODE, DISTRICT, ISLAND, EMAIL, EMERGENCYCONTACTNAME, EMERGENCYCONTACTNUMBER, USERTYPE, VEHICLETYPE, VEHICLEREGNO, LICENSENO FROM USERDETAILS");
            while (resultSet.next()){
                String resultUserID = resultSet.getObject(1).toString().trim();
                
                if (resultUserID.equals(userID)){
                    firstName = resultSet.getObject(2).toString().trim();
                    lastName = resultSet.getObject(3).toString().trim();
                    phoneNumber = resultSet.getObject(4).toString().trim();
                    idNumber = resultSet.getObject(5)+"".trim();
                    address = resultSet.getObject(6)+"".trim();
                    postalCode = resultSet.getObject(7)+"".trim();
                    district = resultSet.getObject(8)+"".trim();
                    island = resultSet.getObject(9)+"".trim();
                    email = resultSet.getObject(10).toString().trim();
                    emergencyContactName = resultSet.getObject(11)+"".trim();
                    emergencyContactNumber = resultSet.getObject(12)+"".trim();
                    userType = resultSet.getObject(13)+"".trim();
                    vehicleType = resultSet.getObject(14)+"".trim();
                    vehicleRegNo = resultSet.getObject(15)+"".trim();
                    licenseNo = resultSet.getObject(16)+"".trim();
                }
            }
            
            if (type.equals("Passenger")){
                request.setAttribute("userID", userID);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("idNumber", idNumber);
                request.setAttribute("address", address);
                request.setAttribute("postalCode", postalCode);
                request.setAttribute("district", district);
                request.setAttribute("island", island);
                request.setAttribute("email", email);
                request.setAttribute("userType", userType);
                request.setAttribute("emergencyContactName", emergencyContactName);
                request.setAttribute("emergencyContactNumber", emergencyContactNumber);

                RequestDispatcher rd = request.getRequestDispatcher("./jsp/editPassenger.jsp");
                rd.forward(request, response);
            } else if (type.equals("Driver")){
                request.setAttribute("userID", userID);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("idNumber", idNumber);
                request.setAttribute("address", address);
                request.setAttribute("postalCode", postalCode);
                request.setAttribute("district", district);
                request.setAttribute("island", island);
                request.setAttribute("email", email);
                request.setAttribute("emergencyContactName", emergencyContactName);
                request.setAttribute("emergencyContactNumber", emergencyContactNumber);
                request.setAttribute("vehicleType", vehicleType);
                request.setAttribute("vehicleRegNo", vehicleRegNo);
                request.setAttribute("userType", userType);
                request.setAttribute("licenseNo", licenseNo);


                RequestDispatcher rd = request.getRequestDispatcher("./jsp/editDriver.jsp");
                rd.forward(request, response);
            }
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
            Logger.getLogger(editUser.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(editUser.class.getName()).log(Level.SEVERE, null, ex);
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
