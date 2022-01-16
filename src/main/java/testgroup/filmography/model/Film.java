package testgroup.filmography.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "films")
public class Film {

    @Id
//    @Basic
    @Column(name = "ID", nullable = false, precision = 0)
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "my_generator2")
    @SequenceGenerator(name = "my_generator2", sequenceName = "FILMSIDSEQ", allocationSize = 1)
    private int id;

    @Basic
    @Column(name = "TITLE", nullable = false, length = 100)
    private String title;

    @Basic
    @Column(name = "YEAR", nullable = true, precision = 0)
    private Integer year;

    @Basic
    @Column(name = "GENRE", nullable = true, length = 20)
    private String genre;

    @Basic
    @Column(name = "WATCHED", nullable = true, precision = 0)
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


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Film film = (Film) o;
        return id == film.id && Objects.equals(title, film.title)
                    && Objects.equals(year, film.year)
                    && Objects.equals(genre, film.genre)
                    && Objects.equals(watched, film.watched);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, title, year, genre, watched);
    }

    @Override
    public String toString() {
        return id + " " + title + " " + year + " " + genre + " " + watched;
    }
}

