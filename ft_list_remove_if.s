; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if.s                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/11/25 04:23:22 by cacharle          #+#    #+#              ;
;    Updated: 2019/11/25 04:23:22 by cacharle         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

global _ft_list_remove_if

; ft_list_remove_if(t_list **begin_list, void *data_ref,
;                   int (*cmp)(), void (*free_fct)(void *))

_ft_list_remove_if:
	sub  rsp, 8

	cmp  rdi, 0x0
	je   FT_LIST_REMOVE_IF_END
	cmp  [rdi], 0x0
	je   FT_LIST_REMOVE_IF_END

	push rdi
	mov  rdi, [rdi] + 8 ;&(*begin_list)->val
	call rdx
	pop  rdi
	cmp  rax, 0x0
	je   FT_LIST_REMOVE_IF_REMOVE


	mov  rdi, [rdi] + 8
	call _ft_list_remove_if
	add  rsp, 8
	ret

FT_LIST_REMOVE_IF_REMOVE:
	mov [rsp], [rdi] + 8  ; saved_next = (*begin_list)->next

	push rdi
	mov  rdi, [[rdi]]
	call rcx              ; free_fct((*begin_list)->data)
	pop  rdi

	push rdi
	mov  rdi, [rdi]
	call _free            ; free(*begin_list)
	pop  rdi

	mov  [rdi], [rsp]     ; *begin_list = saved_next

	call _ft_list_remove_if

FT_LIST_REMOVE_IF_END:
	add  rsp, 8
	ret
