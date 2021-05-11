String formatNumber(int sum) {
  final sumString = sum.toString();
  final first = sumString.substring(0, sumString.length - 2);
  final second = sumString.substring(sumString.length - 2, sumString.length);
  return (first + "," + second).trim();
}