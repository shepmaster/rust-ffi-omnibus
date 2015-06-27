#include <stdio.h>
#include <stdint.h>

extern uint32_t sum_of_even(const uint32_t *numbers, size_t length);

int main(void) {
  uint32_t numbers[6] = {1,2,3,4,5,6};
  uint32_t sum = sum_of_even(numbers, 6);
  printf("%d\n", sum);
  return 0;
}
