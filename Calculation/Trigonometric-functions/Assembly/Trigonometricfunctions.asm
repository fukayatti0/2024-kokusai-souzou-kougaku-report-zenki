default rel

section .data
    iterations dq 100000000    ; 1億回
    fmt_result db "計算結果: %f", 10, 0
    fmt_time db "実行時間: %.3f秒", 10, 0
    fmt_count db "計算回数: %ld", 10, 0
    clock_speed dq 3000000000.0 ; プロセッサのクロック周波数（3GHz と仮定）

section .bss
    result resq 1              ; 結果を格納する8バイト
    start_time resq 1          ; 開始時間用
    temp_double resq 1         ; 一時的な浮動小数点数用

section .text
    global main
    extern printf
    extern sin
    extern cos

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32               ; スタックフレームの確保（16バイトアライメント）
    
    ; 計算回数を表示
    lea rdi, [fmt_count]
    mov rsi, [iterations]
    xor eax, eax
    call printf
    
    ; 開始時間を取得
    rdtsc
    shl rdx, 32
    or rdx, rax
    mov [start_time], rdx
    
    ; メインの計算ループ
    xor ecx, ecx              ; カウンタを0に初期化
    pxor xmm2, xmm2           ; 結果を0に初期化
    
.loop:
    ; i をdoubleに変換
    pxor xmm0, xmm0
    cvtsi2sd xmm0, rcx
    
    ; スタックを調整してアライメント
    push rcx                  ; カウンタを保存
    sub rsp, 8                ; 16バイトアラインメント用
    
    ; sin(i)を計算
    call sin WRT ..plt        ; PLTを介して関数を呼び出し
    movsd xmm1, xmm0          ; sin結果をxmm1に保存
    
    ; cos(i)を計算
    cvtsi2sd xmm0, qword [rsp+8] ; カウンタを再度ロード
    call cos WRT ..plt        ; PLTを介して関数を呼び出し
    
    ; スタックを戻す
    add rsp, 8
    pop rcx
    
    ; sin(i) * cos(i)を計算し、合計に加算
    mulsd xmm0, xmm1
    addsd xmm2, xmm0
    
    inc ecx
    cmp ecx, dword [iterations]
    jl .loop
    
    ; 結果を保存
    movsd [result], xmm2
    
    ; 終了時間を取得し、経過時間を計算
    rdtsc
    shl rdx, 32
    or rdx, rax
    sub rdx, qword [start_time]
    
    ; 結果を表示
    lea rdi, [fmt_result]
    movsd xmm0, [result]
    mov eax, 1
    call printf
    
    ; 経過時間を表示
    pxor xmm0, xmm0
    cvtsi2sd xmm0, rdx
    divsd xmm0, [clock_speed]
    lea rdi, [fmt_time]
    mov eax, 1
    call printf
    
    ; 終了処理
    xor eax, eax
    leave
    ret