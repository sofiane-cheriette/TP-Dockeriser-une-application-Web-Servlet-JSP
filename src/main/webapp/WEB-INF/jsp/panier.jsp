<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Panier — Boutique</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/catalogue">🛒 Boutique ESIEE</a>
  <nav>
    <a href="${pageContext.request.contextPath}/catalogue" class="nav-link">Catalogue</a>
    <a href="${pageContext.request.contextPath}/panier"    class="nav-link active">🧺 Panier</a>
    <c:if test="${not empty sessionScope.utilisateur}">
      <span class="nav-user">👤 ${sessionScope.utilisateur}</span>
      <a href="${pageContext.request.contextPath}/logout" class="nav-link">Déconnexion</a>
    </c:if>
  </nav>
</header>

<main class="container">
  <h1>Mon panier</h1>

  <c:choose>
    <c:when test="${empty panier}">
      <div class="alert alert-info" id="panier-vide">
        Votre panier est vide. <a href="${pageContext.request.contextPath}/catalogue">Voir le catalogue</a>
      </div>
    </c:when>
    <c:otherwise>
      <table id="table-panier" class="table">
        <thead>
          <tr>
            <th>Référence</th>
            <th>Article</th>
            <th>Prix unit.</th>
            <th>Quantité</th>
            <th>Sous-total</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="entry" items="${panier}">
            <tr data-reference="${entry.key}">
              <td class="ref">${entry.value.article.reference}</td>
              <td class="nom">${entry.value.article.nom}</td>
              <td class="prix-unit">
                <fmt:formatNumber value="${entry.value.article.prix}"
                  type="number" minFractionDigits="2" maxFractionDigits="2" /> €
              </td>
              <td class="quantite">${entry.value.quantite}</td>
              <td class="sous-total">
                <fmt:formatNumber value="${entry.value.sousTotal}"
                  type="number" minFractionDigits="2" maxFractionDigits="2" /> €
              </td>
              <td>
                <form method="post" action="${pageContext.request.contextPath}/panier" style="display:inline">
                  <input type="hidden" name="action"    value="supprimer">
                  <input type="hidden" name="reference" value="${entry.key}">
                  <button type="submit"
                          class="btn btn-danger btn-small"
                          id="supprimer-${entry.key}">
                    Supprimer
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <div class="panier-footer">
        <span class="total-label">Total :</span>
        <span id="total-panier" class="total-amount">
          <fmt:formatNumber value="${total}" type="number"
            minFractionDigits="2" maxFractionDigits="2" /> €
        </span>

        <form method="post" action="${pageContext.request.contextPath}/panier" style="display:inline">
          <input type="hidden" name="action" value="vider">
          <button type="submit" class="btn btn-danger" id="btn-vider-panier">
            Vider le panier
          </button>
        </form>
      </div>
    </c:otherwise>
  </c:choose>
</main>
</body>
</html>
