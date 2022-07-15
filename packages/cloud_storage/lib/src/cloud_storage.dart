import 'dart:io';

import 'package:cloud_storage/src/exception/exception.dart';
import 'package:cloud_storage/src/models/models.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// {@template cloud_storage}
/// Cloud Storage Service
/// {@endtemplate}
class CloudStorage {
  /// {@macro cloud_storage}
  CloudStorage({
    FirebaseStorage? storage,
  }) : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  /// Default Maximum size of file
  final double _maxFileSizeInMbs = 10;

  /// List of allowed extensions
  final List<String> _allowedImageExtensions = [
    'png',
    'jpg',
    'jpeg',
  ];

  /// Uploads an image to the cloud storage
  ///
  /// return [UploadProgress] which indicates the upload
  /// progress and the downloadUrl of the file.
  Stream<UploadProgress> uploadImage(
    File file, {
    String? path,
  }) async* {
    if (!isValidImage(file)) throw IncorrectDocumentTypeException();
    try {
      final fileSizeInBytes = file.lengthSync();
      yield* _storage.ref(path).putFile(file).snapshotEvents.asyncMap(
        (taskSnapshot) async {
          final percentage =
              taskSnapshot.bytesTransferred / fileSizeInBytes * 100;
          switch (taskSnapshot.state) {
            case TaskState.paused:
            case TaskState.running:
              break;
            case TaskState.success:
              try {
                final downloadUrl = await taskSnapshot.ref.getDownloadURL();
                return UploadProgress(
                  uploadPercentage: percentage.floorToDouble(),
                  status: UploadStatus.uploaded,
                  downloadUrl: downloadUrl,
                );
              } catch (_) {
                throw DownloadUrlException();
              }
            case TaskState.canceled:
            case TaskState.error:
              throw UploadFailureException();
          }
          return UploadProgress(
            uploadPercentage: percentage.floorToDouble(),
            status: UploadStatus.uploading,
          );
        },
      );
    } on FirebaseException catch (e) {
      if ([
        FirebaseExceptions.errorNotAuthenticated,
        FirebaseExceptions.errorNotAuthorized,
      ].contains(e.code)) {
        throw UnAuthorizedException();
      }
      throw StorageException();
    } on DownloadUrlException {
      rethrow;
    } catch (_) {
      throw UploadFailureException();
    }
  }

  /// Delete an image from the cloud storage
  Future<void> deleteImage(String downloadUrl) async {
    try {
      await _storage.refFromURL(downloadUrl).delete();
    } on FirebaseException catch (e) {
      if ([
        FirebaseExceptions.errorNotAuthenticated,
        FirebaseExceptions.errorNotAuthorized,
      ].contains(e.code)) {
        throw UnAuthorizedException();
      }
      throw StorageException();
    }
  }

  /// Returns the file size in MegaBytes
  double getFileSizeInMbs(File file) {
    return file.lengthSync() / 1024 / 1024;
  }

  /// Return true if the file size is less then the required size
  /// defined in [_maxFileSizeInMbs]
  bool isFileSizeValid(File file) {
    return getFileSizeInMbs(file) <= _maxFileSizeInMbs;
  }

  /// Check if the file extension is in the list of the allowed extensions
  /// defined in [_allowedImageExtensions]
  bool isValidImage(File file) {
    final components = file.path.split('.');
    if (components.isNotEmpty) {
      final extension = components.last;
      return _allowedImageExtensions
              .firstWhereOrNull((allowedExt) => allowedExt == extension) !=
          null;
    }
    return false;
  }
}
