package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import businesslayer.UserManagement;
import exception.MyException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import model.User;

/**
 *
 * @author Daichi
 */
public class RegisterServlet extends BaseServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
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
        if (checkOnlineBySession(request)) {
            response.sendRedirect("home");
            return;
        }
        RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/register.jsp");
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
        try {
            String email = request.getParameter("email").trim();
            String username = request.getParameter("username").trim();
            String displayname = request.getParameter("displayname").trim();
            String psw = request.getParameter("psw");
            String pswRepeat = request.getParameter("psw-repeat");

            // validate input
            if (!validateInput(email, username, displayname, psw, pswRepeat, request)) {
                RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/register.jsp");
                rd.forward(request, response);
                return;
            } else { 
                // validation successful
                // create account successful forward to sign in
                User u = new User(username, displayname, email, psw);
                UserManagement.insertAccount(u);
                // set Cookie and redirect to home
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

    public boolean validateInput(String email, String username, String name, String psw, String pswRepeat, HttpServletRequest request) throws MyException {
        // check empty username
        if (username.isEmpty()) {
            request.setAttribute("userEmptyErrorMessage", "Username cannot be empty");
            return false;
        } 
        // validate user
        if (UserManagement.checkUserName(username)) {
            request.setAttribute("userExistedErrorMessage", "An username like this already existed");
            return false;
        }
        // check empty name
        if (name.isEmpty()) {
            request.setAttribute("nameEmptyErrorMessage", "Name cannot be empty");
            return false;
        }
        // check invalid password form
        if (psw.contains(" ")) {
            request.setAttribute("pswSpaceErrorMessage", "Password cannot contain space");
            return false;
        }
        // check valid confirmation password
        if (!psw.equals(pswRepeat)) {
            request.setAttribute("pswRepeatErrorMessage", "Repeat Password does not match");
            return false;
        }
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
