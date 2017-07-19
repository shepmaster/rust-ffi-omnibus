#include <iostream>
#include "header.h"

/* Make sure the .lib file is included in Linker / Input / Additional Dependencies. */

int main(){
	uint32_t a = 2;
	uint32_t b = 3;
	uint32_t result = addition(a, b);
	std::cout << a << " + " << b << " = " << result << "\n";
	system("PAUSE");
	return 0;
}