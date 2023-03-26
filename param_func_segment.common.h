#pragma once

	struct val_value {
		int is_identifier;
		int number;
		const char *identifier;
	};

	struct elementlist_node {
		struct elementlist_node* next;
		struct val_value the_val;
	};
	struct elementlist_value {
		struct elementlist_node* first;
		struct elementlist_node* last;
	};
