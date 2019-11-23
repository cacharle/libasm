; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2019/11/22 03:59:15 by cacharle          ;+;    ;+;              ;
;    Updated: 2019/11/22 21:18:08 by cacharle         ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

extern _ft_strlen

global _ft_atoi_base

; int ft_atoi_base(const char *str, const char *base);
_ft_atoi_base:
	mov r12, rdi  ; r12 = str
	mov r13, rsi  ; r13 = base

	; check if the base is valid
	mov rdi, r13
	call _check_base
	cmp rax, 0
	je CHECK_BASE_FALSE


	; ignore space in front
	mov r15, -1  ; str index
	FT_ATOI_BASE_IGNORE_SPACES:
		inc r15
		mov dil, byte [r12 + r15]
		call _ft_isspace
		cmp rax, 1
		je FT_ATOI_BASE_IGNORE_SPACES


	; cmp byte [r12 + r15], 0x2d
	; mov r11, zf ; r11 = is negative

	mov rdi, r13
	call _ft_strlen
	mov r14, rax  ; r14 = radix

	xor rcx, rcx  ; return value
	FT_ATOI_BASE_LOOP:
		mov sil, [r12 + r15]
		call _base_pos  ; get value of the current char int the base
		cmp rax, -1     ; if is not in base break
		je FT_ATOI_BASE_LOOP_END

		imul rcx, r14   ; multiply by the radix
		add rcx, rax    ; add the current value
		inc r15
		jmp FT_ATOI_BASE_LOOP
	FT_ATOI_BASE_LOOP_END:
	mov rax, rcx
	ret


; rdi: char *base
; sil: char searched
_base_pos:
	mov rax, -1
	BASE_POS_LOOP:
		inc rax
		cmp byte [rdi + rax], 0    ; if '\0' char not in base
		je BASE_POS_NOT_FOUND
		cmp sil, byte [rdi + rax]  ; loop until '\0' or found
		jne BASE_POS_LOOP
	ret
	BASE_POS_NOT_FOUND:
		mov rax, -1
		ret


; rdi: char *base
_check_base:
	; check for empty or size 1 base
	push rdi
	call _ft_strlen
	pop rdi
	cmp rax, 2
	jl CHECK_BASE_FALSE

	xor rcx, rcx                    ; rcx = index
	CHECK_BASE_LOOP:
		cmp byte [rdi + rcx], 0
		je CHECK_BASE_LOOP_END
		cmp byte [rdi + rcx], 0x2b  ; check '+'
		je CHECK_BASE_FALSE
		cmp byte [rdi + rcx], 0x2d  ; check '-'
		je CHECK_BASE_FALSE

		push rdi               ; save base
		mov dil, [rdi + rcx]   ; pass current char as argument
		call _ft_isspace
		pop rdi                ; recover base
		cmp rax, 1
		je CHECK_BASE_FALSE    ; check for spaces

		; check for duplicates in base
		mov rdx, rcx                                ; index from curr +1
		CHECK_BASE_DUP_LOOP:
			inc rdx
			mov r10b, byte [rdi + rcx]  ; r10b = checked char
			cmp r10b, byte [rdi + rdx]  ; check if found dup
			je CHECK_BASE_FALSE
			cmp byte [rdi + rdx], 0                 ; if \0 end dup check
			jne CHECK_BASE_DUP_LOOP

		inc rcx
		jmp CHECK_BASE_LOOP
	CHECK_BASE_LOOP_END:

	mov rax, 1
	ret
	CHECK_BASE_FALSE:
		xor rax, rax
		ret


; dil: char c
_ft_isspace:
	cmp dil, 20h  ; if space jump next
	je ISSPACE_TRUE_END
	sub dil, 9h
	cmp dil, 5h
	jl ISSPACE_TRUE_END
	xor rax, rax
	ret
	ISSPACE_TRUE_END:
		mov rax, 1
		ret
