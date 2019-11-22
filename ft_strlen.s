.globl _ft_strlen

 _ft_strlen:
	mov rbx, rdi  # str argument
	xor rax, rax
	FT_STRLEN_LOOP:
		cmp byte ptr [rbx + rax], 0  # compare rbx[rax] and '\0'
		je FT_STRLEN_RET
		inc rax
		jmp FT_STRLEN_LOOP
 	FT_STRLEN_RET:
 		ret
