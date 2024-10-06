import math

def main():
    # 計算回数
    ITERATIONS = 100000000  # 1億回の繰り返し

    print(f"計算回数: {ITERATIONS:,}")
    
    # 時間のかかる処理
    result = 0.0
    for i in range(ITERATIONS):
        result += math.sin(i) * math.cos(i)
    
    print(f"計算結果: {result}")

if __name__ == "__main__":
    main()