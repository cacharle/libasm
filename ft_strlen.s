; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:04:20 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/23 00:17:47 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

%ifdef __LINUX__
    %define M_FT_STRLEN ft_strlen
%else
    %define M_FT_STRLEN _ft_strlen
%endif

global M_FT_STRLEN

section .text
; int ft_strlen(char *);
M_FT_STRLEN:
    mov eax, -1
FT_STRLEN_LOOP:
    inc eax
    cmp byte [rdi + rax], 0  ; compare rbx[rax] and '\0'
    jne FT_STRLEN_LOOP
    ret
