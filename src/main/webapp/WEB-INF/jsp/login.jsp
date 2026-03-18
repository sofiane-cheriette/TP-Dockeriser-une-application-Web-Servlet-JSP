<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Connexion — Boutique</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="navbar">
  <span class="navbar-brand">🛒 Boutique ESIEE</span>
</header>

<main class="container">
  <div class="login-box">
    <h1>Connexion</h1>

    <c:if test="${not empty erreur}">
      <div class="alert alert-error" id="message-erreur">${erreur}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login" id="form-login">
      <div class="form-group">
        <label for="login">Identifiant</label>
        <input type="text"
               id="login"
               name="login"
               class="form-control"
               value="${loginSaisi}"
               placeholder="Ex : alice"
               required
               autofocus>
      </div>

      <div class="form-group">
        <label for="password">Mot de passe</label>
        <input type="password"
               id="password"
               name="password"
               class="form-control"
               placeholder="Votre mot de passe"
               required>
      </div>

      <button type="submit" class="btn btn-primary btn-full" id="btn-connexion">
        Se connecter
      </button>
    </form>

    <p class="hint">
      Comptes de test :
      <code>alice / alice123</code> &nbsp;·&nbsp;
      <code>bob / bob456</code>
    </p>
  </div>
</main>
</body>
</html>
