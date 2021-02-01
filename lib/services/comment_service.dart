part of 'services.dart';

class CommentService {
  static Future<ApiReturnValue<List<Comment>>> showCommentById(
      {String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'comment/showcommentbyid/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode comment : ${response.statusCode}');
      //print('data Comment : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Comment> comment = (data['data'] as Iterable).map((e) => Comment.fromJson(e)).toList();
    return ApiReturnValue(value: comment, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Comment>> sendComment({Comment comment, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'comment/createcomment/';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'comment': comment.comment,
        'id_feed': comment.idFeed.toString(),
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode comment : ${response.statusCode}');
      print('data Comment : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Comment value = Comment.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }
}
