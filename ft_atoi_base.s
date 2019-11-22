# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_atoi_base.s                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 03:59:15 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 21:18:08 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.globl _ft_atoi_base
.globl _check_base

# int ft_atoi_base(const char*, const char*);
_ft_atoi_base:
	push rbp      # save previous stackframe
	mov rbp, rsp  # create new one

	mov rbx, rdi  # rbx = str
	mov rcx, rsi  # rcx = base

	mov rdi, rcx
	call _check_base
	cmp rax, 0
	je CHECK_BASE_ERROR

	mov rdi, rcx
	call _ft_strlen 
	#mov r8, rax  # r8 = radix
	#mov rax, r8

	xor rdx, rdx  # rdx = 0
	FT_ATOI_BASE_SPACE_LOOP:  # remove spaces
		mov rdi, [rbx]
		call ft_isspace
		cmp rax, 1
		jne FT_ATOI_BASE_SPACE_LOOP_END
		inc rbx
		jmp FT_ATOI_BASE_SPACE_LOOP
	FT_ATOI_BASE_SPACE_LOOP_END:

	xor rax, rax  # rax = 0
	xor rdx, rdx  # rdx = 0
	FT_ATOI_BASE_LOOP:
		cmp byte ptr [rbx], 30h # while isdigit
		jl FT_ATOI_BASE_END     # if *rbx < '0' jmp end
		cmp byte ptr [rbx], 39h
		ja FT_ATOI_BASE_END     # if *rbx > '9' jmp end

		imul eax, 10            # eax *= 10, shift previous digits
		mov dl, byte ptr [rbx]
		and dl, 0x0F            # char to digit
		add eax, edx            # insert as first digit
		inc rbx
		jmp FT_ATOI_BASE_LOOP
	FT_ATOI_BASE_END:
	pop rbp
	ret
		
_base_pos:
	mov rcx, rsi
	xor rax, rax
	BASE_POS_LOOP:
		cmp byte ptr [rdi + rax], 0
		je BASE_POS_NOT_FOUND
		cmp cl, byte ptr [rdi + rax]
		je BASE_POS_FOUND
		inc eax
		jmp BASE_POS_LOOP
	BASE_POS_NOT_FOUND:
		mov eax, 0xFFFFFFFF
	BASE_POS_FOUND:
		ret

_check_base:
	push rbx
	mov rbx, rsp

	mov rbx, rdi  # rbx = str

	call _ft_strlen  # f strlen(rbx) < 2
	cmp eax, 2
	jl CHECK_BASE_ERROR

	CHECK_BASE_LOOP:
		cmp byte ptr [rbx], 2bh  #  *rbx == '-' || *rbx == '+'
		je CHECK_BASE_ERROR
		cmp byte ptr [rbx], 2dh
		je CHECK_BASE_ERROR
		call ft_isspace
		cmp rax, 1
		je CHECK_BASE_ERROR
			
		inc rbx
		cmp byte ptr [rbx], 0h
		jne CHECK_BASE_LOOP
	mov rax, 1
	pop rbx
	ret
	CHECK_BASE_ERROR:
		xor rax, rax
		pop rbx
		ret

ft_isspace:
	cmp byte ptr [rdi], 20h  # if space jump next
	je ISSPACE_TRUE_END
	mov dl, byte ptr [rdi]  # if \t\n\r\v\f jump next
	sub dl, 9h
	cmp dl, 5h
	jl ISSPACE_TRUE_END
	xor rax, rax
	ret
	ISSPACE_TRUE_END:
		mov rax, 1
		ret
