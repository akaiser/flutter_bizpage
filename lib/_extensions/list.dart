extension ListEx<T> on List<T> {
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

  List<List<T>> chunks(int chunkSize) => fold(
    [[]],
    (result, x) => result.last.length == chunkSize
        ? (result..add([x]))
        : (result..last.add(x)),
  );
}
