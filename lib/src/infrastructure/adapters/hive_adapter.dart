import 'package:hive/hive.dart';

import '../data_sources.dart';

abstract class HiveDataSourceAdapter<T> implements DataSource<T> {
  const HiveDataSourceAdapter(this.box);

  final LazyBox<T> box;

  @override
  Future<T?> read(String id) async {
    try {
      return await box.get(id);
    } on HiveError {
      throw const DataSourceException();
    }
  }

  @override
  Future<List<T>> readAll() async {
    final List<T> values = [];

    for (final dynamic key in box.keys) {
      final T? value = await read(key as String);

      if (value == null) {
        continue;
      }

      values.add(value);
    }

    return values;
  }

  @override
  Future<void> write(String key, T value) async {
    try {
      await box.put(key, value);
    } on HiveError {
      throw const DataSourceException();
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await box.delete(id);
    } on HiveError {
      throw const DataSourceException();
    }
  }

  @override
  Stream<String> watch() => box.watch().map((event) => event.key as String);
}
