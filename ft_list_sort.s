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

%ifdef __LINUX__
    %define M_FT_LIST_SORT ft_list_sort
%else
    %define M_FT_LIST_SORT _ft_list_sort
%endif

global M_FT_LIST_SORT

%define NULL 0x0

; void ft_list_sort(t_list **begin_list, int (*cmp)(void*, void*));
M_FT_LIST_SORT:
	; t_list *slow   : rax = *begin_list
	; t_list *fast   : rbx = (*begin_list)->next
	; t_list *middle : rsp + 0

	; === base condition ===
	cmp  rdi, NULL
	je   FT_LIST_SORT_END              ; if begin_list == NULL return
	mov  rax, [rdi]
	cmp  rax, NULL
	je   FT_LIST_SORT_END              ; if *begin_list == NULL return
	mov  rbx, [rax + 8]
	cmp  rbx, NULL
	je   FT_LIST_SORT_END              ; if (*begin_list)->next == NULL return

	; === find list middle loop ===
FT_LIST_SORT_MIDDLE_LOOP:              ; do {
	mov  rbx, [rbx + 8]                ;     fast = fast->next
	cmp  rbx, NULL
	je   FT_LIST_SORT_MIDDLE_LOOP_END  ;     if fast == NULL break
	mov  rbx, [rbx + 8]                ;     fast = fast->next
	mov  rax, [rax + 8]                ;     slow = slow->next
	cmp  rbx, NULL
	jne  FT_LIST_SORT_MIDDLE_LOOP      ; } while (fast != NULL)
FT_LIST_SORT_MIDDLE_LOOP_END:

	; create a stack frame for local variable to store middle address
	push rbp
	mov  rbp, rsp
	sub  rsp, 8

	; store middle in [rbp - 8]
	mov  rcx, [rax + 8]
	mov  [rbp - 8], rcx
	mov  qword [rax + 8], NULL         ; slow->next = NULL

	; === sorting both child list ===
	push rdi
	push rsi
	call M_FT_LIST_SORT                 ; ft_list_sort(begin_list, cmp)
	lea  rdi, [rbp - 8]
	call M_FT_LIST_SORT                 ; ft_list_sort(&middle, cmp)
	pop  rsi
	pop  rdi

	; === merging sorted child ===
	push rdi
	push rsi
	mov  rdi, [rdi]                    ; arg_1 = *begin_list
	mov  rdx, rsi                      ; arg_3 = cmp
	mov  rsi, [rbp - 8]                ; arg_2 = middle
	call _st_merge_sorted_list
	pop  rsi
	pop  rdi
	mov  [rdi], rax                    ; *begin_list = st_merge_sorted_list(...);

	; restoring stack frame
	mov  rsp, rbp
	pop  rbp
FT_LIST_SORT_END:
	ret


; t_list *st_merge_sorted_list(t_list* l1, t_list* l2, int (*cmp)(void*, void*))
_st_merge_sorted_list:
	cmp  rdi, NULL
	je   MERGE_SORTED_LIST_RETURN_L2   ; if l1 == NULL return l2
	cmp  rsi, NULL
	je   MERGE_SORTED_LIST_RETURN_L1   ; if l2 == NULL return l1

	push rdi
	push rsi
	push rdx
	mov  rdi, [rdi + 0]                ; l1->data
	mov  rsi, [rsi + 0]                ; l2->data
	xor  rax, rax
	call rdx                           ; cmp
	pop  rdx
	pop  rsi
	pop  rdi

	cmp  eax, 0
	jl   MERGE_SORTED_LIST_L1_LT_L2

	; if l1 >= l2
	push rsi                           ; save l2
	mov  rsi, [rsi + 8]                ; l2 = l2->next
	call _st_merge_sorted_list         ; merge_sorted_list(l1, l2->next, cmp)
	pop  rsi                           ; restore rsi
	mov  [rsi + 8], rax
	mov  rax, rsi
	jmp  MERGE_SORTED_LIST_END
	; else
MERGE_SORTED_LIST_L1_LT_L2:
	push rdi
	mov  rdi, [rdi + 8]
	call _st_merge_sorted_list         ; merge_sort_list(l1->next, l2, cmp)
	pop  rdi
	mov  [rdi + 8], rax
	mov  rax, rdi
	jmp  MERGE_SORTED_LIST_END

MERGE_SORTED_LIST_RETURN_L1:
	mov  rax, rdi
	ret
MERGE_SORTED_LIST_RETURN_L2:
	mov  rax, rsi
MERGE_SORTED_LIST_END:
	ret
