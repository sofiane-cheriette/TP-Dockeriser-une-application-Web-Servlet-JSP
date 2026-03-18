package fr.boutique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/catalogue")
public class CatalogueServlet extends HttpServlet {

    // Catalogue statique (pas de base de données pour ce TP)
    public static final List<Article> CATALOGUE = Arrays.asList(
        new Article("REF-001", "Stylo bille bleu",     1.50,  "Papeterie"),
        new Article("REF-002", "Cahier 100 pages",     3.90,  "Papeterie"),
        new Article("REF-003", "Règle 30 cm",          1.20,  "Papeterie"),
        new Article("REF-004", "Classeur A4",          4.50,  "Papeterie"),
        new Article("REF-005", "Sac à dos 20L",       24.99,  "Maroquinerie"),
        new Article("REF-006", "Trousse zippée",       7.90,  "Maroquinerie"),
        new Article("REF-007", "Agenda 2024",          9.99,  "Papeterie"),
        new Article("REF-008", "Calculatrice simple", 12.50,  "Electronique")
    );

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("articles", CATALOGUE);
        req.getRequestDispatcher("/WEB-INF/jsp/catalogue.jsp")
           .forward(req, resp);
    }
}
