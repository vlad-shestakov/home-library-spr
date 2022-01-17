package org.shestakov.homelibrary.service;

import org.shestakov.homelibrary.model.LibItem;

import java.math.BigInteger;
import java.util.List;

public interface LibItemService {
    List<LibItem> allLibItems(int page);
    void add(LibItem libItem);
    void delete(LibItem libItem);
    void edit(LibItem libItem);
    LibItem getById(BigInteger libraryNo);

    int libItemsCount();

    boolean checkByItemName(String itemName);
}
