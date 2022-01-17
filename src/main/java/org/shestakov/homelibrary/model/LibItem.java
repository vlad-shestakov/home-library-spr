package org.shestakov.homelibrary.model;

import javax.persistence.*;
import java.math.BigInteger;
import java.sql.Date;
import java.util.Objects;
import java.util.Optional;

@Entity
//@DynamicInsert // Теперь это динамическая сущность, которая опускает поля с типом null, для default в createDate
@Table(name = "LIBITEM", schema = "HOMELIB")
public class LibItem {

    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "my_generator2")
    @SequenceGenerator(name = "my_generator2", sequenceName = "LIBITEMSEQ", allocationSize = 1)
    @Column(name = "LIBRARYITEMNO", nullable = false, precision = 0)
    private BigInteger libraryItemNo;
    @Basic
    @Column(name = "LIBRARYNO", nullable = false, precision = 0)
    private BigInteger libraryNo;
    @Basic
    @Column(name = "ITEMNAME", nullable = false, length = 2000)
    private String itemName;
    @Basic
    @Column(name = "ITEMAUTHOR", nullable = true, length = 255)
    private String itemAuthor;
    @Basic
    @Column(name = "GENRE", nullable = true, length = 255)
    private String genre;
    @Basic
    @Column(name = "ITEMDESC", nullable = true, length = 4000)
    private String itemDesc;
    @Basic
    @Column(name = "ITEMYEAR", nullable = true, precision = 0)
    private Short itemYear;
    @Basic
    @Column(name = "PUBLISHERNAME", nullable = true, length = 500)
    private String publisherName;
    @Basic
    @Column(name = "PAGES", nullable = true, precision = 0)
    private BigInteger pages;
    @Basic
    @Column(name = "ADDINGDATE", nullable = true) // Сделал nullable, чтобы БД сама заполнила по-умолчанию
    private Date addingDate;

    /**
     * Getters and Setters
     */

    public BigInteger getLibraryItemNo() {
        return libraryItemNo;
    }

    public void setLibraryItemNo(BigInteger libraryItemNo) {
        this.libraryItemNo = libraryItemNo;
    }

    public BigInteger getLibraryNo() {
        return libraryNo;
    }

    public void setLibraryNo(BigInteger libraryNo) {
        this.libraryNo = libraryNo;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemAuthor() {
        return itemAuthor;
    }

    public void setItemAuthor(String itemAuthor) {
        this.itemAuthor = itemAuthor;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    public Short getItemYear() {
        return itemYear;
    }

    public void setItemYear(Short itemYear) {
        this.itemYear = itemYear;
    }

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    public BigInteger getPages() {
        return pages;
    }

    public void setPages(BigInteger pages) {
        this.pages = pages;
    }

    public Date getAddingDate() {
        return addingDate;
    }

    public void setAddingDate(Date addingDate) {
        this.addingDate = addingDate;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LibItem libitem = (LibItem) o;
        return Objects.equals(libraryItemNo, libitem.libraryItemNo)
                && Objects.equals(libraryNo, libitem.libraryNo)
                && Objects.equals(itemName, libitem.itemName)
                && Objects.equals(itemAuthor, libitem.itemAuthor)
                && Objects.equals(genre, libitem.genre)
                && Objects.equals(itemDesc, libitem.itemDesc)
                && Objects.equals(itemYear, libitem.itemYear)
                && Objects.equals(publisherName, libitem.publisherName)
                && Objects.equals(pages, libitem.pages)
                && Objects.equals(addingDate, libitem.addingDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(libraryItemNo, libraryNo, itemName, itemAuthor, genre, itemDesc, itemYear, publisherName, pages, addingDate);
    }

    /** Вербализация объекта */
    @Override
    public String toString() {
        return String.format("LibraryItem {%s[%s]. %s (%s) / %s / %s / %s / %s / %s стр.}"
                , libraryItemNo
                ,  Optional.ofNullable(String.valueOf(libraryNo)).orElse("")
                ,  Optional.ofNullable(itemName).orElse("")
                ,  Optional.ofNullable(String.valueOf(itemYear)).orElse("")
                ,  Optional.ofNullable(itemAuthor).orElse("")
                ,  Optional.ofNullable(genre).orElse("")
                ,  Optional.ofNullable(itemDesc).orElse("")
                ,  Optional.ofNullable(publisherName).orElse("")
                ,  Optional.ofNullable(String.valueOf(pages)).orElse("")
        );
    }
}
