extension AnyExtensions<T> on T {
  T2 let<T2>(T2 Function(T) block) => block(this);

  T? takeIf(bool Function(T it) block) => block(this) ? this : null;
}