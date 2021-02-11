; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:59:15 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/22 21:18:08 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;


; Only need to save reg if we use them after

; caller rules:
; 1. save caller-saved reg r10, r11
;    /!\ all param reg
; 2. pass param with regs rdi, rsi, rdx, rcx, r8, r9
;    if there is more pass them onto the stack in reverse order
; 3. use call
; 4. restore stack state by removing passed on the stack param
; 5. return value of callee in rax
; 6. restore the caller-saved register and saved passed params
; We can assume that no other register has been altered.


; callee rules:
; 1. allocate local variables by sub sum of sizes of thoses var to rsp
;    the stack grows downward so we will access those local by adding to rsp.
; 2. push callee-saved reg onto the stack: rbx, rbp, r12, r13, r14, r15.
;
; >>> function body <<<
;
; 3. place return value in rax
; 4. restore callee-saved registers
; 5. remove local var, add to the stack the previoulsy subtracted amount.
; 6. use ret

%ifdef __LINUX__
    %define M_FT_STRLEN ft_strlen
    %define M_FT_ATOI_BASE ft_atoi_base
%else
    %define M_FT_STRLEN _ft_strlen
    %define M_FT_ATOI_BASE _ft_atoi_base
%endif


extern M_FT_STRLEN

global M_FT_ATOI_BASE

section .text
; int ft_atoi_base(const char *str, const char *base);
M_FT_ATOI_BASE:
    ; ===prolog===
    ; long int nb          (8)
    ; int      radix       (4)
    ; int      is_negative (4)
    sub  rsp, 16
    mov  qword [rsp], 0x0       ; nb = 0
    mov  dword [rsp + 8], 0x0   ; radix = 0
    mov  dword [rsp + 12], 0x0  ; is_negative = 0
    push rbx
    push r11
    push r15

    ; ===body===
    ; check if the base is valid
    push rdi
    mov  rdi, rsi
    call _check_base
    pop  rdi
    cmp  eax, 0x0
    je   FT_ATOI_BASE_ERROR

    ; ignore space in front
    mov  rbx, -1                ; rbx is rdi str index
FT_ATOI_BASE_IGNORE_SPACES:
    inc  rbx
    push rdi
    mov  dil, byte [rdi + rbx]
    call _ft_isspace
    pop  rdi
    cmp  rax, 1
    je   FT_ATOI_BASE_IGNORE_SPACES

    ; ignore '+', '-' reverse the current sign
    mov  qword [rsp], 0x0       ; nb = 0
    mov  dword [rsp + 8], 0x0   ; radix = 0
    mov  dword [rsp + 12], 0x0  ; is_negative = 0
    mov  dword [rsp + 12], 0x0  ; weird behavior FIXME
    dec  rbx
    jmp  FT_ATOI_BASE_SIGN_LOOP
FT_ATOI_BASE_SIGN_LOOP_FOUND_NEG:
    not  dword [rsp + 12]
FT_ATOI_BASE_SIGN_LOOP:
    inc  rbx
    cmp  byte [rdi + rbx], 0x2b  ; if '+'
    je   FT_ATOI_BASE_SIGN_LOOP
    cmp  byte [rdi + rbx], 0x2d  ; if '-'
    je   FT_ATOI_BASE_SIGN_LOOP_FOUND_NEG

    ; base radix
    push rdi
    mov  rdi, rsi
    call M_FT_STRLEN
    pop  rdi
    mov  dword [rsp + 8], eax

    ; main loop
FT_ATOI_BASE_LOOP:
    push rdi
    push rsi
    mov  dil, byte [rdi + rbx]
    call _base_pos                ; get value of the current char int the base
    pop  rsi
    pop  rdi
    cmp  rax, -1                  ; if is not in base break
    je   FT_ATOI_BASE_LOOP_END

    mov  r11, [rsp]               ; place nb in register for multiplication
    xor  r15, r15                 ; same for radix
    mov  r15d,  dword [rsp + 8]
    imul r11, r15                 ; multiply by the radix
    mov  [rsp], r11               ; store multiplication result
    add  [rsp], rax               ; add the current value

    inc  rbx
    jmp  FT_ATOI_BASE_LOOP
FT_ATOI_BASE_LOOP_END:

    cmp  dword [rsp + 12], 0
    je   FT_ATOI_BASE_END
    neg  qword [rsp]

    ; ===epilog===
FT_ATOI_BASE_END:
    mov  rax, [rsp]
    pop  r15
    pop  r11
    pop  rbx
    add  rsp, 16
    ret
FT_ATOI_BASE_ERROR:
    mov  rax, 0x0
    pop  r15
    pop  r11
    pop  rbx
    add  rsp, 16
    ret

; dil: char searched
; rsi: char *base
_base_pos:
    mov  rax, -1
BASE_POS_LOOP:
    inc  rax
    cmp  byte [rsi + rax], 0    ; if '\0' char not in base
    je   BASE_POS_NOT_FOUND
    cmp  dil, byte [rsi + rax]  ; loop until '\0' or found
    jne  BASE_POS_LOOP
    ret
BASE_POS_NOT_FOUND:
    mov  rax, -1
    ret


; rdi: char *base
_check_base:
    sub  rsp, 4
    mov  dword [rsp], 0
; check for empty or size 1 base
    push rdi
    call M_FT_STRLEN
    pop  rdi
    cmp  rax, 2
    jl   CHECK_BASE_FALSE

    ; xor  rcx, rcx
CHECK_BASE_LOOP:
    cmp  byte [rdi], 0
    je   CHECK_BASE_LOOP_END
    cmp  byte [rdi], 0x2b  ; check '+'
    je   CHECK_BASE_FALSE
    cmp  byte [rdi], 0x2d  ; check '-'
    je   CHECK_BASE_FALSE

; check for spaces
    push rdi
    mov  dil, [rdi] ; pass current char as argument
    call _ft_isspace
    pop  rdi
    cmp  rax, 1
    je   CHECK_BASE_FALSE

; check for duplicates in base
    xor  rcx, rcx                    ; index from curr +1
CHECK_BASE_DUP_LOOP:
    inc  rcx
    mov  r10b, byte [rdi]  ; r10b = checked char
    cmp  r10b, byte [rdi + rcx]  ; check if found dup
    je   CHECK_BASE_FALSE
    cmp  byte [rdi + rcx], 0     ; if \0 end dup check
    jne  CHECK_BASE_DUP_LOOP

    inc  rdi
    jmp  CHECK_BASE_LOOP
CHECK_BASE_LOOP_END:

    add  rsp, 4
    mov  rax, 1
    ret
CHECK_BASE_FALSE:
    add  rsp, 4
    xor  rax, rax
    ret


; dil: char c
_ft_isspace:
    cmp  dil, 0x20
    je   ISSPACE_TRUE
    sub  dil, 0x9
    cmp  dil, 0x5
    jl   ISSPACE_TRUE
    xor  rax, rax
    ret
ISSPACE_TRUE:
    mov  rax, 0x1
    ret
