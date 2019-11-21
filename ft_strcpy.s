_ft_strcpy:
	pop ax
	pop bx
	mov ecx, eax ; copy
FT_STRCPY_LOOP:
	mov [ecx], ebx
	inc ebx
	inc ecx
	cmp ebx, 0
	jneq FT_STRCPY_LOOP
	ret
