<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Livre</title>
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
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Ajouter un Nouveau Livre</h1>
    <form action="?action=add" method="POST">
        <label for="titre">Titre:</label>
        <input type="text" id="titre" name="titre" required/><br><br>

        <label for="auteur">Auteur:</label>
        <input type="text" id="auteur" name="auteur" required/><br><br>

        <label for="categorie">Catégorie:</label>
        <input type="text" id="categorie" name="categorie" required/><br><br>

        <label for="disponible">Disponible:</label>
        <select id="disponible" name="disponible" required>
            <option value="true">Oui</option>
            <option value="false">Non</option>
        </select><br><br>

        <button type="submit">Ajouter</button>
    </form>
</body>
</html>
