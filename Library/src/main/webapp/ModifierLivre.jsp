<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.livres.models.Livre" %>
<%@ page import="javax.persistence.EntityManager" %>
<%@ page import="javax.persistence.EntityManagerFactory" %>
<%@ page import="javax.persistence.Persistence" %>
<%@ page import="javax.persistence.TypedQuery" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un Livre</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        h1 {
            text-align: center;
            margin-top: 30px;
        }
        form {
            width: 40%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            background-color: #FFC107;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #E0A800;
        }
    </style>
</head>
<body>
    <h1>Modifier un Livre</h1>
    <%
        // Récupérer l'ID du livre à modifier
        String livreIdParam = request.getParameter("id");
        Livre livre = null;

        if (livreIdParam != null) {
            Integer livreId = Integer.parseInt(livreIdParam);

            // Configurer l'EntityManager pour rechercher le livre
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("LibraryPU");
            EntityManager em = emf.createEntityManager();

            try {
                livre = em.find(Livre.class, livreId);
            } finally {
                em.close();
                emf.close();
            }
        }

        if (livre == null) {
    %>
        <p style="text-align: center; color: #777;">Livre non trouvé.</p>
    <%
        } else {
    %>
  <form action="<%= request.getContextPath() %>/modif" method="POST">
        <input type="text" name="action" value="edit"/>
        <input type="text" name="id" value="<%= livre.getId() %>"/>

        <label for="titre">Titre:</label>
        <input type="text" id="titre" name="titre" value="<%= livre.getTitre() %>" required/><br><br>

        <label for="auteur">Auteur:</label>
        <input type="text" id="auteur" name="auteur" value="<%= livre.getAuteur() %>" required/><br><br>

        <label for="categorie">Catégorie:</label>
        <input type="text" id="categorie" name="categorie" value="<%= livre.getCategorie() %>" required/><br><br>

        <label for="disponible">Disponible:</label>
        <select id="disponible" name="disponible" required>
            <option value="true" <%= livre.isDisponible() ? "selected" : "" %>>Oui</option>
            <option value="false" <%= !livre.isDisponible() ? "selected" : "" %>>Non</option>
        </select><br><br>

        <button type="submit">Modifier</button>
    </form>
    <%
        }
    %>
</body>
</html>
