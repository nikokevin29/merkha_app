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

String baseURL = "http://192.168.0.103:8000/api/";

String baseURLphoto = "http://192.168.1.12:8000/storage/";

String apiRajaOngkir  = "https://api.rajaongkir.com/starter/";
String apiKeyOngkir   = "7facf87ad54c821e568ef658f3fa79d6";
