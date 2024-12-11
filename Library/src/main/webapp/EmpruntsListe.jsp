<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.livres.models.Livre" %>
<%@ page import="com.livres.models.Emprunt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion de la Bibliothèque</title>
     <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }
        
		button.btn.btn-primary {		
		    margin-top: 27px;
		}
		 nav.navbar.navbar-expand-lg.navbar-dark {
		    background-color: #3583a1;
		    margin-bottom: 57px;
		    padding: 17px 8px 19px 30px;
		}
a.btn-liste {
    font-size: 18px;
    text-decoration: none;
    color: #ffffff;
    font-family: "Montserrat", sans-serif;
    margin-left: 46px;
    /* font-weight: 700; */
}
    </style>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
         <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
      <script>
        $(document).ready(function(){
            // jQuery filter script for searching the table
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#empruntsTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>
    
</head>
<body>
    <!-- Navigation Bar -->
     
  <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Ma Bibliothèque</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="<%= request.getContextPath() %>/list?action=listLivres" class="btn-liste"><i class="fa fa-book" aria-hidden="true"></i> Listes des Livres</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%= request.getContextPath() %>/EmpruntsListe?action=listeEmprunts" class="btn-liste"><i class="fa fa-file-text-o" aria-hidden="true"></i>
                        Listes des emprunts</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
  		
    		<div class="row">
			    <div class="col-md-5">
			           <h1 style="font-size: 26px">Historique des Livres Empruntés</h1>
			    </div>
			    <div class="col-md-5">
			      <input class="form-control" id="myInput" type="text" placeholder="Recherche...">
			    </div>
			   
		  </div>
			
		
	</div>
	
		
  
    <!-- Page Content -->
    <div class="container mt-4">
      
        <%
            List<Emprunt> emprunts = (List<Emprunt>) request.getAttribute("emprunts");
        	List<Livre> livres = (List<Livre>) request.getAttribute("livres");
        	
        	
            if (emprunts == null || emprunts.isEmpty()) {
            	
        %>
        <%-- <% System.out.println("emprunt : " + emprunts); %> --%>
            <p class="text-center text-muted">Aucun livre trouvé.</p>
        <%
            } 
            
            
            else {
        %>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                   
                    <th>titre</th>
                    <th>Nom d'emprunteur</th>
                    <th>date d'emprunt</th>
                    <th>Date de retour</th>
                   
                </tr>
            </thead>
            <tbody id="empruntsTable">
                <%
                    for (Emprunt emprunt : emprunts)   {
                    	
                %>
                
                <tr>
                    
                    <td><%= emprunt.getLivre().getTitre() %></td>
                    <td><%= emprunt.getNomEmprunteur() %></td>
                    <td><%= emprunt.getDateEmprunt() %></td>
                    <td><%= emprunt.getDateRetour() %></td>
                   
                </tr>
                <%
                    }
                    	
                %>
                
            </tbody>
        </table>
        <%
            }
        %>
    </div>


   
</body>
</html>