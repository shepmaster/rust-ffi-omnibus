#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

extern size_t
counter_generate(size_t size, int16_t **vec);

extern void
counter_free(int16_t *vec, size_t size);

int main(void) {
  int16_t *vec;
  size_t vec_len = counter_generate(10, &vec);
  for (size_t i = 0; i < vec_len; i++) {
    printf("%" PRId16 "..", vec[i]);
  }
  printf("\n");

  counter_free(vec, vec_len);
}
