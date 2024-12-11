package com.livres.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.livres.models.Emprunt;
import com.livres.models.Livre;


public class LivreDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("LibraryPU");

    // Add a new book
    public void ajouterLivre(Livre livre) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(livre);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // Retrieve all books
    public List<Livre> listLivres() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT l FROM Livre l", Livre.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Find a book by ID
    public Livre getLivreById(Integer id) {
    	System.out.println("dao get livre by id");
       	System.out.println(id);
        EntityManager em = emf.createEntityManager();
        try {
        	System.out.println("Fetching book with ID: " + id);
            return em.find(Livre.class, id);
            
        } finally {
        	  em.close();
        }
    }

    // Update an existing book
    public void updateLivre(Livre livre) {
    	System.out.println("update livre check ");
    	
    	//System.out.println(livre);
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(livre);
            //System.out.println("Updating book: " + livre);
            System.out.println("updating book");
            em.getTransaction().commit();
            System.out.println("update livre check end ");
        } finally {
            em.close();
            System.out.println("closing");
        }
    }
    
    // Delete a book by ID
    public void deleteLivre(Integer id) {
    	System.out.println(" deleteLivre dao");
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Livre livre = em.find(Livre.class, id);
            if (livre != null) {
                em.remove(livre);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    
    public void ajouterEmprunt(Integer livreId, Emprunt emprunt) {
        EntityManager em = emf.createEntityManager();
        try {
            Livre livre = em.find(Livre.class, livreId);
            if (livre != null) {
            	System.out.println("Livre: " + livre.getTitre());
            	System.out.println("Emprunt: " + livre.getEmprunt());
            	if (livre.getEmprunt() != null) {
            	    System.out.println("Nom Emprunteur: " + livre.getEmprunt().getNomEmprunteur());
            	}
            	
                if (livre.isDisponible()) { // Check if the Livre is available
                    em.getTransaction().begin();

                    // Set the relationship
                    livre.setEmprunt(emprunt);
                    emprunt.setLivre(livre);

                    // Mark the Livre as unavailable
                    livre.setDisponible(false);

                    // Persist the Emprunt
                    em.persist(emprunt);

                    em.getTransaction().commit();
                } else {
                    System.out.println("Livre is already borrowed and unavailable.");
                }
            } else {
                System.out.println("Livre not found.");
            }
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Emprunt findEmpruntByLivreId(Integer livreId) {
    	EntityManager em = emf.createEntityManager();
        String jpql = "SELECT e FROM Emprunt e WHERE e.livre.id = :livreId";
        return em.createQuery(jpql, Emprunt.class)
                            .setParameter("livreId", livreId)
                            .getSingleResult();
    }

    
    
    
    
   /* // Ajouter un emprunt
    public void ajouterEmprunt(Integer livreId, Emprunt emprunt) {
    	 EntityManager em = emf.createEntityManager();
        Livre livre = em.find(Livre.class, livreId);
        if (livre != null) {
            em.getTransaction().begin();
            livre.addEmprunt(emprunt);
            em.persist(emprunt);
            em.getTransaction().commit();
        }
    }
    
    
 // Supprimer un emprunt
    public void supprimerEmprunt(Long empruntId) {
    	 EntityManager em = emf.createEntityManager();
        Emprunt emprunt = em.find(Emprunt.class, empruntId);
        if (emprunt != null) {
            em.getTransaction().begin();
            emprunt.getLivre().removeEmprunt(emprunt);
            em.remove(emprunt);
            em.getTransaction().commit();
        }
    }
    
    // Récupérer les emprunts d'un livre
    public List<Emprunt> getEmprunts(Integer livreId) {
    	 EntityManager em = emf.createEntityManager();
        Livre livre = em.find(Livre.class, livreId);
        return livre != null ? livre.getEmprunts() : Collections.emptyList();
    }
    */

    // Close EntityManagerFactory when done
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}