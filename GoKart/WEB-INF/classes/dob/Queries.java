package dob;
import java.sql.*;
import java.util.ArrayList;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import dob.Connect;

public class Queries {
	
	private PreparedStatement insertRetailerQuery = null;
	private PreparedStatement insertShopperQuery = null;
	private PreparedStatement searchRetailerQuery = null;
	private PreparedStatement searchShopperQuery = null;
	private java.sql.Connection dbconnection = null;
	private PreparedStatement insertStoreQuery = null;
	private Statement statementquery = null;
	private ResultSet rs=null;
	private PreparedStatement updateShopperBalanceQuery = null;
	private PreparedStatement updateRetailerBalanceQuery = null;
	private PreparedStatement insertTransactionQuery=null;
	private PreparedStatement selectFruitsPriceQuery = null;
	private PreparedStatement selectFruitsQuantityQuery = null;
	private PreparedStatement updateFruitsPriceQuery = null;
	private PreparedStatement getRetailerTransactionQuery = null;
	private PreparedStatement getShopperTransactionQuery = null;
	private PreparedStatement updateFruitQuantityQuery = null;
	private PreparedStatement getShopperNameQuery = null;
	private PreparedStatement shopperPurchaseRetailerQuery = null;
	private PreparedStatement onlyOnceUpdateRetailerPrice = null;
	private PreparedStatement onlyOnceUpdateRetailerQuantity = null;
	
	public Queries(){
		Connect con = new Connect();
		dbconnection = con.getDbconnection();

		try {
			insertRetailerQuery = dbconnection.prepareStatement("INSERT INTO `retailers` (`name`, `email`, `phone`, `password`, `pan`, `balance`) VALUES (?, ?, ?, ?, ?, ?);");
			insertShopperQuery = dbconnection.prepareStatement("INSERT INTO `shoppers` (`name`, `email`, `phone`, `address`, `password`, `balance`) VALUES (?, ?, ?, ?, ?, ?);");
			insertStoreQuery = dbconnection.prepareStatement("INSERT INTO `stores`(`email`, `name`, `address`) VALUES (?,?,?)");
			searchRetailerQuery = dbconnection.prepareStatement("SELECT `password` FROM `retailers` WHERE email=? ");
			searchShopperQuery = dbconnection.prepareStatement("SELECT `password` FROM `shoppers` WHERE email=? ");
			statementquery = dbconnection.createStatement();
			updateShopperBalanceQuery = dbconnection.prepareStatement("UPDATE `shoppers` SET `balance`=? WHERE email=?");
			updateRetailerBalanceQuery = dbconnection.prepareStatement("UPDATE `retailers` SET `balance`=? WHERE email=?");
			insertTransactionQuery = dbconnection.prepareStatement("INSERT INTO `transactions`(`amount`, `date`, `creditor`, `debitor`) VALUES (?,NOW(),?,?);");
			selectFruitsPriceQuery = dbconnection.prepareStatement("select price from fruits where email=? and name=?");
			selectFruitsQuantityQuery = dbconnection.prepareStatement("select quantity from fruits where email=? and name=?");
			updateFruitsPriceQuery = dbconnection.prepareStatement("UPDATE `fruits` SET `price`=? , `pricedate`=CURDATE() WHERE email=? and name=?");
			getRetailerTransactionQuery = dbconnection.prepareStatement("SELECT `id`, `date`, `creditor`, `debitor`, `amount`  FROM `transactions` WHERE creditor=?");
			updateFruitQuantityQuery = dbconnection.prepareStatement("UPDATE `fruits` SET `quantity`=? , `quantitydate`=CURDATE() WHERE email=? and name=?");
			getShopperNameQuery =dbconnection.prepareStatement("SELECT `name` FROM `shoppers` WHERE email=?");
			shopperPurchaseRetailerQuery = dbconnection.prepareStatement("SELECT date FROM `transactions` WHERE creditor=? and debitor=? and DATE(date)=DATE(NOW()) ");
			onlyOnceUpdateRetailerPrice = dbconnection.prepareStatement("select name from fruits where email=? and name=? and pricedate=CURDATE()");
			onlyOnceUpdateRetailerQuantity = dbconnection.prepareStatement("select name from fruits where email=? and name=? and quantitydate=CURDATE()");
			getShopperTransactionQuery = dbconnection.prepareStatement("SELECT `id`,`date`, `creditor`, `debitor`, `amount`  FROM `transactions` WHERE debitor=?");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
	
	
	
	public String getstorename(String email){
		try{
			ResultSet rs = statementquery.executeQuery("select name from stores where email='"+email+"'");
			rs.next();
			return rs.getString(1);
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return "error";
	}
	
	public boolean updateFruitsQuantity(String email, int[] quantity){
		String[] fruits = {"banana","orange","apple","melon","papaya","mango","pineapple","pomegranate","guava"};
		for(int i=0;i<fruits.length;i++){
			try {
				selectFruitsQuantityQuery.setString(1, email);
				selectFruitsQuantityQuery.setString(2, fruits[i]);
				updateFruitQuantityQuery.setString(2, email);
				updateFruitQuantityQuery.setString(3, fruits[i]);
				ResultSet rs = selectFruitsQuantityQuery.executeQuery();
				rs.next();
				//System.out.println(rs.getFloat(1));
				int temp = rs.getInt(1);
				if(temp<quantity[i])
					return false;
				updateFruitQuantityQuery.setInt(1,temp-quantity[i] );
				updateFruitQuantityQuery.executeUpdate();
				}
			 catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			
			
			 }
		}
		
		return true;
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
	
	public boolean changeFruitsPrices(String retailerEmail, float[] fruitsChangingPrices){
		String[] fruits = {"banana","orange","apple","melon","papaya","mango","pineapple","pomegranate","guava"};
		float[] fruitsCurrentPrices = getfruitsPrices(retailerEmail);
		for(int i=0;i<fruits.length;i++){
			if(fruitsCurrentPrices[i]==fruitsChangingPrices[i])
				continue;
			try {
				onlyOnceUpdateRetailerPrice.setString(1, retailerEmail);
				onlyOnceUpdateRetailerPrice.setString(2, fruits[i]);
				ResultSet rs = onlyOnceUpdateRetailerPrice.executeQuery();
				if(rs.next())
					return false;
				updateFruitsPriceQuery.setFloat(1, fruitsChangingPrices[i]);
				//System.out.println(fruitsChangingPrices[i]);
				updateFruitsPriceQuery.setString(2, retailerEmail);
				updateFruitsPriceQuery.setString(3, fruits[i]);
				updateFruitsPriceQuery.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		return true;
		
		
	}
	
	public boolean changeFruitsQuantity(String retailerEmail, int[] fruitsChangingQuantities){
		String[] fruits = {"banana","orange","apple","melon","papaya","mango","pineapple","pomegranate","guava"};
		int[] fruitsCurrentQuantity = getfruitsQuantity(retailerEmail);
		for(int i=0;i<fruits.length;i++){
			if(fruitsCurrentQuantity[i]==fruitsChangingQuantities[i])
				continue;
			try {
				onlyOnceUpdateRetailerQuantity.setString(1, retailerEmail);
				onlyOnceUpdateRetailerQuantity.setString(2, fruits[i]);
				ResultSet rs = onlyOnceUpdateRetailerQuantity.executeQuery();
				if(rs.next())
					return false;
				updateFruitQuantityQuery.setString(2, retailerEmail);
				updateFruitQuantityQuery.setString(3, fruits[i]);
				updateFruitQuantityQuery.setInt(1,fruitsChangingQuantities[i] );
				updateFruitQuantityQuery.executeUpdate();
				
				updateFruitQuantityQuery.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		return true;
		
		
	}
	
	public float[] getfruitsPrices(String email){
		float[] prices = new float[9];
		try {
			
			String[] fruits = {"banana","orange","apple","melon","papaya","mango","pineapple","pomegranate","guava"};
			for(int i=0;i<9;i++){
				selectFruitsPriceQuery.setString(1, email);
				selectFruitsPriceQuery.setString(2, fruits[i]);
				ResultSet rs = selectFruitsPriceQuery.executeQuery();
				while(rs.next()){
				//System.out.println(rs.getFloat(1));
				prices[i] = rs.getFloat(1);
				}
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return prices;
		
	}
	
	public int[] getfruitsQuantity(String email){
		
		int[] quantity = new int[9];
		try {
			
			String[] fruits = {"banana","orange","apple","melon","papaya","mango","pineapple","pomegranate","guava"};
			for(int i=0;i<9;i++){
				selectFruitsQuantityQuery.setString(1, email);
				selectFruitsQuantityQuery.setString(2, fruits[i]);
				ResultSet rs = selectFruitsQuantityQuery.executeQuery();
				while(rs.next()){
				//System.out.println(rs.getFloat(1));
				quantity[i] = rs.getInt(1);
				}
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return quantity;
		
	}
	
	public boolean maketransaction(float price,String shopperEmail,String retailerEmail){
		float shopperBalance = shopperbalance(shopperEmail);
		shopperBalance -=price;
		float retailerBalance = retailerbalance(retailerEmail);
		retailerBalance+=price;
		if(updateShopperBalance(shopperBalance, shopperEmail) && updateRetailerBalance(retailerBalance,retailerEmail) && addTransaction(price,shopperEmail,retailerEmail))
			return true;
		return false;
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
	
	private boolean updateShopperBalance(float shopperBalance, String shopperEmail) {
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

	private boolean updateRetailerBalance(float retailerBalance, String retailerEmail) {
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

//	public ArrayList<String> list = new ArrayList<>();
//	public ArrayList<String> retailers = new ArrayList<>();
//	public ArrayList<String> retaileremails = new ArrayList<>();
	
	public ArrayList<ArrayList<String>> availableStores(){
		
		ArrayList<String> list = new ArrayList<>();
		ArrayList<String> retailers = new ArrayList<>();
		ArrayList<String> retaileremails = new ArrayList<>();
		ArrayList<ArrayList<String>> result = new ArrayList<>();
		
		try {
			ResultSet rs = statementquery.executeQuery("select stores.name, retailers.name, stores.email from stores,retailers where stores.email=retailers.email");
			while(rs.next()){
				list.add(rs.getString(1));
				retailers.add(rs.getString(2));
				retaileremails.add(rs.getString(3));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		result.add(list);
		result.add(retailers);
		result.add(retaileremails);
		
		return result;
		
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
	
	public boolean initializeFruits(String email){
		try {
			Statement st = dbconnection.createStatement();
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','banana',0.5,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','mango',15,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','apple',5,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','guava',2,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','pineapple',20,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','melon',10,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','pomegranate',12,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','orange',1,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
			st.executeUpdate("INSERT INTO `fruits`(`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES ('"+email+"','papaya',8,100,DATE_SUB(CURDATE(),INTERVAL 1 DAY),DATE_SUB(CURDATE(),INTERVAL 1 DAY))");
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
	
	public String insertStore(String email, String name,String address){
		try{
			insertStoreQuery.setString(1, email);
			insertStoreQuery.setString(2, name);
			insertStoreQuery.setString(3, address);
			if(insertStoreQuery.executeUpdate()>=1){
				return "success";
			}
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

}
