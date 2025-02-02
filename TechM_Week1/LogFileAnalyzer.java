package Week_1;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class LogFileAnalyzer {

    public void analyzeLogFile(String inputFile, String outputFile, Set<String> keywords) {
        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

            String line;
            int totalLines = 0;
            int matchedLines = 0;

            while ((line = reader.readLine()) != null) {
                totalLines++;
                for (String keyword : keywords) {
                    if (line.contains(keyword)) {
                        matchedLines++;
                        writer.write("Line " + totalLines + ": " + line);
                        writer.newLine();
                        break;
                    }
                }
            }

            writer.write("--- Analysis Summary ---");
            writer.newLine();
            writer.write("Total lines processed: " + totalLines);
            writer.newLine();
            writer.write("Lines containing keywords: " + matchedLines);
            writer.newLine();

        } catch (IOException e) {
            System.err.println("Error processing log file: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        LogFileAnalyzer analyzer = new LogFileAnalyzer();
        String inputFile = "input.log";
        String outputFile = "output.log";

        Set<String> keywords = new HashSet<>(Arrays.asList("ERROR", "WARNING", "EXCEPTION", "CRITICAL")); // Example keywords

        analyzer.analyzeLogFile(inputFile, outputFile, keywords);
        System.out.println("Log file analysis complete. Results written to " + outputFile);
    }
}