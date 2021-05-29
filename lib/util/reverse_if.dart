/// Returns a reversed version of the list if `condition` is `true`
List<T>/*!*/ reverseIf<T>({bool condition, List<T>/*!*/ list}) {
  return condition ? list.reversed.toList() : list;
}
