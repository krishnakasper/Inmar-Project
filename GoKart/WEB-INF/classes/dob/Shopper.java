package dob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class Shopper {

	private Connection dbconnection = null;
	private PreparedStatement updateShopperBalanceQuery = null;
	private PreparedStatement searchShopperQuery = null;
	private PreparedStatement insertShopperQuery = null;
	private PreparedStatement getShopperNameQuery = null;
	private ResultSet rs = null;
	private PreparedStatement shopperPurchaseRetailerQuery = null;
	private Statement statementquery = null;
	
	public Shopper(Connection connection) {
		super();
		this.dbconnection = connection;
		try {
			shopperPurchaseRetailerQuery = dbconnection.prepareStatement("SELECT date FROM `transactions` WHERE creditor=? and debitor=? and DATE(date)=DATE(NOW()) ");
			searchShopperQuery = dbconnection.prepareStatement("SELECT `password` FROM `shoppers` WHERE email=? ");
			updateShopperBalanceQuery = dbconnection.prepareStatement("UPDATE `shoppers` SET `balance`=? WHERE email=?");
			getShopperNameQuery =dbconnection.prepareStatement("SELECT `name` FROM `shoppers` WHERE email=?");
			statementquery = dbconnection.createStatement();
			insertShopperQuery = dbconnection.prepareStatement("INSERT INTO `shoppers` (`name`, `email`, `phone`, `address`, `password`, `balance`) VALUES (?, ?, ?, ?, ?, ?);");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean updateShopperBalance(float shopperBalance, String shopperEmail) {
		// TODO Auto-generated method stub
		try {
			updateShopperBalanceQuery.setFloat(1, shopperBalance);
			updateShopperBalanceQuery.setString(2, shopperEmail);
			updateShopperBalanceQuery.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
		
	}

	public String getShopperName(String email){
		try {
			getShopperNameQuery.setString(1, email);
			rs = getShopperNameQuery.executeQuery();
			while(rs.next())
				return rs.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}
		return "not_found";
	}
	
	public int shopperbalance(String email){
		try {
			ResultSet rs = statementquery.executeQuery("select balance from shoppers where email='"+email+"'");
			while(rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -11;
	}
	
	public String insertShopper(String name, String email, String phone, String address, String password, int balance){
		try {
			insertShopperQuery.setString(1, name);
			insertShopperQuery.setString(2, email);
			insertShopperQuery.setString(3, phone);
			insertShopperQuery.setString(4, address);
			insertShopperQuery.setString(5, password);
			insertShopperQuery.setInt(6, balance);
			if(insertShopperQuery.executeUpdate()>=1)
				return "success";
		} 
		catch(MySQLIntegrityConstraintViolationException e){
//			e.printStackTrace();
			return "duplicationError";
		}

		catch (SQLException e) {
			// TODO Auto-generated catch block
//			e.printStackTrace();
			return "sqlError";
		}
		return "error";
		
	}

	public boolean shopperPurchaseRetailer(String shopperEmail, String retailerEmail){
		try {
			shopperPurchaseRetailerQuery.setString(1, retailerEmail);
			shopperPurchaseRetailerQuery.setString(2, shopperEmail);
			ResultSet rs = shopperPurchaseRetailerQuery.executeQuery();
			if(rs.next())
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return false;
	}
	
	public String searchShopper(String email){
		try {
			searchShopperQuery.setString(1, email);
			rs = searchShopperQuery.executeQuery();
			while(rs.next())
				return rs.getString(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}
		return "notFound";
	}
	
}
