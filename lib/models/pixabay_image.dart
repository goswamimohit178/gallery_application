import 'package:equatable/equatable.dart';

class PixabayImage extends Equatable {
  final int id;
  final String pageUrl;
  final String type;
  final String tags;
  final String previewUrl;
  final String webFormatUrl;
  final String largeImageUrl;
  final int imageWidth;
  final int imageHeight;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final String user;
  final int userId;

  const PixabayImage({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.webFormatUrl,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.user,
    required this.userId,
  });

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      id: json['id'] ?? 0,
      pageUrl: json['pageURL'] ?? '',
      type: json['type'] ?? '',
      tags: json['tags'] ?? '',
      previewUrl: json['previewURL'] ?? '',
      webFormatUrl: json['webformatURL'] ?? '',
      largeImageUrl: json['largeImageURL'] ?? '',
      imageWidth: json['imageWidth'] ?? 0,
      imageHeight: json['imageHeight'] ?? 0,
      views: json['views'] ?? 0,
      downloads: json['downloads'] ?? 0,
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      user: json['user'] ?? '',
      userId: json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageURL': pageUrl,
      'type': type,
      'tags': tags,
      'previewURL': previewUrl,
      'webformatURL': webFormatUrl,
      'largeImageURL': largeImageUrl,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
      'views': views,
      'downloads': downloads,
      'likes': likes,
      'comments': comments,
      'user': user,
      'user_id': userId,
    };
  }

  @override
  List<Object?> get props => [
    id,
    pageUrl,
    type,
    tags,
    previewUrl,
    webFormatUrl,
    largeImageUrl,
    imageWidth,
    imageHeight,
    views,
    downloads,
    likes,
    comments,
    user,
    userId,
  ];
}