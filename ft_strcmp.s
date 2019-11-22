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

global _ft_strcmp

_ft_strcmp:
	mov rax, rdi  
	mov rbx, rsi 
	xor rcx, rcx
	FT_STRCMP_LOOP:
		cmp byte [rax + rcx], 0
		je FT_STRCMP_LOOP_END
		cmp byte [rbx + rcx], 0
		je FT_STRCMP_LOOP_END
		mov dl, byte [rax + rcx]
		cmp dl, byte [rbx + rcx]
		jne FT_STRCMP_LOOP_END
		inc rcx
		jmp FT_STRCMP_LOOP
	FT_STRCMP_LOOP_END:
		mov dl, byte [rax + rcx]
		cmp dl, byte [rbx + rcx]
		jl FT_STRCMP_S1_LOWER
		mov rdx, rax
		xor rax, rax
		mov al, [rdx + rcx]
		sub al, [rbx + rcx]
		ret
		FT_STRCMP_S1_LOWER:
		mov rdx, rax
		xor rax, rax
		mov al, [rbx + rcx]
		sub al, [rdx + rcx]
		neg eax  
	ret
