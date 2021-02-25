; ############################################################################ ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    libasm.s                                           :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: cacharle <me@cacharle.xyz>                 +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/02/25 10:38:57 by cacharle          #+#    #+#              ;
;    Updated: 2021/02/25 10:45:55 by cacharle         ###   ########.fr        ;
;                                                                              ;
; ############################################################################ ;


%ifdef __LINUX__
    %define M_EXTERN_CALL_SUFFIX wrt ..plt
%else
    %define M_EXTERN_CALL_SUFFIX
%endif
