import 'app/src/youtube_explode_base.dart';

Future<void> main() async {
  var yt = YoutubeExplode();
  var streamInfo = await yt.videos.streamsClient.getManifest('fRh_vgS2dFE');

  print(streamInfo);

  yt.close();
}
