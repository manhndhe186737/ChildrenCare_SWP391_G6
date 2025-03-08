/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import model.User;
import model.Reservation;

/**
 *
 * @author FPTSHOP
 */
public class ReservationDBContext extends DBContext {

    public ArrayList<Service> getServices() {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "select * from Services";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery();) {

            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));

                services.add(s);
            }
        } catch (Exception e) {
        }
        return services;
    }

    public Service getServicesById(int id) {
        String sql = "select * from Services where service_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));
                s.setCategoryId(rs.getInt("category_id"));

                return s;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean insertReservation(Reservation reservation) {
        String sql = "INSERT INTO reservations (dateBook, user_id, service_id, status, staff_id, createDate, updateDate, note, starttime, endtime, customer_name, customer_address) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setDate(1, reservation.getBookdate());
            stm.setInt(2, reservation.getCustomer().getId());
            stm.setInt(3, reservation.getService().getId());
            stm.setString(4, reservation.getStatus());
            stm.setInt(5, reservation.getStaff().getId());
            stm.setDate(6, reservation.getCreatedate());
            stm.setDate(7, reservation.getUpdatedate());
            stm.setString(8, reservation.getNote());
            stm.setTime(9, reservation.getStart());
            stm.setTime(10, reservation.getEnd());
            stm.setString(11, reservation.getCustomerName());
            stm.setString(12, reservation.getCustomerAddress());

            int rowsInserted = stm.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Service> getServicesInCart(int userId) {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "select s.* from users u\n"
                + "join cart c\n"
                + "on u.user_id = c.user_id\n"
                + "join services s\n"
                + "on c.service_id = s.service_id\n"
                + "where u.user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, userId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setPrice(rs.getFloat("price"));
                s.setDescription(rs.getString("description"));
                s.setImg(rs.getString("img"));

                services.add(s);
            }
        } catch (Exception e) {
        }
        return services;
    }

    public ArrayList<User> getStaff() {
        ArrayList<User> staff = new ArrayList<>();
        String sql = "select * from users u\n"
                + "join userroles ur\n"
                + "on ur.email = u.email\n"
                + "join roles r\n"
                + "on r.role_id = ur.role_id\n"
                + "where r.role_name = 'Staffs'";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery();) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));

                staff.add(u);
            }
        } catch (Exception e) {
        }
        return staff;
    }

    public ArrayList<Reservation> getReservationByUserId(int userId, String sortColumn, String sortOrder, String searchQuery, String statusFilter) {
        ArrayList<Reservation> reservations = new ArrayList<>();

        // Truy vấn SQL cho phép tìm kiếm theo tên dịch vụ (s.name) và lọc theo trạng thái
        String sql = "SELECT r.reserv_id, r.dateBook, r.status, r.createDate, r.updateDate, r.note, r.starttime, r.endtime, "
                + "r.service_id, s.name, s.price "
                + "FROM reservations r "
                + "JOIN users u ON r.user_id = u.user_id "
                + "JOIN services s ON r.service_id = s.service_id "
                + "WHERE u.user_id = ? ";

        // Thêm điều kiện tìm kiếm nếu có từ khóa
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += "AND s.name LIKE ? ";
        }

        // Thêm điều kiện lọc theo trạng thái
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql += "AND r.status = ? ";
        }

        // Thêm điều kiện sắp xếp theo cột
        if (sortColumn != null && !sortColumn.isEmpty()) {
            sql += "ORDER BY " + sortColumn + " " + sortOrder;
        } else {
            sql += "ORDER BY s.name ASC"; // Mặc định sắp xếp theo tên dịch vụ (tăng dần)
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId); // Đặt user_id vào câu lệnh truy vấn

            // Nếu có từ khóa tìm kiếm, đặt tham số tìm kiếm vào câu lệnh SQL
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                stm.setString(2, "%" + searchQuery + "%"); // Tìm kiếm theo tên dịch vụ (s.name)
            }

            // Nếu có trạng thái lọc, đặt tham số trạng thái vào câu lệnh SQL
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                stm.setString(3, statusFilter); // Lọc theo trạng thái
            }

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setId(rs.getInt("reserv_id"));
                    reservation.setBookdate(rs.getDate("dateBook"));
                    reservation.setStatus(rs.getString("status"));
                    reservation.setUpdatedate(rs.getDate("updateDate"));
                    reservation.setCreatedate(rs.getDate("createDate"));
                    reservation.setNote(rs.getString("note"));
                    reservation.setStart(rs.getTime("starttime"));
                    reservation.setEnd(rs.getTime("endtime"));

                    // Lấy thông tin dịch vụ (service)
                    Service service = new Service();
                    service.setId(rs.getInt("service_id"));
                    service.setName(rs.getString("name"));
                    service.setPrice(rs.getFloat("price"));
                    reservation.setService(service);

                    reservations.add(reservation);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservations;
    }

    public ArrayList<User> getAvailableStaff(String date, String startTime, String endTime) {
        ArrayList<User> staff = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM users usr\n"
                + "JOIN userroles ur ON ur.email = usr.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = 'Staffs' \n"
                + "AND usr.user_id NOT IN (\n"
                + "    SELECT staff_id\n"
                + "    FROM users u\n"
                + "    JOIN userroles ur ON ur.email = u.email\n"
                + "    JOIN roles r ON r.role_id = ur.role_id\n"
                + "    JOIN reservations res ON res.staff_id = u.user_id\n"
                + "    AND res.datebook = ? \n"
                + "    WHERE r.role_name = 'Staffs'\n"
                + "    AND (\n"
                + "        (res.starttime <= ? AND res.endtime >= ?)\n"
                + "        AND res.status LIKE 'Scheduled'\n"
                + "    )\n"
                + ")";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, date);  // Ngày được chọn
            stm.setString(2, endTime);  // Thời gian bắt đầu
            stm.setString(3, startTime);    // Thời gian kết thúc

            int currentId = -1;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setFullname(rs.getString("fullname"));
                    u.setAvatar(rs.getString("avatar"));

                    if (currentId != u.getId()) {
                        staff.add(u);
                        currentId = u.getId();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }
    
    public ArrayList<User> getAvailableStaffById(String date, String startTime, String endTime, int id) {
        ArrayList<User> staff = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM users usr\n"
                + "JOIN userroles ur ON ur.email = usr.email\n"
                + "JOIN roles r ON r.role_id = ur.role_id\n"
                + "WHERE r.role_name = 'Staffs' \n"
                + "AND usr.user_id NOT IN (\n"
                + "    SELECT staff_id\n"
                + "    FROM users u\n"
                + "    JOIN userroles ur ON ur.email = u.email\n"
                + "    JOIN roles r ON r.role_id = ur.role_id\n"
                + "    JOIN reservations res ON res.staff_id = u.user_id\n"
                + "    AND res.datebook = ? \n"
                + "    WHERE r.role_name = 'Staffs'\n"
                + "    AND (\n"
                + "        (res.starttime <= ? AND res.endtime >= ?)\n"
                + "        AND res.status LIKE 'Scheduled'\n"
                + "    )\n"
                + ") AND usr.user_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, date);  // Ngày được chọn
            stm.setString(2, endTime);  // Thời gian bắt đầu
            stm.setString(3, startTime);    // Thời gian kết thúc
            stm.setInt(4, id);

            int currentId = -1;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setFullname(rs.getString("fullname"));
                    u.setAvatar(rs.getString("avatar"));

                    if (currentId != u.getId()) {
                        staff.add(u);
                        currentId = u.getId();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public User getStaffById(int id) {
        String sql = "SELECT user_id, fullname FROM users WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));

                return u;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean addToCart(int userId, int serviceId) {
        String sql = "INSERT INTO Cart (user_id, service_id) VALUES (?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, serviceId);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            return false;
        }
    }

    public void deleteCart(int user_id, int cart_id) {
        String sql = "delete from cart where user_id = ? and service_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, user_id);
            stm.setInt(2, cart_id);

            stm.executeUpdate();

        } catch (Exception e) {
        }
    }
}
