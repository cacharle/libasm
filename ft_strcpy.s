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

global _ft_strcpy

; char *ft_strcpy(char *dst, const char *src);
_ft_strcpy:
	push rbx
	push rcx
	mov rax, rdi  ; dst
	mov rbx, rsi  ; src
	mov rcx, -1
	FT_STRCPY_LOOP:
		inc rcx
		mov dl, byte [rbx + rcx]
		mov byte [rax + rcx], dl
		cmp byte [rbx + rcx], 0
		jne FT_STRCPY_LOOP
	pop rcx
	pop rbx
	ret
