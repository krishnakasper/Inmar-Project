package dob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Fruits {
	
	private Connection dbconnection = null;
	private PreparedStatement selectFruitsPriceQuery = null;
	private PreparedStatement selectFruitsQuantityQuery = null;
	private PreparedStatement updateFruitsPriceQuery = null;
	private PreparedStatement updateFruitQuantityQuery = null;
	private PreparedStatement onlyOnceUpdateRetailerPrice = null;
	private PreparedStatement onlyOnceUpdateRetailerQuantity = null;
	
	public Fruits(Connection connection) {
		super();
		this.dbconnection = connection;
		try {
			selectFruitsPriceQuery = dbconnection.prepareStatement("select price from fruits where email=? and name=?");
			selectFruitsQuantityQuery = dbconnection.prepareStatement("select quantity from fruits where email=? and name=?");
			updateFruitsPriceQuery = dbconnection.prepareStatement("UPDATE `fruits` SET `price`=? , `pricedate`=CURDATE() WHERE email=? and name=?");
			updateFruitQuantityQuery = dbconnection.prepareStatement("UPDATE `fruits` SET `quantity`=? , `quantitydate`=CURDATE() WHERE email=? and name=?");
			onlyOnceUpdateRetailerPrice = dbconnection.prepareStatement("select name from fruits where email=? and name=? and pricedate=CURDATE()");
			onlyOnceUpdateRetailerQuantity = dbconnection.prepareStatement("select name from fruits where email=? and name=? and quantitydate=CURDATE()");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
}
