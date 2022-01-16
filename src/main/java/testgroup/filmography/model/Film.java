package testgroup.filmography.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "films")
public class Film {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "title")
    private String title;

    @Column(name = "year")
    private Integer year;

    @Column(name = "genre")
    private String genre;

    @Column(name = "watched")
    private Boolean watched;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Boolean getWatched() {
        return watched;
    }

    public void setWatched(Boolean watched) {
        this.watched = watched;
    }


//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (o == null || getClass() != o.getClass()) return false;
//        Film film = (Film) o;
//        return id == film.id && Objects.equals(title, film.title)
//                    && Objects.equals(year, film.year)
//                    && Objects.equals(genre, film.genre)
//                    && Objects.equals(watched, film.watched);
//    }

//    @Override
//    public int hashCode() {
//        return Objects.hash(id, title, year, genre, watched);
//    }

    @Override
    public String toString() {
        return id + " " + title + " " + year + " " + genre + " " + watched;
    }
}

