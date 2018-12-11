package dob;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class Store {

	private Connection dbconnection = null;
	private Statement statementquery = null;
	private ResultSet rs=null;
	private PreparedStatement insertStoreQuery = null;
	
	public Store(Connection connection) {
		super();
		this.dbconnection = connection;
		try {
			insertStoreQuery = dbconnection.prepareStatement("INSERT INTO `stores`(`email`, `name`, `address`) VALUES (?,?,?)");
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			statementquery = dbconnection.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public String getstorename(String email){
		try{
			rs = statementquery.executeQuery("select name from stores where email='"+email+"'");
			rs.next();
			return rs.getString(1);
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return "error";
	}
	
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
//		e.printStackTrace();
		return "duplicationError";
	}

	catch (SQLException e) {
		// TODO Auto-generated catch block
//		e.printStackTrace();
		return "sqlError";
	}
	return "error";
}

}
