# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort.s                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cacharle <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/22 21:03:52 by cacharle          #+#    #+#              #
#    Updated: 2019/11/22 21:27:27 by cacharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.globl _ft_list_sort

# void ft_list_sort(t_list **begin_list, int (*cmp)());
_ft_list_sort:
	push rbp
	mov rbp, rsp

	call _ft_list_size
	cmp eax, 2
	jl FT_LIST_SORT_END

	# split in half
	# _ft_list_sort both half
	# merge_sorted


	FT_LIST_SORT_END:
		pop rbp
		ret


merge_sorted:
#ListNode* mergeTwoLists(ListNode* l1, ListNode* l2)
#{
#	ListNode *merged = NULL;
#
#	if (l1 == NULL && l2 == NULL)
#		return NULL;
#	if (l1 == NULL)
#		return l2;
#	if (l2 == NULL)
#		return l1;
#	merged = l1->val < l2->val ? l1 : l2;
#	if (l1->val < l2->val)
#		merged->next = mergeTwoLists(l1->next, l2);
#	else
#		merged->next = mergeTwoLists(l1, l2->next);
#	return merged;
#}
