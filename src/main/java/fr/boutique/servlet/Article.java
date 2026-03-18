package fr.boutique.servlet;

public class Article {
    private final String reference;
    private final String nom;
    private final double prix;
    private final String categorie;

    public Article(String reference, String nom, double prix, String categorie) {
        this.reference = reference;
        this.nom = nom;
        this.prix = prix;
        this.categorie = categorie;
    }

    public String getReference()  { return reference; }
    public String getNom()        { return nom; }
    public double getPrix()       { return prix; }
    public String getCategorie()  { return categorie; }
}
