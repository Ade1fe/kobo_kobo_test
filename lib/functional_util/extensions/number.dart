extension IntExtension on int {
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get days => Duration(days: this);
  int get inKobo => this * 100;
  int get inNaira => this ~/ 100;
}
