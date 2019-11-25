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

global _ft_list_push_front

; void ft_list_push_front(t_list **begin_list, void *data);
_ft_list_push_front:
	cmp rdi, 0
	je  FT_LIST_PUSH_FRONT_END
	mov [rsi + 8], [rdi]
	mov [rdi], rsi
FT_LIST_PUSH_FRONT_END:
	ret
