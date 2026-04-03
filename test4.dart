void main() {
  try {
    List<int> a = [42];
    print(a[1]);
  } catch(e) {
    print("A: $e");
  }

  try {
    List<int> b = List.generate(1, (i) => i);
    print(b[1]);
  } catch(e) {
    print("B: $e");
  }

  try {
    print(List.generate(7, (i) => i)[10]);
  } catch(e) {
    print("C: $e");
  }
}
