void main() {
  List<int> weekData = [1];
  final List<int> paddedData = List.generate(7, (index) {
    if (index < weekData.length) {
      return weekData[index];
    }
    return 8;
  });
  
  for (int i = 0; i < 7; i++) {
    print(paddedData[i]);
  }
}
