#pragma once

	struct val_value {
		int is_identifier;
		int number;
		char identifier[32];
	};
    
	struct element_list {
        int len;
		struct val_value values[32];
	};
    
    struct command_tree {
        char command[32]; 
        struct element_list list;
    };
