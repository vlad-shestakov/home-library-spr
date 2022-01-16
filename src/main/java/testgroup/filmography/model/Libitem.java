package testgroup.filmography.model;

import javax.persistence.*;
import java.math.BigInteger;
import java.sql.Date;
import java.util.Objects;

@Entity
public class Libitem {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "LIBRARYITEMNO", nullable = false, precision = 0)
    private BigInteger libraryitemno;
    @Basic
    @Column(name = "LIBRARYNO", nullable = false, precision = 0)
    private BigInteger libraryno;
    @Basic
    @Column(name = "ITEMNAME", nullable = false, length = 2000)
    private String itemname;
    @Basic
    @Column(name = "ITEMAUTHOR", nullable = true, length = 255)
    private String itemauthor;
    @Basic
    @Column(name = "GENRE", nullable = true, length = 255)
    private String genre;
    @Basic
    @Column(name = "ITEMDESC", nullable = true, length = 4000)
    private String itemdesc;
    @Basic
    @Column(name = "ITEMYEAR", nullable = true, precision = 0)
    private Short itemyear;
    @Basic
    @Column(name = "PUBLISHERNAME", nullable = true, length = 500)
    private String publishername;
    @Basic
    @Column(name = "PAGES", nullable = true, precision = 0)
    private BigInteger pages;
    @Basic
    @Column(name = "ADDINGDATE", nullable = false)
    private Date addingdate;

    public BigInteger getLibraryitemno() {
        return libraryitemno;
    }

    public void setLibraryitemno(BigInteger libraryitemno) {
        this.libraryitemno = libraryitemno;
    }

    public BigInteger getLibraryno() {
        return libraryno;
    }

    public void setLibraryno(BigInteger libraryno) {
        this.libraryno = libraryno;
    }

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public String getItemauthor() {
        return itemauthor;
    }

    public void setItemauthor(String itemauthor) {
        this.itemauthor = itemauthor;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getItemdesc() {
        return itemdesc;
    }

    public void setItemdesc(String itemdesc) {
        this.itemdesc = itemdesc;
    }

    public Short getItemyear() {
        return itemyear;
    }

    public void setItemyear(Short itemyear) {
        this.itemyear = itemyear;
    }

    public String getPublishername() {
        return publishername;
    }

    public void setPublishername(String publishername) {
        this.publishername = publishername;
    }

    public BigInteger getPages() {
        return pages;
    }

    public void setPages(BigInteger pages) {
        this.pages = pages;
    }

    public Date getAddingdate() {
        return addingdate;
    }

    public void setAddingdate(Date addingdate) {
        this.addingdate = addingdate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Libitem libitem = (Libitem) o;
        return Objects.equals(libraryitemno, libitem.libraryitemno) && Objects.equals(libraryno, libitem.libraryno) && Objects.equals(itemname, libitem.itemname) && Objects.equals(itemauthor, libitem.itemauthor) && Objects.equals(genre, libitem.genre) && Objects.equals(itemdesc, libitem.itemdesc) && Objects.equals(itemyear, libitem.itemyear) && Objects.equals(publishername, libitem.publishername) && Objects.equals(pages, libitem.pages) && Objects.equals(addingdate, libitem.addingdate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(libraryitemno, libraryno, itemname, itemauthor, genre, itemdesc, itemyear, publishername, pages, addingdate);
    }
}
