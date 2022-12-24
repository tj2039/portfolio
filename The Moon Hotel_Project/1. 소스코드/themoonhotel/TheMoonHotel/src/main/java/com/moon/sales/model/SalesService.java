package com.moon.sales.model;

import java.sql.SQLException;
import java.util.List;

public class SalesService {
	private SalesDAO dao;
	
	public SalesService() {
		dao=new SalesDAO();
	}
	
	public List<SalesVO2> salesByLocNo(String d1, String d2, String locName) throws SQLException{
		return dao.salesByLocNo(d1, d2, locName);
	}
	
	public List<SalesVO2> salesByFac(String d1, String d2, String locName) throws SQLException{
		return dao.salesByFac(d1, d2, locName);
	}
}
