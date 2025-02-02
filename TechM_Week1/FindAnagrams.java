package Week_1;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FindAnagrams {

    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        int n = s.length();
        int m = p.length();

        if (m > n) {
            return result;
        }

        int[] pCount = new int[26];
        int[] sCount = new int[26];

        for (char c : p.toCharArray()) {
            pCount[c - 'a']++;
        }

     
        for (int i = 0; i <= n - m; i++) {
            
            if (i == 0) {
                for (int j = 0; j < m; j++) {
                    sCount[s.charAt(j) - 'a']++;
                }
            } else {
                
                sCount[s.charAt(i - 1) - 'a']--;
                sCount[s.charAt(i + m - 1) - 'a']++;
            }


            if (Arrays.equals(sCount, pCount)) {
                result.add(i);
            }
        }

        return result;
    }

    public static void main(String[] args) {
        FindAnagrams finder = new FindAnagrams();
        
        java.util.Scanner sc= new java.util.Scanner(System.in);
        while(true) {
        
        System.out.println("Enter String 's': ");
        String s= sc.next();
        
        System.out.println("Enter String 'p': ");
        String p= sc.next();
        
        List<Integer> indices = finder.findAnagrams(s, p);
        System.out.println("Anagram indices: " + indices+ "\n");

        }
     /*   String s = "cab";
        String p = "abc";
        List<Integer> indices = finder.findAnagrams(s, p);
        System.out.println("Anagram indices: " + indices); // O/p: [0]

        s = "abab";
        p = "ab";
        indices = finder.findAnagrams(s, p);
        System.out.println("Anagram indices: " + indices); // O/p: [0, 1, 2]
        
        s = "a";
        p = "cab";
        indices = finder.findAnagrams(s, p);
        System.out.println("Anagram indices: " + indices); // O/p: []

        s= "ratcatmatat";
        p = "at";
        indices = finder.findAnagrams(s, p);
        System.out.println("Anagram indices: " + indices); // Output: [1, 4, 7, 8, 9]
     */
    }
}