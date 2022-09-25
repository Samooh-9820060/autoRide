/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mvc.controller;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author samoo
 */
public class submitQuery extends HttpServlet {

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
            throws ServletException, IOException, SQLException, InterruptedException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String security = request.getParameter("security");
            String typeOfIssue = request.getParameter("typeOfIssue");
            String details = request.getParameter("explanation");
            String userMail = "";
            if (security.equals("share")){
                HttpSession session = request.getSession();
                userMail = session.getAttribute("session").toString();
            }
            
            addQuery(userMail, typeOfIssue, details);
            Thread.sleep(500);
            response.sendRedirect("./jsp/homePage.jsp");
        }
    }
    
    private void addQuery(String userMail, String type, String details) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement = connection.createStatement();
        SimpleDateFormat formatterDate = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat formatterTime = new SimpleDateFormat("HH:mm:ss");
        Date currentDateTime = new Date(); 
        String currentDate = formatterDate.format(currentDateTime);
        String currentTime = formatterTime.format(currentDateTime);
        String status = "Not_Fixed";
        String rowNum = (Integer.parseInt(getLastRow().trim())+1)+"";
        statement.executeUpdate("INSERT INTO QUERIES VALUES ('"+userMail+"', '"+type+"', '"+details+"', '"+currentDate+"', '"+currentTime+"', '"+status+"', '"+rowNum+"')");
    }
    
    private String getLastRow() throws SQLException{
        String rowNum = "0";
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT QUERYNO FROM QUERIES");
        while (resultSet.next()){
            rowNum = (String) resultSet.getObject(1);
        }
        
        return rowNum;
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
        } catch (SQLException | InterruptedException ex) {
            Logger.getLogger(submitQuery.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | InterruptedException ex) {
            Logger.getLogger(submitQuery.class.getName()).log(Level.SEVERE, null, ex);
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
