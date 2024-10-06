section .data
    fmt_result db "円周率近似値: %lf", 10, 0
    fmt_error  db "計算誤差   : %lf", 10, 0
    iterations dq 100000000    ; 1億回の繰り返し
    one        dq 1.0
    two        dq 2.0
    four       dq 4.0
    pi         dq 3.14159265358979323846

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; 結果を格納するレジスタを初期化
    xorpd xmm0, xmm0          ; sum = 0
    movsd xmm1, [one]         ; sign = 1
    xorpd xmm2, xmm2          ; i = 0 (ループカウンタ)

loop_start:
    ; 現在の項を計算
    movsd xmm3, xmm2          ; i をコピー
    mulsd xmm3, [two]         ; 2 * i
    addsd xmm3, [one]         ; 2 * i + 1
    movsd xmm4, xmm1          ; sign をコピー
    divsd xmm4, xmm3          ; sign / (2 * i + 1)
    
    ; 結果に加算
    addsd xmm0, xmm4          ; sum += sign / (2 * i + 1)
    
    ; signを反転
    mulsd xmm1, [one]
    movsd xmm5, [one]
    subsd xmm5, xmm5
    subsd xmm5, [one]         ; xmm5 = -1
    mulsd xmm1, xmm5          ; sign *= -1
    
    ; ループカウンタをインクリメント
    addsd xmm2, [one]         ; i++
    
    ; ループ条件をチェック
    movsd xmm3, xmm2
    ucomisd xmm3, [iterations]
    jb loop_start             ; i < iterations なら継続

    ; 結果に4を掛ける
    mulsd xmm0, [four]

    ; 結果を表示
    mov rdi, fmt_result
    mov rax, 1
    call printf

    ; 誤差を計算して表示
    movsd xmm1, xmm0          ; 計算結果をコピー
    movsd xmm0, [pi]          ; 実際のπ
    subsd xmm0, xmm1          ; π - 計算結果
    mov rdi, fmt_error
    mov rax, 1
    call printf

    ; プログラム終了
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret