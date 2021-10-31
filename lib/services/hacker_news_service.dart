import 'dart:async';
import 'dart:convert' as convert;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/exceptions/http_exception.dart';
import 'package:sample_app/models/news.dart';

///see https://github.com/HackerNews/API
class HackerNewsService {
  final http.Client _httpClient;
  final RemoteConfig _remoteConfig;
  HackerNewsService(this._httpClient, this._remoteConfig);

  FutureOr<List<int>> getTopNewsId() async {
    var url = Uri.https(_remoteConfig.getString('hacker_news_base_address'),
        '/v0/topstories.json');

    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw HttpException(response.statusCode,
          "There was an error getting hacker news top stories.");
    }
    return (convert.jsonDecode(response.body) as List<dynamic>)
        .map((e) => e as int)
        .toList();
  }

  FutureOr<News> getNews(int id) async {
    var url = Uri.https(_remoteConfig.getString('hacker_news_base_address'),
        '/v0/item/$id.json');

    var response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw HttpException(
          response.statusCode, "There was an error getting hacker news.");
    }
    return News.fromJson(
        convert.jsonDecode(response.body) as Map<String, dynamic>);
  }
}
