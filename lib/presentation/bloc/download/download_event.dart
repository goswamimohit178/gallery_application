import 'package:equatable/equatable.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object?> get props => [];
}

class DownloadRequested extends DownloadEvent {
  final String url;

  const DownloadRequested(this.url);

  @override
  List<Object?> get props => [url];
}