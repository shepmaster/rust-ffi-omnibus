#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

extern uint32_t
sum_of_even(const uint32_t *numbers, size_t length);

int main(void) {
  uint32_t numbers[] = {1, 2, 3, 4, 5, 6};
  size_t length = sizeof numbers / sizeof *numbers;
  uint32_t sum = sum_of_even(numbers, length);
  printf("%" PRIu32 "\n", sum);
}
