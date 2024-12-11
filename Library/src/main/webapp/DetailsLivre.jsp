<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.livres.models.Livre" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Livre</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            font-size: 20px;
        }
        .details {
            padding: 20px;
        }
        .details p {
            margin: 10px 0;
        }
        .details p span {
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
            border: 1px solid #007bff;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #007bff;
            color: white;
        }
    </style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            Détails du Livre
        </div>

        <!-- Book Details -->
        <div class="details">
            <%
                Livre livre = (Livre) request.getAttribute("livre");
                if (livre == null) {
            %>
                <p style="text-align: center; color: red;">Aucun détail disponible pour ce livre.</p>
            <%
                } else {
            %>
                <p><span>ID :</span> <%= livre.getId() %></p>
                <p><span>Titre :</span> <%= livre.getTitre() %></p>
                <p><span>Auteur :</span> <%= livre.getAuteur() %></p>
                <p><span>Catégorie :</span> <%= livre.getCategorie() %></p>
                <p><span>Disponible :</span> <%= livre.isDisponible() ? "Oui" : "Non" %></p>
            <%
                }
            %>
        </div>

        <!-- Back Link -->
        <div style="text-align: center;">
            <a href="livres" class="back-link">Retour à la Liste</a>
        </div>
    </div>
</body>
</html>
