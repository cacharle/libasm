; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:04:44 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/22 21:19:13 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

%ifdef __LINUX__
    %define M_FT_READ ft_read
    %define M_ERRNO_LOCATION __errno_location  wrt ..plt
    %define M_SYSCALL_READ 0x0
%else
    %define M_FT_READ _ft_read
    %define M_ERRNO_LOCATION ___error
    %define M_SYSCALL_READ 0x2000003
%endif

extern M_ERRNO_LOCATION

global M_FT_READ

section .text
; int ft_read(int, void*, size_t);
M_FT_READ:
    mov  rax, M_SYSCALL_READ
    syscall
%ifdef __LINUX__
    cmp  rax, 0
    jl   FT_READ_ERROR
%else
    jc   FT_READ_ERROR
%endif
    ret
FT_READ_ERROR:
%ifdef __LINUX__
    neg  rax
%endif
    push rax
    call M_ERRNO_LOCATION
    pop  qword [rax]
    mov  rax, -1
    ret
