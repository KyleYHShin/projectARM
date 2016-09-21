package item.controller;

import java.util.Comparator;

import item.model.vo.Item;

public class AscPrice implements Comparator{

	@Override
	public int compare(Object o1, Object o2) {
		Item i1 = (Item)o1;
		Item i2 = (Item)o2;
		
		return i1.getItemPrice()-i2.getItemPrice();
	}

}
