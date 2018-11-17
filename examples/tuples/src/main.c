#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

typedef struct {
  uint32_t x;
  uint32_t y;
} tuple_t;

extern tuple_t
flip_things_around(tuple_t);

int main(void) {
  tuple_t initial = { .x = 10, .y = 20 };
  tuple_t result = flip_things_around(initial);
  printf("(%" PRIu32 ",%" PRIu32 ")\n", result.x, result.y);
}
