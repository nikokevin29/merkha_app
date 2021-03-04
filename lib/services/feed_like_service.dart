part of 'services.dart';

class FeedLikeService {
  static Future<String> createLike({String idFeed, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed_like/create/' + idFeed;
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_feed': idFeed,
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode Create Like : ${response.statusCode}');
      return '0';
    }
    print('Create Like Success');
    return '1';
  }

  static Future<String> deleteLike({String idFeed, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed_like/delete/' + idFeed;
    var response = await client.delete(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Delete Like: ${response.statusCode}');
      return '0';
    }
    print('Delete Like Feed');
    return '1';
  }

  static Future<String> checkStatusLike({String idFeed, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed_like/check/' + idFeed;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Check Status: ${response.statusCode}');
      return response.body;
    }
    print('Check Status Like Done');
    return response.body;
  }
}
