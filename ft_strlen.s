ft_strlen:
	pop bx
	mov eax, 0h
FT_STRLEN_LOOP:
	mov ecx, [ebx]
	cmp ecx, 0
	je FT_STRLEN_RET
	inc eax
	inc ebx
	jmp FT_STRLEN_LOOP
FT_STRLEN_RET:
	ret
