_ft_strcmp:
	mov eax, sp
	mov ebx, sp + 8
	FT_STRCMP_LOOP:
		cmp eax, 0
		jneq FT_STRCMP_LOOP
		cmp ebx, 0
		jneq FT_STRCMP_LOOP
		cmp eax, ebx
		jeq FT_STRCMP_LOOP
	sub eax, ebx
	ret
