extension IterableEx<T> on Iterable<T> {
  Iterable<T> joinEx(T separator) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield separator;
        yield iterator.current;
      }
    }
  }

  List<T> get unmodifiable => List.unmodifiable(this);

  Iterable<R> mapIndexed<R>(R Function(int index, T element) mapper) sync* {
    var i = 0;
    for (final value in this) {
      yield mapper(i++, value);
    }
  }
}
