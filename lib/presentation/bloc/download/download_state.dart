import 'package:equatable/equatable.dart';

enum DownloadStatus {
  initial,
  downloading,
  success,
  failure,
}

class DownloadState extends Equatable {
  final DownloadStatus status;
  final double progress;
  final String? message;

  const DownloadState({
    this.status = DownloadStatus.initial,
    this.progress = 0,
    this.message,
  });

  DownloadState copyWith({
    DownloadStatus? status,
    double? progress,
    String? message,
  }) {
    return DownloadState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    progress,
    message,
  ];
}