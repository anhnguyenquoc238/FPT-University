package servlet;

import businesslayer.UserManagement;
import exception.MyException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import messagecachelayer.MessageCache;
import model.Message;
import model.User;

/**
 *
 * @author Lenovo T530
 */
public class BaseServlet extends HttpServlet {

    private static List<User> onlineUserList = new ArrayList();

    private static MessageCache messageCache = new MessageCache();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BaseServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BaseServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected List<User> getOnlineUserList() {
        return onlineUserList;
    }

    protected boolean checkOnlineBySession(HttpServletRequest request) {
        if (request.getSession().getAttribute("username") != null) {
            return true;
        }
        return false;
    }

    protected User getUserInformation(HttpServletRequest request) throws MyException {
        return UserManagement.getUserByUsername(request.getSession().getAttribute("username").toString());
    }

    protected int addMessage(Message newMessage) {
        return messageCache.addMessage(newMessage);
    }

    protected List<Message> getOldMessage(int firstMessID) {
        return messageCache.getOldMessage(firstMessID);
    }

    protected List<Message> getRecentMessage() {
        return messageCache.getRecentMessage();
    }

    protected List<Message> getNewMessage(int lastMessID) {
        return messageCache.getNewMessage(lastMessID);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
