<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Feedback, dal.FeedbackDBContext"%>
<%@page import="model.Reservation, model.Service, model.User"%>
<%@page import="java.sql.SQLException"%>
<%
    int feedbackId = Integer.parseInt(request.getParameter("id"));
    FeedbackDBContext db = new FeedbackDBContext();
    Feedback feedback = null;
    try {
       feedback = db.getFeedbackById(feedbackId);


    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Detail</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Feedback Detail</h2>
    <% if (feedback != null) { %>
        <form action="updateFeedback" method="post">
            <input type="hidden" name="feedback_id" value="<%= feedback.getId() %>">
            <label>Rating:</label>
            <input type="text" name="rating" value="<%= feedback.getRating() %>">
            <label>Comment:</label>
            <textarea name="comment"><%= feedback.getComment() %></textarea>
            <label>Image:</label>
            <input type="text" name="img" value="<%= feedback.getImg() %>">
            <label>Status:</label>
            <select name="status">
                <option value="1" <%= feedback.getStatus() == 1 ? "selected" : "" %>>Visible</option>
                <option value="0" <%= feedback.getStatus() == 0 ? "selected" : "" %>>Hidden</option>
            </select>
            <button type="submit">Update</button>
        </form>
        <form action="deleteFeedback" method="post">
            <input type="hidden" name="feedback_id" value="<%= feedback.getId() %>">
            <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
        </form>
    <% } else { %>
        <p>Feedback not found.</p>
    <% } %>
    <a href="feedbacklist.jsp">Back to Feedback List</a>
</body>
</html>
