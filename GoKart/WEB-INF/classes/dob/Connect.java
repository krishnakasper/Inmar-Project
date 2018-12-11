package dob;
import java.sql.*;

public class Connect {

	private static java.sql.Connection dbconnection = null;
	private String username="krishna";
	private String password = "sanketh";
	private String database = "gokart";
	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDatabase() {
		return database;
	}

	public void setDatabase(String database) {
		this.database = database;
	}

	public java.sql.Connection getDbconnection() {
		if(dbconnection==null)
			this.createConnection();
		return dbconnection;
	}

	public void setDbconnection(java.sql.Connection dbconnection) {
		Connect.dbconnection = dbconnection;
	}
	
	public Connect(){
		
		username="krishna";
		password = "sanketh";
		database = "gokart";
	}
	
	public void createConnection(){
		Connect con = new Connect();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			dbconnection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/"+con.database,con.username,con.password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

//	@Override
//	protected void finalize() {
//		// TODO Auto-generated method stub
//		try {
//			dbconnection.close();
//			super.finalize();
//		} catch (Throwable e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	
	
}
