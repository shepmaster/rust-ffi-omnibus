#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

extern uint32_t
how_many_characters(const char *str);

int main(void) {
  uint32_t count = how_many_characters("göes to élevên");
  printf("%" PRIu32 "\n", count);
}
