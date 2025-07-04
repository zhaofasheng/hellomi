class CustomMessageTimeFormat {
  static String convert(double seconds) {
    int hours = (seconds ~/ 3600).toInt();
    int remainingSeconds = (seconds % 3600).toInt();
    int minutes = (remainingSeconds ~/ 60).toInt();

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
