package com.livres.dao;


import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


import com.livres.models.Emprunt;
import com.livres.models.Livre;



public class EmpruntDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("LibraryPU");

  /*  // Add a new emprunt
    public void ajoutEmprunt(Emprunt emprunt) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(emprunt);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }*/
    // Update an existing book
    public void updateEmprunt(Emprunt emprunt) {
    	System.out.println("emprunt: ");
    	System.out.println(emprunt);
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(emprunt);
            em.getTransaction().commit();
            System.out.println("DAO finale :: ");
        } finally {
            em.close();
        }
    }
    
    public List<Emprunt> listEmprunts() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT e FROM Emprunt e", Emprunt.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Find a book by ID
    public Emprunt getEmpruntById(Integer id) {
    	
        EntityManager em = emf.createEntityManager();
        try {
        	System.out.println("Fetching book with ID: " + id);
            return em.find(Emprunt.class, id);
            
        } finally {
        	  em.close();
        }
    }


    // Close EntityManagerFactory when done
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}