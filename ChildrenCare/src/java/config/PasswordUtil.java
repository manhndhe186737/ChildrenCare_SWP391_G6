package config;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 512; 

    public static String hashPassword(String password) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] hashedPassword = skf.generateSecret(spec).getEncoded();
        return Base64.getEncoder().encodeToString(salt) + "$" + Base64.getEncoder().encodeToString(hashedPassword);
    }

    public static boolean verifyPassword(String enteredPassword, String storedPassword) throws Exception {
        String[] parts = storedPassword.split("\\$");
        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] storedHashedPassword = Base64.getDecoder().decode(parts[1]);

        PBEKeySpec spec = new PBEKeySpec(enteredPassword.toCharArray(), salt, ITERATIONS, storedHashedPassword.length * 8);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
        byte[] hashedPassword = skf.generateSecret(spec).getEncoded();

        return java.util.Arrays.equals(storedHashedPassword, hashedPassword);
    }
}
