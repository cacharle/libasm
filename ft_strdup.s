_ft_strdup:
	pop eax
	push eax
	call _ft_strlen
	inc eax
	push eax
	call _malloc
	call _ft_strcpy
	ret


