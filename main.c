#include <stdio.h>

int ft_strlen(char *);

/* extern void test(); */


int main()
{
	/* extern say_hi(); */
	char *a = "";
	char *b = "a";

	/* printf("%d\n", sizeof(char*)); */
	/* printf("a: %p\n", (void*)a); */
	/* printf("b: %p\n", (void*)a); */
	/* extern ft_strlen("bonjour"); */
	printf("%d\n", ft_strlen(a));
	printf("%d\n", ft_strlen(b));
	printf("%d\n", ft_strlen("bonjour"));
	return 0;
}

