package com.livres.models;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "livres")
public class Livre {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String titre;
	private String auteur;
	private String categorie;
	private boolean disponible = true;
	
	 @OneToOne(mappedBy = "livre", cascade = CascadeType.ALL, orphanRemoval = true)
	    private Emprunt emprunt;

	 
	 
	public Livre() {
		super();
	}


	public Livre(Integer id, String titre, String auteur,String categorie, boolean disponible) {
		super();
		this.id = id;
		this.titre = titre;
		this.auteur = auteur;
		this.categorie = categorie;
		this.disponible = disponible;
	}
	
	


	public Livre(String titre, String auteur,String categorie, boolean disponible) {
		super();
		this.titre = titre;
		this.auteur = auteur;
		this.categorie = categorie;
		this.disponible = disponible;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id ) {
		this.id = id;
	}


	public String getTitre() {
		return titre;
	}


	public void setTitre(String titre) {
		this.titre = titre;
	}


	public String getAuteur() {
		return auteur;
	}


	public void setAuteur(String auteur) {
		this.auteur = auteur;
	}

	public String getCategorie() {
		return categorie;
	}


	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}
	

	public boolean isDisponible() {
		return disponible;
	}


	public void setDisponible(boolean dispo) {
		this.disponible = dispo;
	}

	

	public Emprunt getEmprunt() {
		return emprunt;
	}



	public void setEmprunt(Emprunt emprunt) {
		this.emprunt = emprunt;
	}

/*
	
	@Override
	public String toString() {
		return "Livre [id=" + id + ", titre=" + titre + ", auteur=" + auteur + ", categorie=" + categorie
				+ ", disponible=" + disponible + ", emprunt=" + emprunt + "]";
	}

	*/
	
}
