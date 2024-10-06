public class Trigonometricfunctions {
    public static void main(String[] args) {
        final int iterations = 100_000_000;
        System.out.printf("計算回数: %,d%n", iterations);

        double result = 0.0;
        for (int i = 0; i < iterations; i++) {
            result += Math.sin(i) * Math.cos(i);
        }

        System.out.println("計算結果: " + result);
    }
}