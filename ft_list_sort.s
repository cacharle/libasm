; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/11/22 21:03:52 by cacharle          #+#    #+#              ;
;    Updated: 2019/11/22 21:27:27 by cacharle         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

global _ft_list_sort

; void ft_list_sort(t_list **begin_list, int (*cmp)());
_ft_list_sort:
	; t_list *fast
	; t_list *slow
	; t_list *middle
	sub  rsp, 24

	cmp  rdi, 0x0
	je   FT_LIST_SORT_END
	cmp  [rdi], 0x0
	je   FT_LIST_SORT_END
	cmp  [[rdi] + 8], 0x0  ; use tmp register
	je   FT_LIST_SORT_END

	mov  [rsp], [[rdi] + 8]
	mov  [rsp + 8], [rdi]
FT_GET_MIDDLE_LOOP: 
	mov  [rsp], [rsp + 8]
	cmp  [rsp], 0x0
	je   FT_GET_MIDDLE_LOOP_END
	mov  [rsp], [rsp + 8]
	mov  [rsp + 8], [[rsp + 8] + 8] ; i want c pointers back plz
FT_GET_MIDDLE_LOOP_END:
	mov  [rsp + 16], [[rsp + 8] + 8]
	mov  [[rsp + 8] + 8], 0x0

	push rdi
	call _ft_list_sort
	pop  rdi

	push rdi
	mov  rdi, [rsp + 16]
	call _ft_list_sort
	pop  rdi

	push rdi
	push rsi
	mov  rdx, rsi
	mov  rdi, [rdi]
	mov  rsi, [rsp + 16]
	call _merge_sorted_list
	pop  rsi
	pop  rdi

	mov  [rdi], rax

	add rsp, 24
FT_LIST_SORT_END:
	ret



; t_list *merge_sorted_list(t_list* l1, t_list* l2, int (*cmp)())
_merge_sorted_list:
	sub  rsp, 8

	cmp  rdi, 0x0
	je   MERGE_SORTED_LIST_RETURN_L2
	cmp  rsi, 0x0
	je   MERGE_SORTED_LIST_RETURN_L1

	push rdi
	push rsi
	mov  rdi, [rdi]
	mov  rsi, [rsi]
	call rdx        ; cmp
	pop  rsi
	pop  rdi

	cmp  rax, 0x0
	jl   L1_LT_L2

; L1_GE_L2
	mov  rsp, rsi
	push rdi
	push rsi
	mov  rdi, [rdi + 8]
	call _merge_sorted_list
	pop  rsi
	pop  rdi
	mov  [rsp + 8], rax
	jmp  MERGE_SORTED_LIST_END

L1_LT_L2:
	mov  rsp, rdi
	push rdi
	push rsi
	mov  rsi, [rsi + 8]
	call _merge_sorted_list
	pop  rsi
	pop  rdi
	mov  [rsp + 8], rax

MERGE_SORTED_LIST_END:
	mov  rax, [rsp]
	add  rsp, 8
	ret
MERGE_SORTED_LIST_RETURN_L1:
	mov  rax, rdi
	ret
MERGE_SORTED_LIST_RETURN_L2:
	mov  rax, rsi
	ret
