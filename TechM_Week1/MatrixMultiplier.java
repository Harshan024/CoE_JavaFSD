package Week_1;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class MatrixMultiplier {

    public int[][] multiplyMatrices(int[][] matrixA, int[][] matrixB) {
        int rowsA = matrixA.length;
        int colsA = matrixA[0].length;
        int colsB = matrixB[0].length;

        int[][] result = new int[rowsA][colsB];

        List<Thread> threads = new ArrayList<>();

        for (int i = 0; i < rowsA; i++) {
            for (int j = 0; j < colsB; j++) {
                Thread thread = new Thread(new MatrixMultiplicationTask(matrixA, matrixB, result, i, j));
                threads.add(thread);
                thread.start();
            }
        }

        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    private static class MatrixMultiplicationTask implements Runnable {
        private final int[][] matrixA;
        private final int[][] matrixB;
        private final int[][] result;
        private final int row;
        private final int col;

        public MatrixMultiplicationTask(int[][] matrixA, int[][] matrixB, int[][] result, int row, int col) {
            this.matrixA = matrixA;
            this.matrixB = matrixB;
            this.result = result;
            this.row = row;
            this.col = col;
        }

        @Override
        public void run() {
            int colsA = matrixA[0].length;
            for (int k = 0; k < colsA; k++) {
                result[row][col] += matrixA[row][k] * matrixB[k][col];
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter rows for A: ");
        int rowsA = scanner.nextInt();
        System.out.print("Enter cols for A (rows for B): ");
        int colsA = scanner.nextInt();
        System.out.print("Enter cols for B: ");
        int colsB = scanner.nextInt();

        int[][] matrixA = new int[rowsA][colsA];
        int[][] matrixB = new int[colsA][colsB];

        System.out.println("Enter matrix A: ");
        for (int i = 0; i < rowsA; i++) {
            for (int j = 0; j < colsA; j++) {
                matrixA[i][j] = scanner.nextInt();
            }
        }

        System.out.println("Enter matrix B: ");
        for (int i = 0; i < colsA; i++) {
            for (int j = 0; j < colsB; j++) {
                matrixB[i][j] = scanner.nextInt();
            }
        }

        MatrixMultiplier multiplier = new MatrixMultiplier();
        int[][] result = multiplier.multiplyMatrices(matrixA, matrixB);

        System.out.println("Result:");
        for (int[] row : result) {
            for (int val : row) {
                System.out.print(val + " ");
            }
            System.out.println();
        }

        scanner.close();
    }
}
