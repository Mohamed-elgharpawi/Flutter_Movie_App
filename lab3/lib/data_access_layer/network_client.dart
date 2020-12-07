import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:lab3/data_access_layer/model/movie.dart';

class HttpClient{


  Future<dynamic> get(url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {

      return response;

    } else {

      return Future.error(Error());
    }
  }

}