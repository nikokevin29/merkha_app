part of 'services.dart';

class ReportService {
  static Future<ApiReturnValue<ReportProduct>> createReportProduct(String id,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_product/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_product': id,
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode Create Reprt Product: ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    ReportProduct value = ReportProduct.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<ReportProduct>> deleteReportProduct(String id,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_product/delete/' + id;
    var response = await client.delete(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Delete Report Product: ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    // var data = jsonDecode(response.body);
    // ReportProduct value = ReportProduct.fromJson(data['data']);
    return ApiReturnValue(value: null);
  }

  static Future<String> checkReportProduct({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_product/check/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Check Report Product: ${response.statusCode}');
      //print('data : ${response.body}');
      return response.body;
    }
    return response.body;
  }

  static Future<ApiReturnValue<ReportFeed>> createReportFeed(String id,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_feed/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_feed': id,
      }),
    );
    print(response.body);
    if (response.statusCode != 200) {
      print('StatusCode Create Report feed: ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }

    var data = jsonDecode(response.body);
    ReportFeed value = ReportFeed.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<ReportFeed>> deleteReportFeed(String id,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_feed/delete/' + id;
    var response = await client.delete(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    print(response.body);
    if (response.statusCode != 200) {
      print('StatusCode Delete Report Feed: ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    return ApiReturnValue(value: null);
  }

  static Future<String> checkReportFeed({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'report_feed/check/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Check Report Feed: ${response.statusCode}');
      //print('data : ${response.body}');
      return response.body;
    }
    return response.body;
  }
}
