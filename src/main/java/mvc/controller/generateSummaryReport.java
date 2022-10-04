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
public class generateSummaryReport extends HttpServlet {

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
            String date = request.getParameter("date");
            
            int totalBookings = 0;
            double totalRevenue = 0.00;
            double totalDistance = 0.00;
            int totalDuration = 0;
            
            int todayBookings = 0;
            double todayRevenue = 0.00;
            double todayDistance = 0.00;
            int todayDuration = 0; 
            
            Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
            Statement statement;
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT CURRENTDATE, DISTANCE, DURATION, TOTALPRICE, STATUS FROM BOOKINGDETAILS");
            while (resultSet.next()){
                //get all details requried to fill the summary report from database
                String orderDate = resultSet.getObject(1).toString().trim();
                String distance = resultSet.getObject(2).toString().trim().replace(" km", "");
                String duration = resultSet.getObject(3).toString().trim().replace(" mins", "");
                String totalPrice = resultSet.getObject(4).toString().trim();
                String status = resultSet.getObject(5).toString().trim();
                
                if (status.equals("Complete")){
                    totalBookings++;
                    totalRevenue += Double.parseDouble(totalPrice);
                    totalDistance += Double.parseDouble(distance);
                    totalDuration += Integer.parseInt(duration);
                    
                    if (orderDate.equals(date)){
                        todayBookings++;
                        todayRevenue += Double.parseDouble(totalPrice);
                        todayDistance += Double.parseDouble(distance);
                        todayDuration += Integer.parseInt(duration);
                    }
                }
            }
            
            request.setAttribute("todayBookings", todayBookings);
            request.setAttribute("todayRevenue", String.format("%.2f", todayRevenue));
            request.setAttribute("todayDistance", String.format("%.2f", todayDistance));
            request.setAttribute("todayDuration", todayDuration);
            
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalRevenue", String.format("%.2f", totalRevenue));
            request.setAttribute("totalDistance", String.format("%.2f", totalDistance));
            request.setAttribute("totalDuration", totalDuration);
            
            request.setAttribute("date", date);
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/summaryReport.jsp");
            rd.forward(request, response); 
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
            Logger.getLogger(generateSummaryReport.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(generateSummaryReport.class.getName()).log(Level.SEVERE, null, ex);
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
