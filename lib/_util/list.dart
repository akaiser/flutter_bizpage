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

  List<List<T>> chunks(int chunkSize) {
    return fold([[]], (result, x) {
      return result.last.length == chunkSize
          ? (result..add([x]))
          : (result..last.add(x));
    });
  }
}

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

  Iterable<R> mapIndexed<R>(R Function(int index, T element) mapper) sync* {
    int i = 0;
    for (final value in this) {
      yield mapper(i++, value);
    }
  }
}
