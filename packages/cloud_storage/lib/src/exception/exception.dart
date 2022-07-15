/// Something goes wrong while uploading the file
class UploadFailureException implements Exception {}

/// The type/extension of the document is not valid
class IncorrectDocumentTypeException implements Exception {}

/// User is not authorized to use the storage
class UnAuthorizedException implements Exception {}

/// Storage exception when Storage services are not enabled
class StorageException implements Exception {}

/// The file download url return null or throw an exception
class DownloadUrlException implements Exception {}

/// {@template}
/// Store constant values for Firebase exception
/// Ref: https://firebase.google.com/docs/reference/unity/class/firebase/storage/storage-exception
/// {@endtemplate}
abstract class FirebaseExceptions {
  /// The given signin credentials are not valid.
  static const String errorNotAuthenticated = '-13020';

  /// The given signin credentials are not allowed to perform this operation.
  static const String errorNotAuthorized = '-13021';
}
