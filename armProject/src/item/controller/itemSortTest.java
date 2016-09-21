package item.controller;

import java.util.Comparator;

import item.model.vo.Item;

public class itemSortTest implements Comparator{

	@Override
	public int compare(Object o1, Object o2) {
		Item i1 = (Item)o1;
		Item i2 = (Item)o2;
		
		return i2.getItemCatNo()-i1.getItemCatNo();
	}

}
