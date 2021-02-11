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

%ifdef __LINUX__
    %define M_FT_LIST_REMOVE_IF ft_list_remove_if
    %define M_FREE free
%else
    %define M_FT_LIST_REMOVE_IF _ft_list_remove_if
    %define M_FREE _free
%endif

global M_FT_LIST_REMOVE_IF

extern M_FREE

%define NULL 0x0

%macro EXTERN_FUNCTION_SAVE 0
	push rdi
	push rsi
	push rdx
	push rcx
%endmacro

%macro EXTERN_FUNCTION_SAVE_END 0
	pop  rcx
	pop  rdx
	pop  rsi
	pop  rdi
%endmacro

; ft_list_remove_if(t_list **begin_list, void *data_ref,
;                   int (*cmp)(void *data, void *data_ref),
;                   void (*free_fct)(void *))
M_FT_LIST_REMOVE_IF:
	; t_list *saved_next

	; === prolog ===
	push rbp
	mov  rbp, rsp
	sub  rsp, 8

	; === base condition ===
	cmp  rdi, NULL
	je   FT_LIST_REMOVE_IF_END
	cmp  qword [rdi], NULL
	je   FT_LIST_REMOVE_IF_END

	; === compare (*begin_list)->data and data_ref
	EXTERN_FUNCTION_SAVE
	mov  rdi, [rdi]
	mov  rdi, [rdi + 0]
	call rdx                         ; cmp((*begin_list)->data, data_ref)
	EXTERN_FUNCTION_SAVE_END
	cmp  rax, 0
	je   FT_LIST_REMOVE_IF_REMOVE

	; === next element ===
	push rdi
	mov  rdi, [rdi]
	lea  rdi, [rdi + 8]
	call M_FT_LIST_REMOVE_IF
	pop  rdi
	jmp  FT_LIST_REMOVE_IF_END

	; === remove head and go next ===
FT_LIST_REMOVE_IF_REMOVE:
	mov  rax, [rdi]                    ; rax = *begin_list
	mov  rax, [rax + 8]                ; rax = rax->next
	mov  [rbp - 8], rax                ; saved_next = (*begin_list)->next

	push rdi                           ; strange behavior
	EXTERN_FUNCTION_SAVE
	mov  rdi, [rdi]
	mov  rdi, [rdi + 0]
	call rcx                           ; free_fct((*begin_list)->data)
	EXTERN_FUNCTION_SAVE_END
	pop  rdi

	EXTERN_FUNCTION_SAVE
	mov  rdi, [rdi]
	call M_FREE wrt ..plt              ; free(*begin_list)
	EXTERN_FUNCTION_SAVE_END

	mov rax, [rbp - 8]
	mov [rdi], rax
	call M_FT_LIST_REMOVE_IF

FT_LIST_REMOVE_IF_END:
	; === epilog ===
	mov  rsp, rbp
	pop  rbp
	ret
