/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vnpay;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;

public class VNPayUtils {

    public static String generatePaymentUrl(String vnpUrl, Map<String, String> params, String secretKey) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames); // Sắp xếp tham số theo thứ tự alphabet

        StringBuilder query = new StringBuilder();
        StringBuilder hashData = new StringBuilder();

        for (String fieldName : fieldNames) {
            String value = params.get(fieldName);
            if (value != null && !value.isEmpty()) {
                try {
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8.toString()))
                            .append("=")
                            .append(URLEncoder.encode(value, StandardCharsets.UTF_8.toString()))
                            .append("&");

                    hashData.append(fieldName).append("=").append(value).append("&");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // Bỏ ký tự `&` cuối cùng trước khi hash
        String queryString = query.substring(0, query.length() - 1);
        String rawHash = hashData.substring(0, hashData.length() - 1);

        // Tạo SecureHash SHA-512
        String secureHash = hmacSHA512(secretKey, rawHash);

        return vnpUrl + "?" + queryString + "&vnp_SecureHash=" + secureHash;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(key.getBytes(StandardCharsets.UTF_8));
            byte[] hash = md.digest(data.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(Integer.toHexString(0xFF & b));
            }
            return hexString.toString().toUpperCase(); // Chữ ký phải viết HOA
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
