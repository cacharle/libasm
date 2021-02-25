; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:04:32 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/23 00:19:26 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

%include "libasm.s"

%ifdef __LINUX__
    %define M_FT_STRDUP ft_strdup
    %define M_FT_STRLEN ft_strlen
    %define M_FT_STRCPY ft_strcpy
    %define M_MALLOC malloc
%else
    %define M_FT_STRDUP _ft_strdup
    %define M_FT_STRLEN _ft_strlen
    %define M_FT_STRCPY _ft_strcpy
    %define M_MALLOC _malloc
%endif

extern M_FT_STRLEN
extern M_FT_STRCPY
extern M_MALLOC

global M_FT_STRDUP

section .text
; char *ft_strdup(const char *str);
M_FT_STRDUP:
    push rdi         ; save rdi because it will be overwrite for malloc

    call M_FT_STRLEN  ; rdi is still == str
    inc  rax          ; len++ for '\0'

    mov  rdi, rax     ; size to malloc
    call M_MALLOC M_EXTERN_CALL_SUFFIX
    cmp  rax, 0
    je   FT_STRDUP_ERROR

    pop  rsi          ; original str as src
    mov  rdi, rax     ; allocated as dest
    call M_FT_STRCPY
    ret
FT_STRDUP_ERROR:
    pop  rdi
    ret
