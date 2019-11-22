.globl _ft_strcpy

_ft_strcpy:
	mov rax, rdi  # dst
	mov rbx, rsi  # src
	xor rcx, rcx
	FT_STRCPY_LOOP:
		mov dl, [rbx + rcx]
		mov [rax + rcx], dl
		inc rcx
		cmp byte ptr [rbx + rcx], 0
		jne FT_STRCPY_LOOP
	ret
