.globl _ft_strcmp

_ft_strcmp:
	mov rax, rdi  # s1
	mov rbx, rsi  # s2
	xor rcx, rcx
	FT_STRCMP_LOOP:
		cmp byte ptr [rax + rcx], 0
		je FT_STRCMP_LOOP_END
		cmp byte ptr [rbx + rcx], 0
		je FT_STRCMP_LOOP_END
		mov dl, byte ptr [rax + rcx]
		cmp dl, byte ptr [rbx + rcx]
		jne FT_STRCMP_LOOP_END
		inc rcx
		jmp FT_STRCMP_LOOP
	FT_STRCMP_LOOP_END:
		mov dl, byte ptr [rax + rcx]
		cmp dl, byte ptr [rbx + rcx]
		jl FT_STRCMP_S1_LOWER
		# s1 >= s2
		mov rdx, rax
		xor rax, rax
		mov al, [rdx + rcx]
		sub al, [rbx + rcx]
		ret
		# s1 < s2
		FT_STRCMP_S1_LOWER:
		mov rdx, rax
		xor rax, rax
		mov al, [rbx + rcx]
		sub al, [rdx + rcx]
		not eax  # two's complement
		inc eax
	ret
