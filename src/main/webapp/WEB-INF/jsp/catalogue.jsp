<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Catalogue — Boutique</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/catalogue">🛒 Boutique ESIEE</a>
  <nav>
    <a href="${pageContext.request.contextPath}/catalogue" class="nav-link active">Catalogue</a>
    <a href="${pageContext.request.contextPath}/panier"    class="nav-link">🧺 Panier</a>
    <c:if test="${not empty sessionScope.utilisateur}">
      <span class="nav-user">👤 ${sessionScope.utilisateur}</span>
      <a href="${pageContext.request.contextPath}/logout" class="nav-link">Déconnexion</a>
    </c:if>
  </nav>
</header>

<main class="container">
  <h1>Catalogue des articles</h1>

  <table id="table-catalogue" class="table">
    <thead>
      <tr>
        <th>Référence</th>
        <th>Article</th>
        <th>Catégorie</th>
        <th>Prix</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="a" items="${articles}">
        <tr data-reference="${a.reference}">
          <td class="ref">${a.reference}</td>
          <td class="nom">${a.nom}</td>
          <td class="categorie">${a.categorie}</td>
          <td class="prix"><fmt:formatNumber value="${a.prix}" type="number" minFractionDigits="2" maxFractionDigits="2" /> €</td>
          <td>
            <form method="post" action="${pageContext.request.contextPath}/panier" style="display:inline">
              <input type="hidden" name="action"    value="ajouter">
              <input type="hidden" name="reference" value="${a.reference}">
              <button type="submit"
                      class="btn btn-small"
                      id="ajouter-${a.reference}">
                Ajouter
              </button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</main>
</body>
</html>
