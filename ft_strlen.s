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

global _ft_strlen

; int ft_strlen(char *);
_ft_strlen:
	mov eax, -1
	FT_STRLEN_LOOP:
		inc eax
		cmp byte [rdi + rax], 0  ; compare rbx[rax] and '\0'
		jne FT_STRLEN_LOOP
	ret
