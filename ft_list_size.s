; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/11/22 20:59:52 by cacharle          #+#    #+#              ;
;    Updated: 2019/11/24 01:55:14 by cacharle         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

%ifdef __LINUX__
    %define M_FT_LIST_SIZE ft_list_size
%else
    %define M_FT_LIST_SIZE _ft_list_size
%endif

global M_FT_LIST_SIZE

section .text
; int ft_list_size(t_list *begin_list);
M_FT_LIST_SIZE:
    xor eax, eax
FT_LIST_SIZE_LOOP:
    cmp rdi, 0
    je  FT_LIST_SIZE_END
    inc eax
    mov rdi, [rdi + 8]
    jmp FT_LIST_SIZE_LOOP
FT_LIST_SIZE_END:
    ret
