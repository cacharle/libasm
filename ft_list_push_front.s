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

%include "libasm.s"

%ifdef __LINUX__
    %define M_FT_LIST_PUSH_FRONT ft_list_push_front
    %define M_MALLOC malloc
%else
    %define M_FT_LIST_PUSH_FRONT _ft_list_push_front
    %define M_MALLOC _malloc
%endif

extern M_MALLOC

global M_FT_LIST_PUSH_FRONT

; void ft_list_push_front(t_list **begin_list, void *data);
M_FT_LIST_PUSH_FRONT:
    cmp  rdi, 0
    je   FT_LIST_PUSH_FRONT_END

    push rdi
    push rsi
    xor  rdi, rdi
    mov  edi, 16
    call M_MALLOC M_EXTERN_CALL_SUFFIX
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
