package dob;
//
//public class Main {
//
//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//		Queries q = new Queries();
//		//System.out.println(q.insertRetailer("krishna", "sanketh@gmail.com", "8686885812", "sanketh", "none", 3500));
//		System.out.println(q.searchShopper("kasper@gmail.com"));
//		//System.out.println(q.insertStore("sanketh@gmail.com","krishna", "hayath nagar"));
//		//q.initializeFruits("chachidak@gmail.com");
//		//System.out.println(q.getfruitsPrices("harshith@gmail.com"));
//		//System.out.println(q.getTransactionList("kasper@gmail.com", "false"));
//
//	}
//
//}
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Main {
    
    public static int divisor(int num){
        int count=0;
    
        for(int i=1;i<=Math.sqrt(num);i++){
            if(num%i == 0)
                count+=2;
            if(num%i==i)
                count--;
        }
        return count;
        
    }
    
    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
    	System.out.println(2%1);
        Scanner s = new Scanner(System.in);
        int test = s.nextInt();
        while(test>0){
            int num = s.nextInt();
            System.out.println(divisor(num));
            test--;
        }
    }
}