/* header for cpp main */
#pragma once

// only use extern block if the header is put inside a C++ CU
extern "C" {
  uint32_t addition(uint32_t a, uint32_t b);
}