# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 02:56:22 by cacharle          #+#    #+#              #
#    Updated: 2021/02/11 14:50:09 by charles          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RM = rm -f
LIB = ar rcs

CC = gcc
CCFLAGS = -g -Wall -Wextra -fomit-frame-pointer

NASM = nasm
ifeq ($(shell uname),Linux)
	NASMFLAGS = -f elf64 -D__LINUX__=1
else
	NASMFLAGS = -f macho64
endif

NAME = libasm.a
ASMSRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s \
		 ft_strdup.s ft_atoi_base.s ft_list_push_front.s \
		 ft_list_size.s ft_list_sort.s ft_list_remove_if.s
ASMOBJ = $(ASMSRC:.s=.o)

all: $(NAME)

bonus: all

$(NAME): $(ASMOBJ)
	$(LIB) $(NAME) $(ASMOBJ)

test: all
	$(CC) main.c $(NAME)

%.o: %.s
	$(NASM) $(NASMFLAGS) -o $@ $<

clean:
	$(RM) $(ASMOBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all bonus test clean fclean re
