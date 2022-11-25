import 'package:equatable/equatable.dart';

class VideoFile extends Equatable {
  final int id;
  final String quality;
  final String link;

  const VideoFile(this.id, this.quality, this.link);

  VideoFile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quality = json['quality'] ?? "",
        link = json['quality'] ?? "";

  @override
  List<Object> get props => [id, quality, link];

  static const empty = VideoFile(0, "", "");
}
