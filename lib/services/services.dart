import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:http/http.dart' as http;
import 'package:merkha_app/models/models.dart';
import 'package:path/path.dart';

part 'product_service.dart';
part 'user_service.dart';
part 'address_service.dart';
part 'user_interest_service.dart';
part 'merchant_service.dart';
part 'wishlist_service.dart';
part 'voucher_service.dart';
part 'following_service.dart';
part 'feed_service.dart';
part 'comment_service.dart';
part 'appcontent_service.dart';
part 'order_service.dart';
part 'payment_service.dart';

String baseURL = "http://192.168.0.56:8000/api/";

String baseURLphoto = "http://192.168.0.56:8000/storage/";

String apiRajaOngkir = "https://api.rajaongkir.com/starter/";
String apiKeyOngkir = "7facf87ad54c821e568ef658f3fa79d6";
