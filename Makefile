# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 02:56:22 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 03:58:18 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

CC = gcc
CCFLAGS = -masm=intel -m64

ASMSRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s \
		 ft_atoi_base.s
ASMOBJ = $(ASMSRC:.s=.o)

RM = rm -f
LIB = ar rcs

all: $(NAME)

$(NAME): $(ASMOBJ)
	$(LIB) $(NAME) $(ASMOBJ)

test: all
	$(CC) main.c -L. -lasm

%.o: %.s
	$(CC) $(CCFLAGS) -c -o $@ $<
	@#nasm -f macho64 -o $@ $<

clean:
	$(RM) $(ASMOBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all
