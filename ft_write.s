; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:04:47 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/22 21:19:02 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

%include "libasm.s"

%ifdef __LINUX__
    %define M_FT_WRITE ft_write
    %define M_ERRNO_LOCATION __errno_location
    %define M_SYSCALL_WRITE 0x1
%else
    %define M_FT_WRITE _ft_write
    %define M_ERRNO_LOCATION ___error
    %define M_SYSCALL_WRITE 0x2000004
%endif

extern M_ERRNO_LOCATION

global M_FT_WRITE

section .text
; int ft_write(int rdi, const void *rsi, size_t rdx);
M_FT_WRITE:
    mov  rax, M_SYSCALL_WRITE
    syscall
%ifdef __LINUX__
    cmp rax, 0
    jl  FT_WRITE_ERROR
%else
    jc  FT_WRITE_ERROR
%endif
    ret
FT_WRITE_ERROR:
%ifdef __LINUX__
    neg  rax
%endif
    push rax
    call M_ERRNO_LOCATION M_EXTERN_CALL_SUFFIX
    pop  qword [rax]
    mov  rax, -1
    ret
