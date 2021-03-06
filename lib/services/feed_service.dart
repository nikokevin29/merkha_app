part of 'services.dart';

class FeedServices {
  static Future<ApiReturnValue<List<Feed>>> showAllFeedFollowed(
      {int start, int end, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showall/' + start.toString() + '/' + end.toString();
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Get All Feed : ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<int> createFeed(
      {File urlPhoto,
      String idProduct,
      String caption,
      String location,
      http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    //Upload Photo Firebase
    String urlpicture;
    String fileName = basename(urlPhoto.path);
    fb_storage.Reference firebaseStorageref =
        fb_storage.FirebaseStorage.instance.ref('user_feed').child(fileName);
    fb_storage.UploadTask uploadTask = firebaseStorageref.putFile(urlPhoto);

    fb_storage.TaskSnapshot taskSnapshot = await uploadTask;
    var downurl = await (taskSnapshot).ref.getDownloadURL();
    print(taskSnapshot);
    urlpicture = downurl.toString(); // url link photo uploaded
    print('URL PHOTO UPLOADED ' + idProduct.toString() + urlpicture);
    //End Of Upload Photo Firebase
    // print(feed.idProduct.toString());
    // print(feed.caption);
    // print(feed.location);
    String url = baseURL + 'feed/create';
    if (idProduct != 'null') {
      var response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + User.token,
        },
        body: jsonEncode(<String, String>{
          'id_product': idProduct.toString(), //nullable
          'url_image': urlpicture, //required
          'caption': caption, //required
          'location': location, //nullable
        }),
      );
      if (response.statusCode != 200) {
        print('StatusCode : ${response.statusCode}');
        print('data : ${response.body}');
        return 0;
      }
      var data = jsonDecode(response.body);
      print(data);
      //Feed value = Feed.fromJson(data['data']);
      return 1;
    } else {
      var response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + User.token,
        },
        body: jsonEncode(<String, String>{
          //'id_product': idProduct.toString(), //nullable
          'url_image': urlpicture, //required
          'caption': caption, //required
          'location': location, //nullable
        }),
      );
      if (response.statusCode != 200) {
        print('StatusCode : ${response.statusCode}');
        print('data : ${response.body}');
        return 0;
      }
      var data = jsonDecode(response.body);
      print(data);
      //Feed value = Feed.fromJson(data['data']);
      return 1;
    }
  }

  static Future<ApiReturnValue<List<Feed>>> showOwnFeed({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showownfeed';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Get Own Feed : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<ApiReturnValue<List<Feed>>> showFeedByMerchantId(
      {String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showfeedbyid/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Get Own Feed : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<ApiReturnValue<List<Feed>>> showFeedByBestSeller(
      {String limit, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showbestseller/' + limit;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Feed Best Seller: ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<ApiReturnValue<List<Feed>>> showFeedRandom(
      {String limit, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showrandom/' + limit;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Feed Random: ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<ApiReturnValue<List<Feed>>> showFeedByUserId(
      {String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showbyuserid/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode Get Feed By User Id: ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }

  static Future<ApiReturnValue<List<Feed>>> showFeedByMerchantCategory(
      {String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showfeedbymerchantcategory/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode showfeedbymerchantcategory : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    print(response.body);
    List<Feed> feed = (data['data'] as Iterable).map((e) => Feed.fromJson(e)).toList();
    return ApiReturnValue(value: feed);
  }
}
