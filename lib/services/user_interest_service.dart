part of 'services.dart';

class UserInterestService {
  static Future<ApiReturnValue<List<UserInterest>>> showUserInterest({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'user/interest/show';
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
    List<UserInterest> userinterest = (data['data'] as Iterable).map((e) => UserInterest.fromJson(e)).toList();
    return ApiReturnValue(value: userinterest, message: data['meta']['message']);
  }
}