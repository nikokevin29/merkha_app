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
      //print('data : ${response.body}');
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
    print('Unfollowed');
    // var data = jsonDecode(response.body);
    // Following value = Following.fromJson(data['data']);
    return ApiReturnValue(value: null);
  }

  static Future<String> checkstatus({String id, http.Client client}) async {
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
      return response.body;
    }
    //var data = jsonDecode(response.body);
    // Following value = Following.fromJson(data['data']);
    // print(value.following);
    return response.body;
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

  static Future<int> countFollowingUserOther({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'followinguser/countfollowinguser/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Count following user : ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<int> countFollowersUser({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'followinguser/countfollowersuser/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Count followers user : ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<ApiReturnValue<Following>> followUser({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'followinguser/follow/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Following value = Following.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Following>> unfollowUser({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'followinguser/unfollow/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    print('Unfollowed User');
    return ApiReturnValue(value: null);
  }

  static Future<String> checkstatusUser({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'followinguser/checkstatus/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return response.body;
    }
    return response.body;
  }
}
