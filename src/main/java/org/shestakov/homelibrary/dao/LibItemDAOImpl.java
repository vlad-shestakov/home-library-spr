package org.shestakov.homelibrary.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.shestakov.homelibrary.model.LibItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
//        return session.createQuery("from LibItem").setFirstResult(10 * (page - 1)).setMaxResults(10).list();
        return session.createQuery("from LibItem").list();
    }


}
