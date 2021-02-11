; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/23 00:17:19 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/23 00:17:19 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;


%ifdef __LINUX__
    %define M_FT_STRCMP ft_strcmp
%else
    %define M_FT_STRCMP _ft_strcmp
%endif

global M_FT_STRCMP

section .text
; int ft_strcmp(const char *s1, const char *s2);
M_FT_STRCMP:
    push r12
    push r13
    push rcx
    mov  r12, rdi  ; s1
    mov  r13, rsi  ; s2
    mov  rcx, -1   ; index
FT_STRCMP_LOOP:
    inc  rcx
    cmp  byte [r12 + rcx], 0   ; check and of s1
    je   FT_STRCMP_LOOP_END
    mov  dl, byte [r12 + rcx]
    cmp  dl, byte [r13 + rcx]  ; s1[rcx] == s2[rcx]
    je   FT_STRCMP_LOOP
FT_STRCMP_LOOP_END:

    xor  rax, rax
    mov  al, byte [r12 + rcx]
    sub  al, byte [r13 + rcx]
    jnc  FT_STRCMP_END  ; jump end if no substraction overflow

    neg  al   ; negate al to cancel overflow
    neg  eax  ; negate the whole int since the function returns that type

FT_STRCMP_END:
    pop  rcx
    pop  r13
    pop  r12
    ret
