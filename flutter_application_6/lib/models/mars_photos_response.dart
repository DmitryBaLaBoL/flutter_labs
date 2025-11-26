import 'photo.dart';

class MarsPhotosResponse {
  final List<Photo> photos;

  MarsPhotosResponse({
    required this.photos,
  });

  factory MarsPhotosResponse.fromJson(Map<String, dynamic> json) => MarsPhotosResponse(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}