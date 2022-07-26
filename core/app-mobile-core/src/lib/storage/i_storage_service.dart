abstract class IStorageService {
  /// Retrieves a string from a storage medium by using a [key].
  dynamic get(String key);

  /// Sets the [value] of a [key] in a storage medium.
  dynamic set(String key, dynamic value);

  /// Deletes the content of a [key] in a storage medium.
  dynamic delete(String key);

  /// Deletes all content of a storage medium.
  dynamic deleteAll();
}
