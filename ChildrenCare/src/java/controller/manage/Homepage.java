/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manage;

import dal.BlogDBContext;
import dal.PostDBContext;
import dal.ServiceDBContext;
import dal.SliderDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Post;
import model.Role;

/**
 *
 * @author FPTSHOP
 */
@WebServlet(name = "Homepage", urlPatterns = {"/c/home"})
public class Homepage extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Homepage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Homepage at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account account = (Account) request.getSession().getAttribute("account");
        String role = "Admin, Customer, Staffs";
        String roles = "";
        String isLogin = "";
        if (account != null) {
            for (Role r : account.getRoles()) {
                roles += r.getRname() + ", ";
            }
            isLogin += "1";
        }

        PostDBContext pdb = new PostDBContext();
        List<Post> posts = pdb.getHomePosts();

        ServiceDBContext sdb = new ServiceDBContext();
        SliderDBContext sliderDB = new SliderDBContext();

        BlogDBContext bdb = new BlogDBContext();

        String fullContent = bdb.getPostNew().getContent(); // HTML từ TinyMCE
        String plainText = stripHtmlTags(fullContent);

        String shortContent = plainText;
        if (plainText.length() > 600) {
            shortContent = plainText.substring(0, 600) + "............";
        }

        request.setAttribute("shortcontent", shortContent);
        request.setAttribute("blog", bdb.getPostNew());
        request.setAttribute("posts", posts);
        request.setAttribute("sliders", sliderDB.getActiveSliders());
        request.setAttribute("services", sdb.getHomeServices());
        request.setAttribute("login", isLogin);
        response.getWriter().print(isLogin);
        request.setAttribute("role", roles);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    public static String stripHtmlTags(String html) {
        return html.replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ").trim();
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
