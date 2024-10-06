#!/bin/bash

# 定数定義
ITERATIONS=100000000  # 1億回 （警告：非常に時間がかかります）
SAMPLE_SIZE=100000000      # サンプリングサイズ（実際の計算回数を減らすため）

# 色の定義
GREEN='\033[0;32m'
NC='\033[0m'

# sinの近似計算関数（テイラー級数使用）
# 引数: ラジアン
sin_approx() {
    local x=$1
    local result
    
    # xを-πからπの範囲に正規化
    x=$(bc -l <<< "$x % (2 * 3.14159265359)")
    if (( $(bc -l <<< "$x > 3.14159265359") )); then
        x=$(bc -l <<< "$x - 2 * 3.14159265359")
    elif (( $(bc -l <<< "$x < -3.14159265359") )); then
        x=$(bc -l <<< "$x + 2 * 3.14159265359")
    fi
    
    # テイラー級数: sin(x) ≈ x - x³/6 + x⁵/120
    result=$(bc -l <<< "$x - ($x^3/6) + ($x^5/120)")
    echo "$result"
}

# cosの近似計算関数（sinを使用）
# 引数: ラジアン
cos_approx() {
    local x=$1
    local pi_half=1.57079632679
    local result
    
    # cos(x) = sin(x + π/2)
    result=$(sin_approx $(bc -l <<< "$x + $pi_half"))
    echo "$result"
}

# メイン処理
main() {
    local sum=0
    local start_time end_time
    
    echo "計算回数: $ITERATIONS (サンプリング: $SAMPLE_SIZE)"
    
    # 開始時間を記録
    start_time=$(date +%s.%N)
    
    # サンプリングを使用してループ
    for ((i=0; i<SAMPLE_SIZE; i++)); do
        x=$(bc -l <<< "scale=10; $i * ($ITERATIONS / $SAMPLE_SIZE)")
        sin_val=$(sin_approx "$x")
        cos_val=$(cos_approx "$x")
        product=$(bc -l <<< "$sin_val * $cos_val")
        sum=$(bc -l <<< "$sum + $product")
    done
    
    # 結果をスケーリング
    sum=$(bc -l <<< "$sum * ($ITERATIONS / $SAMPLE_SIZE)")
    
    # 終了時間を記録し、経過時間を計算
    end_time=$(date +%s.%N)
    duration=$(bc -l <<< "$end_time - $start_time")
    
    # 結果表示
    printf "計算結果: %.10f\n" "$sum"
    printf "実行時間: %.6f秒\n" "$duration"
    
    echo -e "${GREEN}注意: この結果はサンプリングに基づく概算値です${NC}"
}

# プログラム実行
main