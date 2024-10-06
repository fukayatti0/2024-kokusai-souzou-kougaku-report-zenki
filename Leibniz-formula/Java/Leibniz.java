import java.time.Duration;
import java.time.Instant;

public class Leibniz {

    // ライプニッツ公式計算
    public static double calculateLeibniz(int n) {
        double piApprox = 0.0;
        double sign = 1.0;
        for (int i = 0; i < n; i++) {
            piApprox += sign / (2.0 * i + 1.0);
            sign = -sign;
        }
        piApprox *= 4.0;
        return piApprox;
    }
    
    public static void main(String[] args) {
        // 計算する項数(1億回)
        final int n = 100000000;
        // 計測開始時間
        Instant startTime = Instant.now();

        // ライプニッツ公式計算
        final double piApprox = Leibniz.calculateLeibniz(n);

        // 誤差
        final double calculationError = Math.abs(Math.PI - piApprox);
        // 計測終了時間
        Instant endTime = Instant.now();
        // 計算時間
        Duration elapsed = Duration.between(startTime, endTime);

        System.out.println("円周率近似値  : " + piApprox);
        System.out.println("計算誤差      : " + calculationError);
        System.out.println("経過時間[msec]: " + elapsed.toMillis());
    }
}