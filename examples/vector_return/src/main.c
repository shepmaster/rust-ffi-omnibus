#include <stdio.h>
#include <stdint.h>

extern size_t
counter_generate(size_t size, int16_t **vec);

extern void
counter_free(int16_t *vec, size_t size);

int main(void) {
  int16_t *vec;
  size_t vec_len;

  vec_len = counter_generate(10, &vec);
  for (int i = 0; i < 10; i++) {
    printf("%hd..", vec[i]);
  }
  printf("\n");

  counter_free(vec, vec_len);

  return 0;
}
