package org.shestakov.homelibrary.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.shestakov.homelibrary.model.Film;
import org.shestakov.homelibrary.model.LibItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;

@Repository
public class LibItemDAOImpl implements LibItemDAO{
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<LibItem> allLibItems(int page) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from LibItem").setFirstResult(10 * (page - 1)).setMaxResults(10).list();
//        return session.createQuery("from LibItem").list();
    }

    @Override
    public void add(LibItem libItem) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(libItem);
    }

    @Override
    public void delete(LibItem libItem) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(libItem);
    }

    @Override
    public void edit(LibItem libItem) {
        Session session = sessionFactory.getCurrentSession();
        session.update(libItem);
    }


    @Override
    public LibItem getById(BigInteger libraryNo) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(LibItem.class, libraryNo);
    }

    @Override
    public int libItemsCount() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("select count(*) from LibItem ", Number.class).getSingleResult().intValue();
    }

    @Override
    public boolean checkByItemName(String itemName) {
        Session session = sessionFactory.getCurrentSession();
        Query query;
        query = session.createQuery("from LibItem where itemName = :itemName");
        query.setParameter("itemName", itemName);
        return query.list().isEmpty();
    }

}
