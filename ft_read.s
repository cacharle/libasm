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

; int ft_read(int, void*, size_t);
_ft_read:
	cmp rdx, 0
	je  FT_READ_NO_SIZE
	cmp rdi, 0
	jl  FT_READ_ERROR
	cmp rsi, 0
	je  FT_READ_ERROR
	mov rax, 0x2000003
	syscall
	ret
FT_READ_ERROR:
	mov rax, -1
	ret
FT_READ_NO_SIZE:
	xor rax, rax
	ret
