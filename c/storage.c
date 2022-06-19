#include <inttypes.h>
#include <stdio.h>

// trivial impl that can keep a single value in memory!
uintptr_t _p;

void store(const char *key, const uintptr_t value) {
  _p = value;
}

int fetch(const char *key, uintptr_t *value) {
  *value = _p;
  return 1;
}

// cannot name main() when runnign Zig tests
int main2() {
  static char *s;
  store("foo", (const uintptr_t) "goodbye");
  fetch("foo", (uintptr_t *) &s);
  printf("s is %s\n", s);
  return 0;
}
