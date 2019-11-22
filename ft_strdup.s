# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strdup.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 03:04:32 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 03:16:37 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.globl _ft_strdup

_ft_strdup:
	push rbp
	mov rbp, rsp
	mov rbx, rdi
	mov rax, rbx
	call _ft_strlen
	inc rax
	mov rdi, rax
	call _malloc
	mov rdi, rax
	mov rsi, rbx
	call _ft_strcpy
	pop rbp
	ret


