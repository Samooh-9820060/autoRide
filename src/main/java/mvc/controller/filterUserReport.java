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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mvc.model.reportDetailsViewModel;


/**
 *
 * @author samoo
 */
public class filterUserReport extends HttpServlet {

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
            String userID = request.getParameter("filterID");
            String date = request.getParameter("filterDate");
            
            
            List<reportDetailsViewModel> reportDetails = new ArrayList<>();
            //add completed bookings, revenue, distance and duration for each driver to a list
            reportDetailsViewModel tempReportDetail = new reportDetailsViewModel();
            tempReportDetail.driverID = userID;
            tempReportDetail.completedBookings = getCompletedBookings(userID, date);
            tempReportDetail.revenue = getRevenue(userID, date);
            tempReportDetail.distance = getDistance(userID, date);
            tempReportDetail.duration = getDuration(userID, date);   
            
            reportDetails.add(tempReportDetail);
            
            request.setAttribute("reportDetailsList", reportDetails);
            request.setAttribute("date", date);
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/report.jsp");
            rd.forward(request, response); 
        }
    }
    //get revenue per driver per date
    private String getRevenue(String userID, String date) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        
        double totalRevenue = 0.00;
        
        ResultSet resultSet = statement.executeQuery("SELECT DRIVER, TOTALPRICE, STATUS, CURRENTDATE FROM BOOKINGDETAILS");
        while (resultSet.next()){
            String driverID = resultSet.getObject(1).toString().trim();
            String totalPrice = resultSet.getObject(2).toString().trim();
            String status = resultSet.getObject(3).toString().trim();
            String currentDate = resultSet.getObject(4).toString().trim();
            
            if (status.equalsIgnoreCase("Complete")){
                if (driverID.equalsIgnoreCase(userID)){
                    if (currentDate.equalsIgnoreCase(date)){
                        totalRevenue += Double.parseDouble(totalPrice);
                    }
                }
            }
        }
                
        String revenue = totalRevenue+"";
        
        return revenue;
    }
    //get completed bookings per driver per date
    private String getCompletedBookings(String userID, String date) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        
        int number = 0;
        
        ResultSet resultSet = statement.executeQuery("SELECT DRIVER, STATUS, CURRENTDATE FROM BOOKINGDETAILS");
        while (resultSet.next()){
            String driverID = resultSet.getObject(1).toString().trim();
            String status = resultSet.getObject(2).toString().trim();
            String currentDate = resultSet.getObject(3).toString().trim();
            
            if (status.equalsIgnoreCase("Complete")){
                if (driverID.equalsIgnoreCase(userID)){
                    if (currentDate.equalsIgnoreCase(date)){
                        number++;
                    }
                }
            }
        }
        
        String numberString = number+"";
        return numberString;
    }
    //get distance travelled per driver per date
    private String getDistance(String userID, String date) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        
        
        double distanceDouble = 0.00;
        
        ResultSet resultSet = statement.executeQuery("SELECT DRIVER, STATUS, CURRENTDATE, DISTANCE FROM BOOKINGDETAILS");
        while (resultSet.next()){
            String driverID = resultSet.getObject(1).toString().trim();
            String status = resultSet.getObject(2).toString().trim();
            String currentDate = resultSet.getObject(3).toString().trim();
            String distance = resultSet.getObject(4).toString().trim().replace(" km","");
            
            
            if (status.equalsIgnoreCase("Complete")){
                if (driverID.equalsIgnoreCase(userID)){
                    if (currentDate.equalsIgnoreCase(date)){
                        distanceDouble+= Double.parseDouble(distance);
                    }
                }
            }
        }
        
        String numberString = distanceDouble+"";
        return numberString;
    }
    //get total duration per driver per date
    private String getDuration(String userID, String date) throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/autoRide","username","password");
        Statement statement;
        statement = connection.createStatement();
        
        int durationDouble = 0;
        
        ResultSet resultSet = statement.executeQuery("SELECT DRIVER, STATUS, CURRENTDATE, DURATION FROM BOOKINGDETAILS");
        while (resultSet.next()){
            String driverID = resultSet.getObject(1).toString().trim();
            String status = resultSet.getObject(2).toString().trim();
            String currentDate = resultSet.getObject(3).toString().trim();
            String duration = resultSet.getObject(4).toString().trim().replace(" mins","").replace(" min", "");
            
            if (status.equalsIgnoreCase("Complete")){
                if (driverID.equalsIgnoreCase(userID)){
                    if (currentDate.equalsIgnoreCase(date)){
                        durationDouble+= Double.parseDouble(duration);
                    }
                }
            }
        }
        
        String numberString = durationDouble+"";
        return numberString;
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
            Logger.getLogger(filterUserReport.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(filterUserReport.class.getName()).log(Level.SEVERE, null, ex);
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
