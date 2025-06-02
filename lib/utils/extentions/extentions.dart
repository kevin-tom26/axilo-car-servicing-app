extension IterableModifier<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    return cast<T?>()
        .firstWhere((v) => v != null && test(v), orElse: () => null);
  }
}
