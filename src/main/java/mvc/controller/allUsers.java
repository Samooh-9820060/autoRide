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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mvc.model.allUsersViewModel;


/**
 *
 * @author samoo
 */
public class allUsers extends HttpServlet {

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
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT FIRSTNAME, LASTNAME, EMAIL, TELEPHONE, USERTYPE, VEHICLETYPE FROM USERDETAILS");

            List<allUsersViewModel> allUsers = new ArrayList<>();
            
            while (resultSet.next()){
                allUsersViewModel user = new allUsersViewModel();
                user.firstName = (String) resultSet.getObject(1);
                user.lastName = (String) resultSet.getObject(2);
                user.eMail = (String) resultSet.getObject(3);
                user.telephone = resultSet.getObject(4)+"";
                user.userType = userType(resultSet.getObject(5).toString().trim());
                user.vehicleType = vehicleType(resultSet.getObject(6).toString().trim());
                allUsers.add(user);
            }
            
            request.setAttribute("allUsers", allUsers);
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/allUsers.jsp");
            rd.forward(request, response);
        }
    }
    
    private String vehicleType(String receiptVehicleTypeID) throws SQLException{
        String vehicleName = "";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statementVehicles = connection.createStatement();
        ResultSet resultSetVehicles = statementVehicles.executeQuery("SELECT VEHICLEID, VEHICLENAME FROM VEHICLES");

        while (resultSetVehicles.next()){
            String resultVehicleID = resultSetVehicles.getObject(1).toString().trim();
            String resultVehicleName = resultSetVehicles.getObject(2).toString();
            if (receiptVehicleTypeID.equals(resultVehicleID)){
                vehicleName = resultVehicleName;
            }
        }
        
        
        return vehicleName;
    }
    
    private String userType(String userTypeID) throws SQLException{
        String userType = "";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statementUsers = connection.createStatement();
        ResultSet resultSetUsers = statementUsers.executeQuery("SELECT ID, NAME FROM USERTYPES");

        while (resultSetUsers.next()){
            String resultUserID = resultSetUsers.getObject(1).toString().trim();
            String resultUserName = resultSetUsers.getObject(2).toString();
            if (resultUserID.equals(userTypeID)){
                userType = resultUserName;
            }
        }
        
        
        return userType;
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
            Logger.getLogger(allUsers.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(allUsers.class.getName()).log(Level.SEVERE, null, ex);
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
