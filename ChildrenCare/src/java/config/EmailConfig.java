package config;

import java.io.UnsupportedEncodingException;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailConfig {

    private static final String FROM_EMAIL = "thangvche179003@fpt.edu.vn";
    private static final String PASSWORD = "teicdxlonkgqdqwu";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    public static Session createEmailSession() {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    public void sendVerificationEmail(String toEmail, String token) throws MessagingException, UnsupportedEncodingException {
        Session session = createEmailSession();
        String subject = "Xác Minh Địa Chỉ Email Của Bạn";
        subject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String verificationLink = "http://localhost:8080/ChildrenCare/login?service=verify&token=" + token + "&type=register";

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            message.setContent("Click vào liên kết sau để xác minh địa chỉ email của bạn: " + verificationLink + "\n\n"
                    + "Liên kết này sẽ hết hạn trong 1 giờ. Vui lòng xác minh email của bạn trước khi liên kết hết hạn.", "text/plain; charset=UTF-8");

            Transport.send(message);
            System.out.println("Email xác minh đã được gửi đến " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new MessagingException("Gửi email xác minh thất bại.");
        }
    }

    public void sendPasswordResetEmail(String toEmail, String token) throws MessagingException, UnsupportedEncodingException {
        Session session = createEmailSession();
        String subject = "Đặt Lại Mật Khẩu Của Bạn";
        subject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String resetLink = "http://localhost:8080/ChildrenCare/login?service=resetPassword&token=" + token + "&type=resetPassword";

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            message.setContent("Click vào liên kết sau để đặt lại mật khẩu của bạn: " + resetLink + "\n\n"
                    + "Liên kết này sẽ hết hạn trong 1 giờ. Vui lòng đặt lại mật khẩu của bạn trước khi liên kết hết hạn.", "text/plain; charset=UTF-8");

            Transport.send(message);
            System.out.println("Email đặt lại mật khẩu đã được gửi đến " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new MessagingException("Gửi email đặt lại mật khẩu thất bại.");
        }
    }

}
