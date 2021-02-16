part of 'services.dart';

class FollowingService {
  static Future<ApiReturnValue<Following>> follow({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/follow/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Following value = Following.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Following>> unfollow({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/unfollow/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Following value = Following.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Following>> checkstatus({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/checkstatus/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      var data = jsonDecode(response.body);
      Following value = Following.fromJson(data['data']);
      return ApiReturnValue(message: data['meta']['message'], value: value);
    }
    var data = jsonDecode(response.body);
    Following value = Following.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Following>>> followList({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/followlist';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('FollowList StatusCode : ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'List Following Failed');
    }

    var data = jsonDecode(response.body);
    List<Following> followlist =
        (data['data'] as Iterable).map((e) => Following.fromJson(e)).toList();
    return ApiReturnValue(value: followlist);
  }

  static Future<int> countFollowersMerchant({String idMerchant, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/countFollowersMerchant/' + idMerchant;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Count : ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    print('count followers = ' + data.toString());
    return data;
  }

  static Future<int> countFollowingUser({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'following/countFollowingUser';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Count following user : ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    print('count following = ' + data.toString());
    return data;
  }
}
