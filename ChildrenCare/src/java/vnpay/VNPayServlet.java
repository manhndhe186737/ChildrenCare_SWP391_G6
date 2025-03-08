/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import com.sun.mail.smtp.SMTPSSLTransport;
import dal.ReservationDBContext;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Time;
import java.time.Duration;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import model.Reservation;
import model.Service;
import model.User;

@WebServlet(name = "VNPayServlet", urlPatterns = {"/c/vn-pay"})
public class VNPayServlet extends HttpServlet {

    private static final String VNP_TMNCODE = "3GUPFUSL";
    static final String VNP_HASH_SECRET = "23AW8VTNBO09FPULD7UPI7T6W72JIDOO";
    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String RETURN_URL = "http://localhost:8080/ChildrenCare/vnpay-return";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
        String vnp_OrderInfo = req.getParameter("vnp_OrderInfo");
        String orderType = req.getParameter("ordertype");
        String vnp_TmnCode = VNP_TMNCODE;

        Reservation reservation = new Reservation();
        reservation.setBookdate(java.sql.Date.valueOf(req.getParameter("date")));
        LocalDate current = LocalDate.now();
        reservation.setCreatedate(java.sql.Date.valueOf(current));
        reservation.setNote(req.getParameter("comments"));

        Time starttime = Time.valueOf(req.getParameter("starttime") + ":00");
        Time endtime = Time.valueOf(req.getParameter("endtime") + ":00");
        reservation.setStart(Time.valueOf(req.getParameter("starttime") + ":00"));
        reservation.setEnd(Time.valueOf(req.getParameter("endtime") + ":00"));
        reservation.setCustomerName(req.getParameter("name"));
        reservation.setCustomerAddress(req.getParameter("address"));

        User customer = new User();
        customer.setId(Integer.parseInt(req.getParameter("cus_id")));

        User staff = new User();
        staff.setId(Integer.parseInt(req.getParameter("staff")));

        ReservationDBContext rdb = new ReservationDBContext();
        Service s = rdb.getServicesById(Integer.parseInt(req.getParameter("service")));
        //Service s = new Service();
        //s.setId(Integer.parseInt(req.getParameter("service")));

        reservation.setCustomer(customer);
        reservation.setStaff(staff);
        reservation.setService(s);

        HttpSession session = req.getSession();
        session.setAttribute("reservation", reservation);

        int amount = 0;
        double amountVND = 0;

        String amount_raw = req.getParameter("service_price");

        if (amount_raw != null && !amount_raw.isEmpty()) {

            double amountUSD = Double.parseDouble(amount_raw);

            double exchangeRate = 23500.0;

            amountVND = amountUSD * exchangeRate;

            // Tính số phút giữa starttime và endtime
            long totalMinutes = Duration.between(starttime.toLocalTime(), endtime.toLocalTime()).toMinutes();
            double totalHours = totalMinutes / 60.0; // Chuyển đổi thành giờ

            // Nếu dịch vụ có categoryId = 5, nhân giá theo số giờ
            if (s.getCategoryId() == 5) {
                amountVND *= totalHours;
            }
        }

        amount = (int) amountVND * 100;

        String vnp_IpAddr = req.getRemoteAddr();

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", RETURN_URL);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(new Date());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        Calendar cld = Calendar.getInstance();
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Sort and build query
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, "UTF-8")).append('&');
                query.append(URLEncoder.encode(fieldName, "UTF-8")).append('=').append(URLEncoder.encode(fieldValue, "UTF-8")).append('&');
            }
        }
        hashData.deleteCharAt(hashData.length() - 1);
        query.deleteCharAt(query.length() - 1);

        String vnp_SecureHash = null;
        try {
            vnp_SecureHash = hmacSHA512(VNP_HASH_SECRET, hashData.toString());
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(VNPayServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeyException ex) {
            Logger.getLogger(VNPayServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);
        String paymentUrl = VNP_URL + "?" + query.toString();

        resp.sendRedirect(paymentUrl);
    }

    private static String hmacSHA512(String key, String data) throws NoSuchAlgorithmException, InvalidKeyException {
        Mac sha512_HMAC = Mac.getInstance("HmacSHA512");
        SecretKeySpec secret_key = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        sha512_HMAC.init(secret_key);
        byte[] hash = sha512_HMAC.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder result = new StringBuilder();
        for (byte b : hash) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

}
