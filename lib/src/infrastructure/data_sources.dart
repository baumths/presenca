export 'datasources/disciplines_data_source.dart';

abstract class DataSource<T> {
  Future<T?> read(String id);

  Future<List<T>> readAll();

  Future<void> write(String key, T value);

  Future<void> delete(String id);

  /// Stream of events (ids) coming from the database.
  Stream<String> watch();
}

class DataSourceException implements Exception {
  const DataSourceException();
}
