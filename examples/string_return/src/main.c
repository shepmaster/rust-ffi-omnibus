#include <stdio.h>
#include <stdint.h>

extern char *
theme_song_generate(uint8_t length);

extern void
theme_song_free(char *);

int main(void) {
  char *song = theme_song_generate(5);
  printf("%s\n", song);
  theme_song_free(song);
}
