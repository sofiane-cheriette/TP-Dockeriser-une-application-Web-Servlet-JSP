package fr.boutique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Comptes de test — pas de vraie base de données pour ce TP
    private static final Map<String, String> COMPTES = Map.of(
        "alice",  "alice123",
        "bob",    "bob456",
        "admin",  "admin"
    );

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Si déjà connecté, rediriger vers le catalogue
        if (req.getSession().getAttribute("utilisateur") != null) {
            resp.sendRedirect(req.getContextPath() + "/catalogue");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String login    = req.getParameter("login");
        String password = req.getParameter("password");

        String mdpAttendu = COMPTES.get(login);

        if (mdpAttendu != null && mdpAttendu.equals(password)) {
            // Connexion réussie
            req.getSession().setAttribute("utilisateur", login);
            resp.sendRedirect(req.getContextPath() + "/catalogue");
        } else {
            // Échec
            req.setAttribute("erreur", "Identifiants incorrects. Veuillez réessayer.");
            req.setAttribute("loginSaisi", login);
            req.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
               .forward(req, resp);
        }
    }
}
