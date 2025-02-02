package Week_1;

import java.util.Scanner;
public class StringProcessor {

	public static void main(String[] args) {
		
		Scanner sc=new Scanner (System.in);
		int choice;
		do {
			System.out.println("\nString Processor: ");
			System.out.println("1. Reverse String");
	        System.out.println("2. Count Occurrences");
	        System.out.println("3. Split and Capitalize");
	        System.out.print("Enter your choice: ");
			choice= sc.nextInt();
			sc.nextLine();
			
			switch(choice) {
			
			case 1:{
				System.out.println(" Enter String: ");
				String str=sc.nextLine();
				System.out.println("Reversed String: "+reverseString(str)); 
				break;
				}
			
			case 2:{
				System.out.println(" Enter Text: ");
				String text= sc.nextLine();
				System.out.println(" Enter Sub: ");
				String sub= sc.nextLine();
				System.out.println("No. of Occurrences: "+countOccurrences(text, sub)); 
				break;
				}
			
			case 3:{
				System.out.println(" Enter String: ");
				String str=sc.nextLine();
                System.out.println("String after Split and Capitalize: "+splitAndCapitalize(str));			
                break;
				}
			
			case 4:{
				System.out.println("Exiting Program");
				break;
			}
			
			default:
				System.out.println("Invalid choice...Please try again!");
					
			}
			
		} while(choice !=4 );
		
		sc.close();
	}
	
	static String reverseString(String str) {
		int n= str.length()-1;
		String rev="";
		
		for(int i= n; i>=0; i--) {
			rev += str.charAt(i);
	  }return rev;
	}
	
	static int countOccurrences(String text, String sub) {
		int  count= 0;
		int index= 0;
		
		while((index= text.indexOf(sub,index))!=-1) {
			count++;
			index  += sub.length();
		}return count;
		
	}
	
	static String splitAndCapitalize(String str) {
		if (str == null || str.isEmpty()) {
	        return "";
	    }

	    StringBuilder result = new StringBuilder();
	    String[] words = str.split(" ");

	    for (String word : words) {
	        if (!word.isEmpty()) {
	            char firstChar = Character.toUpperCase(word.charAt(0));
	            String restOfWord = word.substring(1).toLowerCase();
	            result.append(firstChar).append(restOfWord).append(" ");
	        }
	    }
	    return result.toString().trim();
	}

}
