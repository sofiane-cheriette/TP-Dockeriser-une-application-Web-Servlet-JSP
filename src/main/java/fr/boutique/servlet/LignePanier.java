package fr.boutique.servlet;

public class LignePanier {
    private final Article article;
    private int quantite;

    public LignePanier(Article article, int quantite) {
        this.article = article;
        this.quantite = quantite;
    }

    public Article getArticle()     { return article; }
    public int getQuantite()        { return quantite; }
    public void setQuantite(int q)  { this.quantite = q; }
    public double getSousTotal()    { return article.getPrix() * quantite; }
}
