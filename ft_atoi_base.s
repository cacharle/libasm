# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_atoi_base.s                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 03:59:15 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 05:20:12 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.globl _ft_atoi_base

_ft_atoi_base:
	mov rbx, rdi  # rbx = str
	mov rcx, rsi  # rcx = base

	xor rdx, rdx  # rdx = 0

	# remove spaces
	FT_ATOI_BASE_SPACE_LOOP:
		cmp byte ptr [rbx], 20h  # if space jump next
		je NEXT

		mov dl, byte ptr [rbx]  # if \t\n\r\v\f jump next
		sub dl, 9h
		cmp dl, 5h
		jl NEXT

		jmp FT_ATOI_BASE_SPACE_LOOP_END  # if all above false end loop
		NEXT:  # next iteration
			inc rbx
			jmp FT_ATOI_BASE_SPACE_LOOP
	FT_ATOI_BASE_SPACE_LOOP_END:

	xor rax, rax  # rax = 0
	xor rdx, rdx  # rdx = 0

	FT_ATOI_BASE_LOOP:
		# while isdigit
		cmp byte ptr [rbx], 30h
		jl FT_ATOI_BASE_END  # if *rbx < '0' jmp end
		cmp byte ptr [rbx], 39h
		ja FT_ATOI_BASE_END  # if *rbx > '9' jmp end

		imul eax, 10  # eax *= 10
		# dl = *str & 0x0F
		mov dl, byte ptr [rbx]
		and dl, 0x0F
		add eax, edx  # eax += dl (digit)
		inc rbx  # next char
		jmp FT_ATOI_BASE_LOOP

	FT_ATOI_BASE_END:
		ret
		

