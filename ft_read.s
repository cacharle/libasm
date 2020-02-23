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

global _ft_read

%define F_GETFD 1
%define SYSCALL_READ 0x2000003
%define SYSCALL_FCNTL 0x200005c

; int ft_read(int, void*, size_t);
_ft_read:
	cmp rdx, 0
	je  FT_READ_NO_SIZE
	cmp rdi, 0
	jl  FT_READ_ERROR
	cmp rsi, 0
	je  FT_READ_ERROR

	push rdx
	push rsi
	xor  rsi, rsi
	mov  esi, F_GETFD
	mov  rax, SYSCALL_FCNTL 
	syscall
	pop  rsi
	pop  rdx
	cmp  eax, 0
	jne  FT_READ_ERROR

	mov rax, SYSCALL_READ
	syscall
	ret
FT_READ_ERROR:
	mov rax, -1
	ret
FT_READ_NO_SIZE:
	xor rax, rax
	ret
