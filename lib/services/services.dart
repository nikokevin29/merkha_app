import 'dart:convert';
import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:http/http.dart' as http;
import 'package:merkha_app/models/models.dart';
import 'package:path/path.dart';



part 'product_service.dart';
part 'user_service.dart';

String baseURL = "http://192.168.1.12:8000/api/";

String baseURLphoto = "http://192.168.1.12:8000/storage/";
