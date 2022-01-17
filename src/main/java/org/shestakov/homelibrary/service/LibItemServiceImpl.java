package org.shestakov.homelibrary.service;

import org.shestakov.homelibrary.dao.LibItemDAO;
import org.shestakov.homelibrary.model.LibItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LibItemServiceImpl implements LibItemService {

    private LibItemDAO libItemDAO;

    @Autowired
    public void setLibItemDAO(LibItemDAO libItemDAO) {
        this.libItemDAO = libItemDAO;
    }

    @Override
    @Transactional
    public List<LibItem> allLibItems(int page) {
        return libItemDAO.allLibItems(page);
    }

    @Override
    @Transactional
    public int libItemsCount() {
        return libItemDAO.libItemsCount();
    }

}
