part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'login';

    var response = await client.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }
    var data = jsonDecode(response.body);

    User.token = data['data']['token'];
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<User>> signOut({http.Client client}) async {
    String messeage;
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'logout';
    String token = User.token;

    var response = await client.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode != 200) {
      var data = jsonDecode(response.body);
      var message = data['message'];
      print('status code ${response.statusCode} ' + message);
      return ApiReturnValue(message: message);
    }
    var data = jsonDecode(response.body);
    messeage = data['meta']['message'];
    return ApiReturnValue(message: messeage);
  }

  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File urlphoto, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'register';

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'first_name': user.first_name,
        'last_name': user.last_name,
        'password': password,
        'username': user.username,
        'gender': user.gender,
        'email': user.email,
        'phone_number': user.phone_number,
        'url_photo': user.urlphoto,
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    if (urlphoto != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(urlphoto);
      if (result.value != null) {
        value = value.copyWith(urlphoto: baseURLphoto + result.value);
      }
    }

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest request}) async {
    String url = baseURL + 'user/photo';
    var uri = Uri.parse(url);

    if (request == null) {
      request = http.MultipartRequest("POST", uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${User.token}";
    }

    var multipartFile = await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      String imagePath = data['data'][0];

      return ApiReturnValue(value: imagePath);
    } else {
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }
  }
}
