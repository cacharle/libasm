; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:04:28 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/22 21:18:38 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

%ifdef __LINUX__
    %define M_FT_STRCPY ft_strcpy
%else
    %define M_FT_STRCPY _ft_strcpy
%endif

global M_FT_STRCPY

section .text
; char *ft_strcpy(char *dst, const char *src);
M_FT_STRCPY:
    push rbx
    push rcx
    mov  rax, rdi  ; dst
    mov  rbx, rsi  ; src
    mov  rcx, -1
FT_STRCPY_LOOP:
    inc  rcx
    mov  dl, byte [rbx + rcx]
    mov  byte [rax + rcx], dl
    cmp  byte [rbx + rcx], 0
    jne  FT_STRCPY_LOOP
    pop  rcx
    pop  rbx
    ret
