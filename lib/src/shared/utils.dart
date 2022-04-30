bool listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) {
    return false;
  }

  if (identical(a, b)) {
    return true;
  }

  for (int index = 0; index < a.length; index++) {
    if (a[index] == b[index]) {
      continue;
    }
    return false;
  }

  return true;
}
