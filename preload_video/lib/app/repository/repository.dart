import 'package:dio/dio.dart';
import 'package:preload_video/app/model/feed_response.dart';

class UserRepository {
  final String apiKey = "563492ad6f91700001000001fd16140e607045dfa967746495029cc2";
  static String baseUrl = "https://api.pexels.com";

  final Dio dio = Dio();
  var getFeedsAPI = "$baseUrl/videos/search";

  Future<FeedResponse> getFeeds() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "query": "dancing",
      "page": 1,
      "size": "small",
      "orientation ": "portrait"
    };

    try {
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers['Authorization'] = apiKey;
        dio.interceptors.requestLock.unlock();
        return handler.next(options);
      }));

      Response response = await dio.get(getFeedsAPI, queryParameters: params);

      return FeedResponse.fromJson(response.data);
    } catch(e) {
      return FeedResponse.withError("$e");
    }
  }
}