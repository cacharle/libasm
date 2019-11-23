/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cacharle <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 02:02:24 by cacharle          #+#    #+#             */
/*   Updated: 2019/11/23 02:13:29 by cacharle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int ft_strlen(char *);
char *ft_strcpy(char *dst, const char *src);
int ft_strcmp(const char *s1, const char *s2);
int ft_write(int, const void*, size_t);
int ft_read(int, void*, size_t);
char *ft_strdup(const char*);
int ft_atoi_base(const char*, const char*);
int check_base(const char*);

void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)());

int main()
{
	/* char *a = ""; */
	/* char *b = "a"; */
	/* printf("%d\n", sizeof(char*)); */
	/* printf("a: %p\n", (void*)a); */
	/* printf("b: %p\n", (void*)a); */
	/* printf("%d\n", ft_strlen(a)); */
	/* printf("%d\n", ft_strlen(b)); */
	/* printf("%d\n", ft_strlen("bonjour")); */

	/* char c[32] = "bon"; */
	/* char *d = "b"; */
    /*  */
	/* printf("%s\n", c); */
	/* printf("%s\n", ft_strcpy(c, d)); */
	/* printf("%s\n", c); */

	/* char *e = "\x01"; */
	/* char *f = "\x02"; */
	/* printf("%d\n", ft_strcmp(e, f)); */
	/* printf("%d\n",    strcmp(e, f)); */

	/* ft_write(1, "bon\n", 4); */
    /*  */
	/* char g[32]; */
	/* int ret = ft_read(0, g, 2); */
	/* g[ret] = 0; */
	/* printf("%s\n", g); */
    /*  */
	char *h = ft_strdup("bonjour");
	printf("%s\n", h);
	free(h);


	/* printf("%d\n", check_base("01")); */

	/* printf("%d\n", ft_atoi_base(" \t\v\r  \n 1012h", "01")); */
	return 0;
}
