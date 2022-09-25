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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mvc.model.queriesViewModel;

/**
 *
 * @author samoo
 */
public class allQueries extends HttpServlet {

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
            List<queriesViewModel> queries = queries();
            
            Collections.reverse(queries);
            
            request.setAttribute("queriesList", queries);
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/queries.jsp");
            rd.forward(request, response);
        }
    }

    public List<queriesViewModel> queries () throws SQLException{
        List<queriesViewModel> queriesList = new ArrayList<>();
        
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT MAIL, TYPE, DETAILS, CURRENTDATE, CURRENTTIME, STATUS FROM QUERIES");
        
        int i = 1;
        
        while (resultSet.next()){
            queriesViewModel tempList = new queriesViewModel();
            String resultEmail = (String) resultSet.getObject(1);
            if (resultEmail.isBlank()){
                tempList.queriedBy = "Anonymous";
            } else {
                tempList.queriedBy = resultEmail;
            }
            
            tempList.queryNo = i+"";
            tempList.type = (String) resultSet.getObject(2);
            tempList.details = (String) resultSet.getObject(3);
            tempList.date = (String) resultSet.getObject(4);
            tempList.time = (String) resultSet.getObject(5);
            tempList.status = (String) resultSet.getObject(6);
            queriesList.add(tempList);
            i++;
        }
        
        return queriesList;
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
            Logger.getLogger(allQueries.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(allQueries.class.getName()).log(Level.SEVERE, null, ex);
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
