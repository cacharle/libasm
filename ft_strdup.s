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

extern _ft_strlen
extern _ft_strcpy
extern _malloc

global _ft_strdup

; char *ft_strdup(const char *str);
_ft_strdup:
	push rdi         ; save rdi because it will be overwrite for malloc

	call _ft_strlen  ; rdi is still == str
	inc rax          ; len++ for '\0'

	mov rdi, rax     ; size to malloc
	call _malloc

	pop rsi          ; original str as src
	mov rdi, rax     ; allocated as dest
	call _ft_strcpy
	ret


