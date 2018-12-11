package dob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class Transactions {
	
	private Connection dbconnection = null;
	private PreparedStatement insertTransactionQuery=null;
	private PreparedStatement getRetailerTransactionQuery = null;
	private PreparedStatement getShopperTransactionQuery = null;
	
	private Shopper shopper = null;
	private Retailer retailer = null;
	
	public Transactions(Connection connection) {
		super();
		this.dbconnection = connection;
		
		try {
			shopper = new Shopper(connection);
			retailer = new Retailer(connection);
			insertTransactionQuery = dbconnection.prepareStatement("INSERT INTO `transactions`(`amount`, `date`, `creditor`, `debitor`) VALUES (?,NOW(),?,?);");
			getShopperTransactionQuery = dbconnection.prepareStatement("SELECT `id`,`date`, `creditor`, `debitor`, `amount`  FROM `transactions` WHERE debitor=?");
			getRetailerTransactionQuery = dbconnection.prepareStatement("SELECT `id`, `date`, `creditor`, `debitor`, `amount`  FROM `transactions` WHERE creditor=?");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<String[]> getTransactionList(String email, String retailerCheck){
		ArrayList<String[]> transactionList = new ArrayList<>();
		//retailercheck = true then check credit column else debit column
		if(retailerCheck.equals("true")){
			try {
				getRetailerTransactionQuery.setString(1, email);
				ResultSet rs = getRetailerTransactionQuery.executeQuery();
				while(rs.next()){
					String[] temp = new String[5];
					temp[0] = rs.getString(1);
					temp[1] = rs.getString(2);
					temp[2] = rs.getString(3);
					temp[3] = rs.getString(4);
					temp[4] = rs.getString(5);
					transactionList.add(temp);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		else{
			try {
				getShopperTransactionQuery.setString(1, email);
				ResultSet rs = getShopperTransactionQuery.executeQuery();
				while(rs.next()){
					String[] temp = new String[5];
					temp[0] = rs.getString(1);
					temp[1] = rs.getString(2);
					temp[2] = rs.getString(3);
					temp[3] = rs.getString(4);
					temp[4] = rs.getString(5);
					transactionList.add(temp);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return transactionList;
		
	}

	
	public boolean addTransaction(float price, String shopperEmail,String retailerEmail){
		try {
			insertTransactionQuery.setFloat(1, price);
			insertTransactionQuery.setString(2, retailerEmail);
			insertTransactionQuery.setString(3, shopperEmail);
			insertTransactionQuery.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	
	public boolean maketransaction(float price,String shopperEmail,String retailerEmail){
		float shopperBalance = shopper.shopperbalance(shopperEmail);
		shopperBalance -=price;
		float retailerBalance = retailer.retailerbalance(retailerEmail);
		retailerBalance+=price;
		if(shopper.updateShopperBalance(shopperBalance, shopperEmail) && retailer.updateRetailerBalance(retailerBalance,retailerEmail) && addTransaction(price,shopperEmail,retailerEmail))
			return true;
		return false;
	}
}
