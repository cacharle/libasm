/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cacharle <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 02:02:24 by cacharle          #+#    #+#             */
/*   Updated: 2020/02/08 20:36:59 by cacharle         ###   ########.fr       */
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


int*
create_data_elem(int data)
{
	int *data_ptr = malloc(sizeof(int));
	if (data_ptr == NULL)
		return (NULL);
	*data_ptr = data;
	return data_ptr;
}

t_list*
create_elem(int data)
{
	t_list *new = malloc(sizeof(t_list));
	if (new == NULL)
		return NULL;
	if ((new->data = create_data_elem(data)) == NULL)
		return (NULL);
	new->next = NULL;
	return new;
}

static void
push_front(t_list **lst_ptr, t_list *new_front)
{
	if (lst_ptr == NULL || new_front == NULL)
		return ;
	new_front->next = *lst_ptr;
	*lst_ptr = new_front;
}

static t_list*
reverse(t_list *list)
{
	if (list == NULL || list->next == NULL)
		return list;
	t_list *tmp = reverse(list->next);
	list->next->next = list;
	list->next = NULL;
	return tmp;
}

t_list*
list_from_format(char *fmt)
{
	t_list *head = NULL;

	while (fmt != NULL && *fmt)
	{
		int n = (int)strtol(fmt, &fmt, 10);
		t_list *elem = create_elem(n);
		push_front(&head, elem);
	}
	return reverse(head);
}

t_list*
list_dup(t_list *list)
{
	t_list *dup_head = NULL;

	while (list != NULL)
	{
		t_list *tmp = create_elem(*(int*)list->data);
		push_front(&dup_head, tmp);
	}
	return reverse(dup_head);
}

int
list_cmp(t_list *l1, t_list *l2)
{
	if (l1 == NULL && l2 == NULL)
		return 0;
	if (l1 == NULL)
		return -1;
	if (l2 == NULL)
		return 1;
	if (l1->data == NULL)
		return -1;
	if (l2->data == NULL)
		return 1;
	if (*(int*)l1->data != *(int*)l2->data)
		return *(int*)l1->data - *(int*)l2->data;
	return list_cmp(l1->next, l2->next);
}

void
list_print(t_list *list)
{
	while (list != NULL)
	{
		printf("[%d] -> ", *(int*)list->data);
		list = list->next;
	}
	printf("(null)");
}

void
list_destroy(t_list *list)
{
	if (list == NULL)
		return ;
	list_destroy(list->next);
	if (list->data != NULL)
		free(list->data);
	free(list);
}

int ft_strlen(char *);
char *ft_strcpy(char *dst, const char *src);
int ft_strcmp(const char *s1, const char *s2);
int ft_write(int, const void*, size_t);
int ft_read(int, void*, size_t);
char *ft_strdup(const char*);
int ft_atoi_base(const char*, const char*);

void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));

int compar(void *a, void *b)
{
	printf("---\n");
	printf("a = %p, b = %p\n", a, b);
	printf("*a = %d, *b = %d\n", *(int*)a, *(int*)b);
	int c =  *(int*)a - *(int*)b;
	printf("ret %d\n", c);
	return c;
}

void free_fct(void *data)
{
	printf("free: %p\n", data);
	printf("free data %d\n", *(int*)data);
	free(data);
	printf("end free\n");
	fflush(stdout);
}

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

	/* char *h = ft_strdup("bonjour"); */
	/* printf("%d\n", h); */
	/* printf("%s\n", h); */
	/* free(h); */
	

	/* printf("%d\n", check_base("01")); */

	/* printf("%d\n", ft_atoi_base(" \t\n\r\v\f\r 10\t0101001", "01")); */
	/* printf("_%d_\n", ft_atoi_base(" 755x+", "01234567")); */

	/* system("vmmap a.out"); */
	/* t_list *a = list_from_format("-1 2 3 98 1234 12 123 4 123 -123 2 5 6 0 1 3 4"); */
	/* t_list *a = list_from_format("1"); */
	/* t_list *a = NULL; */
	/* printf("%d: ", ft_list_size(a)); list_print(a); putchar('\n'); */
	/* ft_list_sort(&a, compar); */
	/* printf("%d: ", ft_list_size(a)); list_print(a); putchar('\n'); */

	t_list *a = list_from_format("1 2 3 4 1 2 3 1");
	int data_ref = 1;
	printf("f: %p\n", a->data);
	/* free(a->data); */
	printf("%p\n", &data_ref);
	list_print(a); putchar('\n');
	ft_list_remove_if(&a, &data_ref, compar, free_fct);
	list_print(a); putchar('\n');

	list_destroy(a);
	return 0;
}
