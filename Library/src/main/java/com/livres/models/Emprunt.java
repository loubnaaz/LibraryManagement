package com.livres.models;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "emprunt")
public class Emprunt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nomEmprunteur;

    @Temporal(TemporalType.DATE)
    private Date dateEmprunt;

    @Temporal(TemporalType.DATE)
    private Date dateRetour;

    @OneToOne
    @JoinColumn(name = "livre_id")
    private Livre livre;
    
    
    public Emprunt() {
		super();
	}

    
	public Emprunt(Long id, String nomEmprunteur, Date dateEmprunt, Date dateRetour, Livre livre) {
		super();
		this.id = id;
		this.nomEmprunteur = nomEmprunteur;
		this.dateEmprunt = dateEmprunt;
		this.dateRetour = dateRetour;
		this.livre = livre;
	}
	
	
	
	public Emprunt(String nomEmprunteur, Date dateEmprunt, Date dateRetour, Livre livre) {
		super();
		this.nomEmprunteur = nomEmprunteur;
		this.dateEmprunt = dateEmprunt;
		this.dateRetour = dateRetour;
		this.livre = livre;
	}



	// Getters et setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNomEmprunteur() {
        return nomEmprunteur;
    }

    public void setNomEmprunteur(String nomEmprunteur) {
        this.nomEmprunteur = nomEmprunteur;
    }

    public Date getDateEmprunt() {
        return dateEmprunt;
    }

    public void setDateEmprunt(Date dateEmprunt) {
        this.dateEmprunt = dateEmprunt;
    }

    public Date getDateRetour() {
        return dateRetour;
    }

    public void setDateRetour(Date dateRetour) {
        this.dateRetour = dateRetour;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

/*
	@Override
	public String toString() {
		return "Emprunt [id=" + id + ", nomEmprunteur=" + nomEmprunteur + ", dateEmprunt=" + dateEmprunt
				+ ", dateRetour=" + dateRetour + ", livre=" + livre + "]";
	}
    */
    
}
