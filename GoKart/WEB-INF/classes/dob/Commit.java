package dob;

import java.sql.SQLException;

public class Commit {
	private java.sql.Connection dbconnection = null;
	
	public Commit(){
		Connect con = new Connect();
		dbconnection = con.getDbconnection();
	}
	
	public java.sql.Connection getDbconnection() {
		return dbconnection;
	}

	public void setDbconnection(java.sql.Connection connection) {
		dbconnection = connection;
	}

	public void onCommit(){
		try {
			dbconnection.setAutoCommit(true);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void offCommit(){
		try {
			dbconnection.setAutoCommit(false);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void runCommit(){
		try {
			dbconnection.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void rollBack(){
		try {
			dbconnection.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
