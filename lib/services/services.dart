import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:merkha_app/models/models.dart';

part 'user_service.dart';
part 'product_service.dart';

String baseURL = "http://192.168.1.2:8000/api/";

String baseURLphoto = "http://192.168.1.2:8000/storage/";
