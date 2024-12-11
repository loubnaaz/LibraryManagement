<%@page import="org.hibernate.internal.build.AllowSysOut"%>
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
       
		
		div:where(.swal2-container) h2:where(.swal2-title) {
    		font-size: 19px !important;
		}
		button.swal2-confirm.swal2-styled.swal2-default-outline {
		    padding: 6px !important;
		    font-size: 14px !important;
		}
		button.swal2-cancel.swal2-styled.swal2-default-outline {
		    /* background-color: rgb(207 231 255); */
		    font-size: 14px !important;
		    padding: 6px !important;
		}
			span.logo {
		    font-size: 20px;
		    font-family: monospace;
		    font-weight: 500;
		    color: #00004a;
		}
	
button.btn-ajout {
    background-color: #17627e;
    color: white;
    border-radius: 6px;
    border: 0px;
    padding: 8px 20px 8px 20px;
    height: 37px;
    font-family:"Montserrat", sans-serif;
}
.container-hero {
    padding-left: 63px;
    padding-right: 58px;
    margin-bottom: 53px;
}
		/*div:where(.swal2-container) div:where(.swal2-popup) {
		    width: 29em !important;
		}
		div:where(.swal2-icon) {
		    width: 3em !important;
		    height: 3em !important;
		    margin: 1.5em auto .6em !important;
		}
		div:where(.swal2-icon) .swal2-icon-content {
		    font-size: 2.75em !important;
	}
		/*div:where(.swal2-icon).swal2-success [class^=swal2-success-line][class$=tip] {
		   left: -0.1875em !important;
		}
		
		div:where(.swal2-container) button:where(.swal2-styled):where(.swal2-confirm) {
		    background-color: #0d6efd !important;
		    color: #fff !important;
		    font-size: 14px !important;
		}
		  }
        */
       
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
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      
      <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<script>
        $(document).ready(function(){
            // jQuery filter script for searching the table
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#livresTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>
  
</head>
<body>

 
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
	   
		<div class="container-hero">
			<div class="row">
			    <div class="col">
			          <h1 style="font-size: 31px ; font-family: "Montserrat", sans-serif;">Liste des Livres</h1>
			    </div>
			    <div class="col-md-auto">
			      <input class="form-control" id="myInput" type="text" placeholder="Recherche...">
			    </div>
			    <div class="col col-lg-2">
			     <button class="btn-ajout" data-bs-toggle="modal" data-bs-target="#addModal">Ajouter un Livre</button>
			    </div>
		  </div>
    </div>
  
    <!-- Page Content -->
    <div class="container mt-4">

        <%
            List<Livre> livres = (List<Livre>) request.getAttribute("livres");
            if (livres == null || livres.isEmpty()) {
        %>
            <p class="text-center text-muted">Aucun livre trouvé.</p>
        <%
            } else {
        %>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    
                    <th>Titre</th>
                    <th>Auteur</th>
                    <th>Catégorie</th>
                    <th>Disponible</th>
                     <th>Emprunter</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="livresTable">
                <%
                    for (Livre livre : livres) {
                %>
                <tr>
                   
                    <td><%= livre.getTitre() %></td>
                    <td><%= livre.getAuteur() %></td>
                    <td><%= livre.getCategorie() %></td>
                    <td><%= livre.isDisponible() ? "Oui" : "Non"  %></td>
                    
					<td> 
						
						 <%  
						
						 if (livre.isDisponible()) { %>
						    <button class="btn btn-primary btn-sm"  style= "background-color:#3583a1;" data-bs-toggle="modal" data-bs-target="#empruntModal" 
						        onclick="prepareEmpruntForm(<%= livre.getId() %>, '<%= livre.getTitre() %>')">
						        Emprunter
						        
						    </button>
						<% } else { %>
						    
						      <% 
								    // Check if the emprunt is null
								    
								    com.livres.models.Emprunt emprunt = livre.getEmprunt();
								    String nomEmprunteur = (emprunt != null) ? emprunt.getNomEmprunteur() : "N/A";
								    String dateEmprunt = (emprunt != null) ? emprunt.getDateEmprunt().toString() : "N/A";
								    String dateRetour = (emprunt != null) ? emprunt.getDateRetour().toString() : "N/A";
								%>
			
								<button class="btn btn-primary btn-sm"  style= "background-color:#3583a1" data-bs-toggle="modal" data-bs-target="#empruntModalDetails"  
								        onclick="EmpruntDetails('<%= livre.getTitre() %>', '<%= nomEmprunteur  %>','<%= dateEmprunt %>','<%= dateRetour %>')">
								    Details d'emprunt
								</button>
								
							<%-- 	<% if (livre.getId() != null && livre.getEmprunt() != null) { %>
									    <button class="btn btn-primary btn-sm" onclick="returnLivre('<%= livre.getId() %>', '<%= livre.getTitre() %>')">
									        Retourner le Livre
									    </button>
									    <% System.out.println("Livre ID: " + livre.getId()); %>
									    <% System.out.println("Livre getTitre: " + livre.getTitre()); %>
									    
									<% } %> --%>
									
									<% if (livre.getId() != null && livre.getEmprunt() != null) { %>
								 <a href="<%= request.getContextPath() %>/retournerLivre?action=returnLivre&id=<%= livre.getId() %>" 
			                           class="btn btn-danger btn-sm"
			                           onclick="return showreturnDialog(event, this.href)">
			                            retourner le f livre
			                        </a>
							
									<% } %>
						 <% } %>
					</td>
                    <td>
                        <button class="btn btn-info btn-sm" style= "background-color:#3583a1; border:4px #3583a1" data-bs-toggle="modal" data-bs-target="#viewModal" 
                            onclick="loadBookDetails(<%= livre.getId() %>, '<%= livre.getTitre() %>', 
                            '<%= livre.getAuteur() %>', '<%= livre.getCategorie() %>', <%= livre.isDisponible() %>)">
                           <i class="fa fa-info-circle" aria-hidden="true" style="color: #ffffff;"></i>
                        </button>
                        
                       	 <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
                            onclick="loadEditForm(<%= livre.getId() %>, '<%= livre.getTitre() %>', 
                            '<%= livre.getAuteur() %>', '<%= livre.getCategorie() %>', <%= livre.isDisponible() %>)">
                         
                         <i class="fa fa-pencil" aria-hidden="true" style="color: #ffffff;"></i>
                        </button>	
                       
						<a href="<%= request.getContextPath() %>/supprimerLivre?action=supprimer&id=<%= livre.getId() %>" 
						   class="btn btn-danger btn-sm" 
						   onclick="return showDeleteDialog(event, this.href)">
						   <i class="fa fa-trash-o" aria-hidden="true" style="color: #ffffff;"></i>


						</a>
					
						
                        
             
                        
                    </td>
                    
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

    <!-- Add Modal -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="?action=add" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Ajouter un Livre</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="titre" class="form-label">Titre</label>
                            <input type="text" class="form-control" name="titre" required>
                        </div>
                        <div class="mb-3">
                            <label for="auteur" class="form-label">Auteur</label>
                            <input type="text" class="form-control" name="auteur" required>
                        </div>
                        <div class="mb-3">
                            <label for="categorie" class="form-label">Catégorie</label>
                            <input type="text" class="form-control" name="categorie" required>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="disponible" value="true">
                            <label class="form-check-label">Disponible</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Ajouter</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- View Modal -->
    <div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewModalLabel">Détails du Livre</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p style ="display:none"><strong>ID:</strong> <span id="viewId"></span></p>
                    <p><strong>Titre:</strong> <span id="viewTitre"></span></p>
                    <p><strong>Auteur:</strong> <span id="viewAuteur"></span></p>
                    <p><strong>Catégorie:</strong> <span id="viewCategorie"></span></p>
                    <p><strong>Disponible:</strong> <span id="viewDisponible"></span></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="?action=edit" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Modifier un Livre</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editId">
                        <div class="mb-3">
                            <label for="editTitre" class="form-label">Titre</label>
                            <input type="text" class="form-control" name="titre" id="editTitre" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAuteur" class="form-label">Auteur</label>
                            <input type="text" class="form-control" name="auteur" id="editAuteur" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCategorie" class="form-label">Catégorie</label>
                            <input type="text" class="form-control" name="categorie" id="editCategorie" required>
                        </div>
                        <div class="form-check">
                           <input type="checkbox" class="form-check-input" name="disponible" id="editDisponible">
                              
                            <label class="form-check-label">Disponible</label>
                            
                          
                            
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"  style= "background-color:#3583a1;" >Enregistrer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
<!-- Emprunt Modal -->
<div class="modal fade" id="empruntModal" tabindex="-1" aria-labelledby="empruntModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="?action=ajouterEmprunt" method="post">
                <input type="hidden" name="livreId" id="empruntLivreId">
                <div class="modal-header">
                    <h5 class="modal-title" id="empruntModalLabel">Emprunter un Livre</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="empruntLivreDetails"></p>
                    <div class="mb-3">
                        <label for="nomEmprunteur" class="form-label">Nom de l'emprunteur</label>
                        <input type="text" class="form-control" name="nomEmprunteur" required>
                        
                         <label for="dateEmprunt" class="form-label">Date d'emprunt</label>
                        <input type="date" class="form-control" name="dateEmprunt" required>
                        
                         <label for="dateRetour" class="form-label">Date de retour</label>
                        <input type="date" class="form-control" name="dateRetour" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary"  style= "background-color:#3583a1;" >Confirmer l'Emprunt</button>
                </div>
            </form>
        </div>
    </div>
</div>

  <!-- View Modal details emprunt-->
  <div class="modal fade" id="empruntModalDetails" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewModalLabel">Détails de l'emprunt</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Titre:</strong> <span id="empruntLivretitre"></span></p>
                <p><strong>Nom d'emprunteur:</strong> <span id="viewnomEmprunteur"></span></p>
                <p><strong>Date d'emprunt:</strong> <span id="viewdateEmprunt"></span></p>
                <p><strong>Date de retour:</strong> <span id="viewdateRetour"></span></p>
            </div>
        
						   
        </div>
    </div>
</div>
  <!-- suppression livre-->
<div class="modal fade" id="supressionLivre" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="deleteForm" method="get">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewModalLabel">Voulez-vous vraiment supprimer ce livre ?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>

function showreturnDialog(event, url) {
    // Prevent the default action of the link
    console.log("eul:",url);
    event.preventDefault();

    // Show SweetAlert dialog
    Swal.fire({
        title: "Retourner ce livre ?",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3583a1;",
        confirmButtonText: "Retourner",
        cancelButtonText: "Annuler"
    }).then((result) => {
        if (result.isConfirmed) {
            // Redirect to the URL if the user confirms
            Swal.fire("livre bien retourné!", "", "success");
            setTimeout(() => {
                window.location.href = url;
            }, 2000);
        }
    });

    return false; // Prevent the default link action
}

    function showDeleteDialog(event, url) {
        // Prevent the default action of the link
        event.preventDefault();

        // Show SweetAlert dialog
        Swal.fire({
            title: "Voulez-vous vraiment supprimer ce livre ?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Oui, supprimer",
            cancelButtonText: "Annuler"
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirect to the URL if the user confirms
                Swal.fire("livre supprmié!", "", "success");
                setTimeout(() => {
                    window.location.href = url;
                }, 2000);
            }
        });

        return false; // Prevent the default link action
    }
</script>

<script>
function prepareEmpruntForm(livreId, livreTitre) {
    document.getElementById('empruntLivreId').value = livreId;
    document.getElementById('empruntLivreDetails').innerText = "Titre du livre : " + livreTitre;
}

    function EmpruntDetails(livreTitre, nomEmprunteur, dateEmprunt, dateRetour) {
   	 console.log("Titre:", livreTitre);
       document.getElementById('empruntLivretitre').innerText = livreTitre;
       document.getElementById("viewnomEmprunteur").innerText =  nomEmprunteur;
       document.getElementById("viewdateEmprunt").innerText =  dateEmprunt;
       document.getElementById("viewdateRetour").innerText =  dateRetour;
   }

    <%-- function confirmDelete(event, button) {
        //console.log("Livre ID1: ", id);
        // Prevent the default action of the link
        event.preventDefault();
        //console.log("Livre ID2: ", id);
        // Show SweetAlert dialog for confirmation
        Swal.fire({
            title: "Do you want to delete?",
            text: "This action cannot be undone.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, delete it!",
            cancelButtonText: "Cancel"
        }).then((result) => {
        //	console.log("Livre ID3: ", id);
            if (result.isConfirmed) {
            	
            	  const url = `<%= request.getContextPath() %>/supprimerLivre?action=supprimer&id=${id}`;
            	    console.log("Calling URL:", url);
            	    
            	    const id = button.getAttribute("data-id"); // Get the ID from the data attribute

            	    const url = `<%= request.getContextPath() %>/supprimerLivre?action=supprimer&id=${id}`;
            	    console.log("Constructed URL:", url);
            	     // Log the full URL for debugging

            	    fetch(url, {
            	        method: "GET"
            	    })
                    	 
               
                .then(response => {
                	console.log("Livre ID5: ", id);
                    
                    if (response.ok) {
                        // Show success message
                        Swal.fire("Deleted!", "The book has been deleted.", "success")
                            .then(() => {
                                // Reload the page or redirect after success
                                window.location.reload();
                            });
                    } else {
                        // Handle error response
                        console.log("Livre ID6: ", id);
                        Swal.fire("Error!", "Failed to delete the book.", "error");
                    }
                })
                .catch(() => {
                    // Handle network or unexpected errors
                    Swal.fire("Error!", "Something went wrong.", "error");
                });
            }
        });

        // Return false to ensure the default action does not proceed
        return false;
    }

 --%>

    /*  function returnLivre(livreId) {
    // Make a request to the backend to mark the book as returned
   fetch(`/retournerLivre?action=returnLivre&livreId=${livreId}`, {

        method: 'GET',
    })
    .then(response => response.json())
    .then(data => {
        // Optionally update the UI here to reflect the returned book (e.g., update availability)
        alert("Le livre a été retourné avec succès!");
        // You may want to reload the page or update the book's status on the page
        location.reload();
    })
    .catch(error => console.error("Error returning book:", error));
} */

/*function returnLivre(livreId) {
   	 if (!livreId) {
   	        console.error("Livre ID is missing!");
   	        console.log("Livre ID is missing!");
   	        return;
   	    }else{
   	    	console.log("", livreId);}
       //const url = `${contextPath}retournerLivre/?action=returnLivre&livreId=${livreId}`;
       
       const contextPath = 'http://localhost:8080/Library'; // Replace this with your app's base context path
       const url = `${contextPath}?action=returnLivre&livreId=${livreId}`; 
       
       console.log("Constructed URL:", url);
       fetch(url, {
           method: 'GET',
           
       })
       .then(response => response.json())
       .then(data => {
           if (data.success) {
               alert(data.message);
               location.reload(); // Refresh to update UI
           } else {
               alert("Erreur: " + data.message);
           }
       })
       .catch(error => console.error("Error returning book cosnosle:", error));
   }
*//*
 function returnLivre(livreId) {
	    const contextPath = 'http://localhost:8080/Library'; // Base path for your app
	   	console.log("id du livre", livreId);
	   	
	    const url = `${contextPath}/retournerLivre?action=returnLivre&livreId=${livreId}`; // Construct the URL

	    console.log("Constructed URL:", url);
	    fetch(url, { method: 'GET' })
	        .then(response => response.json())
	        .then(data => {
	            alert(data.message); // Alert success or error message
	            if (data.success) {
	                location.reload(); // Refresh the page if successful
	            }
	        });
	}
		 */

</script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function loadBookDetails(id, titre, auteur, categorie, disponible) {
            document.getElementById("viewId").innerText = id;
            document.getElementById("viewTitre").innerText = titre;
            document.getElementById("viewAuteur").innerText = auteur;
            document.getElementById("viewCategorie").innerText = categorie;
            document.getElementById("viewDisponible").innerText = disponible ? "Oui" : "Non";
        }

        function loadEditForm(id, titre, auteur, categorie, disponible) {
            document.getElementById("editId").value = id;
            document.getElementById("editTitre").value = titre;
            document.getElementById("editAuteur").value = auteur;
            document.getElementById("editCategorie").value = categorie;
            document.getElementById("editDisponible").checked = disponible;
           
        }
    </script>
   
</body>
</html>