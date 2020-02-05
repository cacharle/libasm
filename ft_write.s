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

global _ft_write

; int ft_write(int rdi, const void *rsi, size_t rdx);
_ft_write:
	cmp rdx, 0
	je  FT_WRITE_NO_SIZE
	cmp rdi, 0
	jl  FT_WRITE_ERROR
	cmp rsi, 0
	je  FT_WRITE_ERROR
	mov rax, 0x2000004
	syscall
	ret
FT_WRITE_ERROR:
	mov rax, -1
	ret
FT_WRITE_NO_SIZE:
	mov rax, 0
	ret
