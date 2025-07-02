package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import operations.RegisterOperations;

import java.io.IOException;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
    private final RegisterOperations crud = new RegisterOperations();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            handleLogin(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            forward(request, response, "error", "Login failed: " + e.getMessage(), "test_session_info.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("port_id");
        String pw = request.getParameter("password");
        String role = request.getParameter("role");

        if (id == null || id.isBlank() || pw == null || pw.isBlank() || role == null || role.isBlank()) {
            forward(request, response, "error", "All fields are required.", "test_session_info.jsp");
            return;
        }

        User user = crud.find(id, role);
        System.out.println(user.getPortId()+role);
        if (user == null) {
            forward(request, response, "error", "User not found.", "test_session_info.jsp");
        } else if (!user.getPassword().equals(pw)) {
            forward(request, response, "error", "Incorrect password.", "test_session_info.jsp");
        } else {
            // Store user in session
            request.getSession(true).setAttribute("user", user);
            forward(request, response, "success", "Login successful. Welcome " + user.getPortId(), "test_session_info.jsp");
        }
    }

    private static void forward(HttpServletRequest r, HttpServletResponse s,
                                String attr, String msg, String page)
            throws ServletException, IOException {
        r.setAttribute(attr, msg);
        r.getRequestDispatcher(page).forward(r, s);
    }
}
