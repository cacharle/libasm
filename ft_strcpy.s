# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcpy.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 03:04:28 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 03:16:19 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

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
	mov byte ptr [rax + rcx], 0
	ret
