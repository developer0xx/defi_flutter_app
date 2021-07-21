extension ListExtensions<T> on List<T> {
  List<T> separatedWith(T value) =>
      asMap().entries.expand((entry) => [if (entry.key != 0) value, entry.value]).toList();

  List<T> plus(List<T> other) {
    return [...this, ...other];
  }

  List<T> minus(List<T> other) {
    return where((it) => !other.contains(it)).toList();
  }
}
