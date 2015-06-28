#include <stdio.h>
#include <stdint.h>

typedef struct {
  uint32_t x;
  uint32_t y;
} tuple_t;

extern tuple_t flip_things_around(tuple_t);

int main(void) {
  tuple_t initial = { .x = 10, .y = 20 };
  tuple_t new = flip_things_around(initial);
  printf("(%d,%d)\n", new.x, new.y);
  return 0;
}
