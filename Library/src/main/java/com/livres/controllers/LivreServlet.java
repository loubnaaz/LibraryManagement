package com.livres.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;

import com.livres.dao.EmpruntDAO;
import com.livres.dao.LivreDAO;
import com.livres.models.Emprunt;
import com.livres.models.Livre;

import java.util.Date;
public class LivreServlet extends HttpServlet {

    private LivreDAO livreDAO = new LivreDAO();
    private EmpruntDAO empruntDAO = new EmpruntDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String path = request.getServletPath();
        String action = request.getParameter("action");
        
        if (action == null) {
          /*  if ("/ajout".equals(path)) {
                action = "ajout";
            } 
            
            else if ("/modif".equals(path)){
            	action = "modif";
            }*/
            
           if ("/supprimerLivre".equals(path)){
            	action = "supprimer";
            }
           if ("/retournerLivre".equals(path)) {
               action = "returnLivre";
           }
            else if ("/EmpruntsListe".equals(path)) {
                action = "listeEmprunts";
            }
            else {
                action = "list";
            }
        }

        try {
            switch (action) {
               /* case "ajout":
                    showAddForm(request, response);
                   
                    break;
                case "modif":
                    showEditForm(request, response);
                    break;*/
                case "supprimer":
                    deleteLivre(request, response);
                    break;
               
                 case "returnLivre":
                     returnLivre(request, response);
                     System.out.println("retourner le livre action");
                     break;
               case "listeEmprunts":
                    listEmprunts(request, response);
                    break;
                default:
                    listLivres(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 System.out.println("doPost appelé !");
    	String path = request.getServletPath();
        String action = request.getParameter("action");
        System.out.println("Action : " + action);
        try {
            switch (action) {
                case "add":
                    addLivre(request, response);
                    break;
                case "edit":
                	 System.out.println("Modification d'un livre.");
                    updateLivre(request, response);
                    break;
                case "ajouterEmprunt":
                    addEmprunt(request, response);
                    break;
                default:
                	System.out.println("Action inconnue : " + action);
                    listLivres(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listLivres(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livre> livres = livreDAO.listLivres();
        request.setAttribute("livres", livres);
        RequestDispatcher dispatcher = request.getRequestDispatcher("LivresListe.jsp");
        dispatcher.forward(request, response);
    }
    private void listEmprunts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Emprunt> emprunts = empruntDAO.listEmprunts();
        List<Livre> livres = livreDAO.listLivres();
        
        request.setAttribute("livres", livres);
        request.setAttribute("emprunts", emprunts);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("EmpruntsListe.jsp");
        dispatcher.forward(request, response);
    }

 
    
  /*  private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	  System.out.println(" show new form");
        RequestDispatcher dispatcher = request.getRequestDispatcher("ajouterlivre.jsp");
        dispatcher.forward(request, response);
    }*/

  /*  private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Integer id = Integer.parseInt(request.getParameter("id"));
        Livre existingLivre = livreDAO.getLivreById(id);
        request.setAttribute("livre", existingLivre);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ModifierLivre.jsp");
        dispatcher.forward(request, response);
    }*/

    private void addLivre(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String categorie = request.getParameter("categorie");
        boolean disponible = Boolean.parseBoolean(request.getParameter("disponible"));

        Livre newLivre = new Livre(titre, auteur, categorie, disponible);
        livreDAO.ajouterLivre(newLivre);
        response.sendRedirect("livres");
    }

    private void updateLivre(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	System.out.println("entering updateLivre");
    	Integer id = Integer.parseInt(request.getParameter("id"));
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String categorie = request.getParameter("categorie");
        //boolean disponible = Boolean.parseBoolean(request.getParameter("disponible"));
        boolean disponible = request.getParameter("disponible") != null;
        
        Livre updatedLivre = new Livre(id, titre, auteur, categorie, disponible);
        livreDAO.updateLivre(updatedLivre);
        response.sendRedirect("livres");
    }

    private void deleteLivre(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	//System.out.println("entering deleteLivre");
    	Integer id = Integer.parseInt(request.getParameter("id"));
        livreDAO.deleteLivre(id);
        response.sendRedirect("livres");
        
    }
 
    

  /*    // New Method: List Emprunts for a Livre
    private void listEmprunts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer livreId = Integer.parseInt(request.getParameter("livreId"));
        Livre livre = livreDAO.getLivreById(livreId);
        if (livre != null) {
            request.setAttribute("livre", livre);
            request.setAttribute("emprunts", livre.getEmprunts());
            RequestDispatcher dispatcher = request.getRequestDispatcher("ListeEmprunts.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("livres");
        }
    }

  // New Method: Add Emprunt*/
    private void addEmprunt(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer livreId = Integer.parseInt(request.getParameter("livreId"));
        String nomEmprunteur = request.getParameter("nomEmprunteur");
        String dateEmprunt = request.getParameter("dateEmprunt");
        String dateRetour = request.getParameter("dateRetour");

        Emprunt emprunt = new Emprunt();
        emprunt.setNomEmprunteur(nomEmprunteur);
        emprunt.setDateEmprunt(java.sql.Date.valueOf(dateEmprunt));
        emprunt.setDateRetour(java.sql.Date.valueOf(dateRetour));

        livreDAO.ajouterEmprunt(livreId, emprunt);
        
        System.out.println(nomEmprunteur);
        System.out.println(dateEmprunt);
        System.out.println(dateRetour);
        //response.sendRedirect("livres?action=listeEmprunts&livreId=" + livreId);
        response.sendRedirect("livres");
    }
  /*  private void returnLivre(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	System.out.println("entering retourner livre");
        Integer livreId = Integer.parseInt(request.getParameter("livreId"));

        // Retrieve the livre (book) from the database using livreId
        Livre livre = livreDAO.getLivreById(livreId);
    	System.out.println("retourner livre avant set dispo");
        if (livre != null && livre.getEmprunt() != null) {
            // Book is borrowed, let's set it back as available
            livre.setDisponible(true);
            livreDAO.updateLivre(livre);
        	System.out.println("livre updated");
        	System.out.println(livre);
           /* // Optionally, set the return date in Emprunt, or delete the Emprunt record
            Emprunt emprunt = livre.getEmprunt();
            emprunt.setDateRetour(new java.sql.Date(System.currentTimeMillis()));
            livreDAO.updateEmprunt(emprunt);  // You may have a method to update the emprunt status
           
            //response.sendRedirect("livres?action=listeEmprunts&livreId=" + livreId);
        	 response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false}");
        }
        
    }*/
    

    
    
    private void returnLivre(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
        	 String queryString = request.getQueryString();
             System.out.println("Query String: " + queryString);
             
        	 String livreIdParam = request.getParameter("id");
        	String empruntIdParam = request.getParameter("empruntid");
        	 System.out.println("Received livreIdParam: " + livreIdParam);
        	 
        	 
          /*   if (livreIdParam == null || livreIdParam.isEmpty()) {
                 throw new IllegalArgumentException("from servlet Livre ID is missing or invalid.");
                 
             }*/
        	
        	
            Integer livreId = Integer.parseInt(request.getParameter("id"));
          //  Integer empruntid = Integer.parseInt(request.getParameter("empruntid"));
            System.out.println("Parsed livreId: " + livreId);  // Should print "23"
            //System.out.println("Parsed emprunt id: " + empruntid);

            // Retrieve the book and update its status
            Livre livre = livreDAO.getLivreById(livreId);
            
           // Emprunt emprunt = empruntDAO.getEmpruntById(empruntid);
            
            System.out.println("Livre ID 1: " + livreId);
            
            if (livre != null && livre.getEmprunt() != null) {
                livre.setDisponible(true);
                
                System.out.println("livre updated from servlet" );
                livreDAO.updateLivre(livre);
                //empruntDAO.updateEmprunt(emprunt);
                System.out.println("livre updated from servlet" );
                
                request.setAttribute("successMessage", "Livre retourné avec succès !");
            } else {
                // Set error message in the request
                request.setAttribute("errorMessage", "Erreur lors du retour du livre.");
            }  response.sendRedirect("livres");
           // request.getRequestDispatcher("LivresListe.jsp").forward(request, response);
        
        } catch (Exception e) {
            // Handle any exceptions and send an error response
        	System.err.println("Invalid Livre ID format.");
            response.getWriter().write("{\"success\": false, \"message\": \"Erreur lors du retour du livre\"}");
            e.printStackTrace();
        }
    }

    
}
