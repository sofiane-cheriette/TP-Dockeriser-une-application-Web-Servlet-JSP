package fr.boutique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/panier")
public class PanierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, LignePanier> panier = getPanier(req);
        double total = panier.values().stream()
                             .mapToDouble(LignePanier::getSousTotal)
                             .sum();

        req.setAttribute("panier", panier);
        req.setAttribute("total", total);
        req.getRequestDispatcher("/WEB-INF/jsp/panier.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action    = req.getParameter("action");
        String reference = req.getParameter("reference");

        Map<String, LignePanier> panier = getPanier(req);

        if ("ajouter".equals(action) && reference != null) {
            Article article = CatalogueServlet.CATALOGUE.stream()
                .filter(a -> a.getReference().equals(reference))
                .findFirst().orElse(null);

            if (article != null) {
                if (panier.containsKey(reference)) {
                    LignePanier ligne = panier.get(reference);
                    ligne.setQuantite(ligne.getQuantite() + 1);
                } else {
                    panier.put(reference, new LignePanier(article, 1));
                }
            }
        } else if ("supprimer".equals(action) && reference != null) {
            panier.remove(reference);
        } else if ("vider".equals(action)) {
            panier.clear();
        }

        resp.sendRedirect(req.getContextPath() + "/panier");
    }

    @SuppressWarnings("unchecked")
    private Map<String, LignePanier> getPanier(HttpServletRequest req) {
        HttpSession session = req.getSession();
        Map<String, LignePanier> panier =
            (Map<String, LignePanier>) session.getAttribute("panier");
        if (panier == null) {
            panier = new LinkedHashMap<>();
            session.setAttribute("panier", panier);
        }
        return panier;
    }
}
