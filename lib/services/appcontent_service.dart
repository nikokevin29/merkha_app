part of 'services.dart';

class AppContentServices {
  static Future<List<String>> showMainAppContent({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'app_content/main_page';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return [];
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<List<String>> showMerchantCategoryAppContent(
      {String idMerchant, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'app_content/merchant_category/' + idMerchant;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return [];
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<List<AppContent>> showMainAppContentFormat({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'app_content/main_page_format';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Main App Content: ${response.statusCode}');
      return null;
    }
    var data = jsonDecode(response.body);
    List<AppContent> val = (data as Iterable).map((e) => AppContent.fromJson(e)).toList();
    return val;
  }

  static Future<List<AppContent>> showMerchantCategoryAppContentFormat(
      {String idMerchant, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'app_content/merchant_category/' + idMerchant;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Main App Content: ${response.statusCode}');
      return null;
    }
    var data = jsonDecode(response.body);
    List<AppContent> val = (data as Iterable).map((e) => AppContent.fromJson(e)).toList();
    return val;
  }
}
