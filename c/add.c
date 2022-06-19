int add(int a, int b) {
  return a + b;
}

int count_bytes(char *str) {
  int count = 0;
  while(str[count]) {
    count++;
  }
  return count;
}
