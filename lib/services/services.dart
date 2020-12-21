import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:merkha_app/models/models.dart';

part 'user_service.dart';
part 'product_service.dart';

String baseURL = "http://172.28.16.1:8000/api/";

String baseURLphoto = "http://172.28.16.1/storage/";
