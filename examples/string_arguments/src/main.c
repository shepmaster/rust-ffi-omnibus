#include <stdio.h>
#include <inttypes.h>

extern uint32_t how_many_characters(const char *str);

int main(void) {
  uint32_t count = how_many_characters("göes to élevên");
  printf("%d\n", count);
  return 0;
}
