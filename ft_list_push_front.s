; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/11/22 20:55:08 by cacharle          #+#    #+#              ;
;    Updated: 2019/11/22 21:17:45 by cacharle         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

extern _malloc

global _ft_list_push_front

; void ft_list_push_front(t_list **begin_list, void *data);
_ft_list_push_front:
	cmp  rdi, 0
	je   FT_LIST_PUSH_FRONT_END

	push rdi
	push rsi
	xor  rdi, rdi
	mov  edi, 16
	call _malloc
	pop  rsi
	pop  rdi
	cmp  rax, 0
	je   FT_LIST_PUSH_FRONT_END

	mov  qword [rax + 0], rsi
	mov  r10, [rdi]
	mov  [rax + 8], r10
	mov  [rdi], rax
FT_LIST_PUSH_FRONT_END:
	ret
