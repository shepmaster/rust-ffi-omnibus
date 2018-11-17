#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

typedef struct zip_code_database zip_code_database_t;

extern zip_code_database_t *
zip_code_database_new(void);

extern void
zip_code_database_free(zip_code_database_t *);

extern void
zip_code_database_populate(zip_code_database_t *);

extern uint32_t
zip_code_database_population_of(const zip_code_database_t *, const char *zip);

int main(void) {
  zip_code_database_t *database = zip_code_database_new();
  zip_code_database_populate(database);

  uint32_t pop1 = zip_code_database_population_of(database, "90210");
  uint32_t pop2 = zip_code_database_population_of(database, "20500");

  zip_code_database_free(database);

  printf("%" PRId32 "\n", (int32_t)pop1 - (int32_t)pop2);
}
