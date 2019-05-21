/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import businesslayer.UserManagement;
import exception.MyException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Lenovo T530
 */
public class SigninServlet extends BaseServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // check log in if log in go to home
       protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SigninServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SigninServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        RequestDispatcher rd = request.getServletContext().getRequestDispatcher("/WEB-INF/signin.html");
        rd.forward(request, response);
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
        // else get the information to validate
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            //  validate account
            if (!accountValidate(username, password, request)) {
                RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/signin.jsp");
                rd.forward(request, response);
                return;
            }

            User u = UserManagement.getUserByUsername(username);
            if (getOnlineUserList().contains(u)) {
                request.setAttribute("duplicateAccountMessage", "Account has been signed in!");
                RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/signin.jsp");
                rd.forward(request, response);
                return;
            } else {
                // account validate successfully 
                // add cookies and set online
                request.getSession().setAttribute("username", username);
                response.sendRedirect("home");
                return;
            }
        } catch (MyException ex) {
            request.setAttribute("exception", ex);
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/exception.jsp");
            rd.forward(request, response);
        }
    }

     public boolean accountValidate(String username, String password, HttpServletRequest request) throws MyException {
        User u = new User(username, password);
        // validate username
        if (!UserManagement.checkUserName(username)) {
            request.setAttribute("usernameErrorMessage", "User doesn't exist!");
            return false;
        }
        // validate password
        if (!UserManagement.checkAccount(u)) {
            request.setAttribute("passwordErrorMessage", "Wrong Password!");
            return false;
        }
        // return true if validate successfully
        return true;
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
