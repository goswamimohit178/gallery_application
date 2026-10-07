import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'dart:typed_data';
import 'download_event.dart';
import 'download_state.dart';

class DownloadBloc
    extends Bloc<DownloadEvent, DownloadState> {
  final Dio dio;

  DownloadBloc(this.dio)
      : super(const DownloadState()) {
    on<DownloadRequested>(_onDownloadRequested);
  }

  Future<void> _onDownloadRequested(
      DownloadRequested event,
      Emitter<DownloadState> emit,
      ) async {
    emit(
      state.copyWith(
        status: DownloadStatus.downloading,
        progress: 0,
      ),
    );

    try {
      final response = await dio.get<List<int>>(
        event.url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;

            emit(
              state.copyWith(
                status: DownloadStatus.downloading,
                progress: progress,
              ),
            );
          }
        },
      );



      final bytes = response.data;

      if (bytes == null) {
        throw Exception('Download returned empty data.');
      }

      await Gal.putImageBytes(
        Uint8List.fromList(bytes),
      );

      emit(
        state.copyWith(
          status: DownloadStatus.success,
          progress: 1,
          message: 'Image saved successfully.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DownloadStatus.failure,
          message: 'Unable to download image.',
        ),
      );
    }
  }
}