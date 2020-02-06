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

global _ft_list_size

; int ft_list_size(t_list *begin_list);
_ft_list_size:
	xor eax, eax
FT_LIST_SIZE_LOOP:
	cmp rdi, 0
	je  FT_LIST_SIZE_END
	inc eax
	mov rdi, [rdi + 8]
	jmp FT_LIST_SIZE_LOOP
FT_LIST_SIZE_END:
	ret
