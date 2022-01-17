package org.shestakov.homelibrary.service;

import org.shestakov.homelibrary.dao.LibItemDAO;
import org.shestakov.homelibrary.model.LibItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
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
    public void add(LibItem libItem) {
        libItemDAO.add(libItem);
    }

    @Override
    @Transactional
    public void delete(LibItem libItem) {
        libItemDAO.delete(libItem);
    }

    @Override
    @Transactional
    public void edit(LibItem libItem) {
        libItemDAO.edit(libItem);
    }

    @Override
    @Transactional
    public LibItem getById(BigInteger libraryNo) {
        return libItemDAO.getById(libraryNo);
    }

    @Override
    @Transactional
    public int libItemsCount() {
        return libItemDAO.libItemsCount();
    }

    @Override
    @Transactional
    public boolean checkByItemName(String itemName) {
        return libItemDAO.checkByItemName(itemName);
    }

}
