; x86-64 Linux pure assembly implementation
section .data
    iterations dq 100000000    ; 1億回
    msg_count db "計算回数: "
    msg_result db 10, "計算結果: "
    ten dq 10.0
    buffer times 32 db 0

section .bss
    result resq 1              ; 結果用8バイト

section .text
    global _start

_start:
    ; 計算回数表示
    mov rdi, msg_count
    call print_string
    mov rax, [iterations]
    call print_int
    
    ; メインの計算ループ
    xor rcx, rcx               ; カウンタを0に初期化
    pxor xmm0, xmm0            ; 結果を0に初期化
    
.loop:
    ; 現在のカウンタ値をdoubleに変換
    cvtsi2sd xmm1, rcx
    
    ; sin(x)の近似計算
    movsd xmm2, xmm1
    call approx_sin
    movsd xmm3, xmm0           ; sin結果を保存
    
    ; cos(x)の近似計算 (cos(x) = sin(x + π/2))
    movsd xmm2, xmm1
    addsd xmm2, [pi_half]
    call approx_sin
    mulsd xmm0, xmm3           ; sin(x) * cos(x)
    
    ; 結果を加算
    addsd xmm0, [result]
    movsd [result], xmm0
    
    inc rcx
    cmp rcx, [iterations]
    jl .loop
    
    ; 結果表示
    mov rdi, msg_result
    call print_string
    movsd xmm0, [result]
    call print_double
    
    ; プログラム終了
    mov rax, 60                ; sys_exit
    xor rdi, rdi               ; status = 0
    syscall

; 関数: sin(x)の近似計算
; 入力: xmm2 = x
; 出力: xmm0 = sin(x)の近似値
approx_sin:
    movsd xmm0, xmm2           ; x
    movsd xmm1, xmm2
    mulsd xmm1, xmm1           ; x^2
    
    ; Taylor級数の項を計算: x - x^3/6 + x^5/120 - x^7/5040
    movsd xmm3, xmm1           ; x^2
    mulsd xmm3, xmm0           ; x^3
    divsd xmm3, [six]          ; x^3/6
    subsd xmm0, xmm3           ; x - x^3/6
    
    movsd xmm3, xmm1           ; x^2
    mulsd xmm3, xmm1           ; x^4
    mulsd xmm3, xmm2           ; x^5
    divsd xmm3, [f120]         ; x^5/120
    addsd xmm0, xmm3           ; + x^5/120
    
    movsd xmm3, xmm1           ; x^2
    mulsd xmm3, xmm1           ; x^4
    mulsd xmm3, xmm1           ; x^6
    mulsd xmm3, xmm2           ; x^7
    divsd xmm3, [f5040]        ; x^7/5040
    subsd xmm0, xmm3           ; - x^7/5040
    
    ret

; 関数: 文字列表示
; 入力: rdi = 文字列アドレス
print_string:
    push rax
    push rdi
    mov rdx, rdi               ; アドレスをrdxにコピー
    .count:
        cmp byte [rdx], 0      ; null終端を探す
        je .print
        inc rdx
        jmp .count
    .print:
        sub rdx, rdi           ; 長さ計算
        mov rsi, rdi           ; 文字列アドレス
        mov rax, 1             ; sys_write
        mov rdi, 1             ; stdout
        syscall
    pop rdi
    pop rax
    ret

; 関数: 整数表示
; 入力: rax = 整数値
print_int:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rcx, 30               ; バッファの終端から開始
    
    .loop:
        xor rdx, rdx
        mov rbx, 10
        div rbx               ; rax ÷ 10, 余りはrdxに
        add dl, '0'           ; 数字を文字に変換
        mov [buffer + rcx], dl
        dec rcx
        test rax, rax
        jnz .loop
    
    inc rcx
    lea rdi, [buffer + rcx]
    call print_string
    
    leave
    ret

; 関数: 浮動小数点数表示
; 入力: xmm0 = 浮動小数点数
print_double:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    ; 整数部分を取得
    cvttsd2si rax, xmm0
    call print_int
    
    ; 小数点を表示
    mov byte [buffer], '.'
    mov rdi, buffer
    mov byte [buffer + 1], 0
    call print_string
    
    ; 小数部分を取得して表示
    cvttsd2si rax, xmm0
    cvtsi2sd xmm1, rax
    subsd xmm0, xmm1          ; 小数部分のみ取得
    
    ; 小数部分を6桁表示
    mov rcx, 6
    .decimal_loop:
        mulsd xmm0, [ten]
        cvttsd2si rax, xmm0
        push rax
        cvtsi2sd xmm1, rax
        subsd xmm0, xmm1
        dec rcx
        jnz .decimal_loop
    
    mov rcx, 6
    .print_loop:
        pop rax
        add al, '0'
        mov [buffer], al
        mov byte [buffer + 1], 0
        mov rdi, buffer
        push rcx
        call print_string
        pop rcx
        dec rcx
        jnz .print_loop
    
    leave
    ret

section .data
    pi_half dq 1.5707963267948966  ; π/2
    six dq 6.0
    f120 dq 120.0
    f5040 dq 5040.0
    clock_speed dq 3000000000.0    ; 3GHz想定