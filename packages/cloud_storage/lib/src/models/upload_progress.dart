import 'package:equatable/equatable.dart';

/// Statuses for File Upload
enum UploadStatus {
  /// Initial
  initial,

  /// Uploading
  uploading,

  /// Uploaded
  uploaded,

  /// Failure
  failure,
}

/// {@template upload_progress}
/// UploadProgress Model that is used to track the progress
/// and state of an uploading file
/// @{endtemplate}
class UploadProgress extends Equatable {
  /// {@macro}
  const UploadProgress({
    this.downloadUrl,
    this.status = UploadStatus.initial,
    this.uploadPercentage,
  });

  /// File download url
  final String? downloadUrl;

  /// Current status of the Upload file in progress
  final UploadStatus status;

  /// Current percentage of the file uploaded to the server
  final double? uploadPercentage;

  /// Checks if the file has completed upload
  bool get uploadCompleted =>
      status == UploadStatus.uploaded && downloadUrl != null;

  /// The copy constructor
  UploadProgress copyWith({
    String? downloadUrl,
    UploadStatus? status,
    double? uploadPercentage,
  }) =>
      UploadProgress(
        downloadUrl: downloadUrl ?? this.downloadUrl,
        status: status ?? this.status,
        uploadPercentage: uploadPercentage ?? this.uploadPercentage,
      );

  @override
  List<Object?> get props => [
        downloadUrl,
        status,
        uploadPercentage,
      ];
}
