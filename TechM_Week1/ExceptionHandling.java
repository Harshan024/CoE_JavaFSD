package Week_1;

import java.util.*;

public class ExceptionHandling {

	public static void main(String[] args) {
		 
		 processInput();
		 
	}
	
	static void processInput() {
		
        Scanner sc= new Scanner (System.in);
        
		while(true) {

		    try {
			
			   double num= sc.nextDouble();
			
			   if(num==0) {
				
		           throw new ArithmeticException("Division by zero is not possible");
			   }
			   double reci= 1.0/ num;
			   System.out.println("The reciprocal of a given number is: "+reci);
		  }
		 
		    catch(ArithmeticException e) {
		   
		    System.out.println("Enter a valid input");
		    sc.next();
		  }
		
		    catch(InputMismatchException e) {
		 
		    System.out.println("Enter a valid input");
		    sc.next();
		  }
		
	   }
		
	}

}
