import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_api/config/api_conf.dart';
import 'package:flutter_api/data/models/post_model.dart';

import 'dart:developer' as developer;

class PostApiService {
  static final PostApiService postApiService = PostApiService._();

  PostApiService._();

  static final String _endpoint = '${CONFIG['API_URL']}posts/';

  Future<List<PostModel>> getPost() async {
    final response = await http.get(_endpoint);

    if (response.statusCode == 200) {
      developer.log(response.body, name: 'post.com');
//      return PostModel.fromJson(json.decode(response.body));
      return json.decode(response.body).map<PostModel>((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los posts');
    }
  }
}
