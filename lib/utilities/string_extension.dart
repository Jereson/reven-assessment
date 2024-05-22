extension StringExtension on String {
  String get toPng {
    return 'assets/images/$this.png';
  }
}