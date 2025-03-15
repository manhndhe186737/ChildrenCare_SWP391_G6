package controller.manage;

import dal.CustomerDBContext;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.sql.Date;

@WebServlet("/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String bio = request.getParameter("bio");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dob");
        Date dob = null;
        if (dobStr != null){
             dob = Date.valueOf(dobStr);
        }
        // Handle file upload for avatar
        String avatarUrl = "";
        
        String oldImage = request.getParameter("avatar_url");

        
        String imagePath = oldImage;
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                imagePath = "uploads/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            }

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        

        // Update user information
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setBio(bio);
        user.setAddress(address);
        user.setDob(dob);

        // Update avatar if a new file is uploaded
        if (imagePath != null && !imagePath.isEmpty()) {
            user.setAvatar(imagePath);
        }

        // Save the updated user data into the database
        CustomerDBContext customerDBContext = new CustomerDBContext();
        customerDBContext.editCustomer(user);

        // Update user in the session
        //session.setAttribute("user", user);
        // Forward updated user to profile page
       //request.setAttribute("user", user);  // Set user attribute for display in JSP
       response.sendRedirect(request.getContextPath() + "/profile"); // Redirect to profile page
       
    }

    // Method to handle file upload for avatar
    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("avatar");
        if (filePart == null) {
            return null;
        }

        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Define path to save the uploaded file
        String avatarFilePath = "staff" + "/" + fileName;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "staff";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save the uploaded file
        try (OutputStream out = new FileOutputStream(uploadPath + File.separator + fileName); InputStream fileContent = filePart.getInputStream()) {
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = fileContent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
        } catch (IOException e) {
            e.printStackTrace();
            // You can set an error message here if needed
        }

        return avatarFilePath;
    }

    // Extract file name from the uploaded part
    private String getFileName(final Part part) {
        if (part == null) {
            return null;
        }
        final String partHeader = part.getHeader("content-disposition");
        if (partHeader == null) {
            return null;
        }
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
