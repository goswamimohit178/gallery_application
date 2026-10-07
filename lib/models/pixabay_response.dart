import 'pixabay_image.dart';

class PixabayResponse {
  final int total;
  final int totalHits;
  final List<PixabayImage> images;

  const PixabayResponse({
    required this.total,
    required this.totalHits,
    required this.images,
  });

  factory PixabayResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    final hits =
        json['hits'] as List<dynamic>? ?? [];

    return PixabayResponse(
      total: json['total'] ?? 0,
      totalHits: json['totalHits'] ?? 0,
      images: hits.map((item) {
        return PixabayImage.fromJson(
          item as Map<String, dynamic>,
        );
      }).toList(),
    );
  }
}