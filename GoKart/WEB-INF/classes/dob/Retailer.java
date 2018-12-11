package dob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class Retailer {

	private Connection dbconnection = null;
	private PreparedStatement updateRetailerBalanceQuery = null;
	private PreparedStatement insertRetailerQuery = null;
	private PreparedStatement searchRetailerQuery = null;
	
	private Statement statementquery = null;
	private ResultSet rs=null;

	
	
	public Retailer(Connection connection) {
		super();
		this.dbconnection = connection;
		try {
			searchRetailerQuery = dbconnection.prepareStatement("SELECT `password` FROM `retailers` WHERE email=? ");
			statementquery = dbconnection.createStatement();
			updateRetailerBalanceQuery = dbconnection.prepareStatement("UPDATE `retailers` SET `balance`=? WHERE email=?");
			insertRetailerQuery = dbconnection.prepareStatement("INSERT INTO `retailers` (`name`, `email`, `phone`, `password`, `pan`, `balance`) VALUES (?, ?, ?, ?, ?, ?);");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean updateRetailerBalance(float retailerBalance, String retailerEmail) {
		// TODO Auto-generated method stub
		try {
			updateRetailerBalanceQuery.setFloat(1, retailerBalance);
			updateRetailerBalanceQuery.setString(2, retailerEmail);
			updateRetailerBalanceQuery.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}

	
	public String searchRetailer(String email){
		try {
			searchRetailerQuery.setString(1, email);
			rs = searchRetailerQuery.executeQuery();
			while(rs.next())
				return rs.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";			
		}
		return "not_found";
		
	}
	
	public String insertRetailer(String name, String email, String phone, String password, String pan, int balance){
		try {
			insertRetailerQuery.setString(1, name);
			insertRetailerQuery.setString(2, email);
			insertRetailerQuery.setString(3, phone);
			insertRetailerQuery.setString(4, password);
			insertRetailerQuery.setString(5, pan);
			insertRetailerQuery.setInt(6, balance);
			
			if(insertRetailerQuery.executeUpdate()>=1)
				return "success";
		} 
		catch(MySQLIntegrityConstraintViolationException e){
			//e.printStackTrace();
			return "duplicationError";
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			return "sqlError";
		}
		return "error";
		
	}
	
	public int retailerbalance(String email){
		try {
			ResultSet rs = statementquery.executeQuery("select balance from retailers where email='"+email+"'");
			while(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -11;
	}
	
}
