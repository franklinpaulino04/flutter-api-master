import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_api/config/api_conf.dart';
import 'package:flutter_api/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static final UserApiService userApiService = UserApiService._();

  UserApiService._();

  static final String _endpoint = '${CONFIG['API_URL']}users/';

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(_endpoint);

    if (response.statusCode == 200) {
      //developer.log(response.body, name: 'user.com.getUsers');
      return json
          .decode(response.body)
          .map<UserModel>((json) => UserModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al cargar los users');
    }
  }

  Future<int> getLengthUsers() async {
    final response = await http.get(_endpoint);

    if (response.statusCode == 200) {
      int t = json
          .decode(response.body)
          .map<UserModel>((json) => UserModel.fromJson(json))
          .toList()
          .length;
      developer.log(t.toString(), name: 'user.com.getLengthUsers');
      return t;
    } else {
      throw Exception('Error al cargar los posts');
    }
  }

  Future<UserModel> getUserById(int id) async {
    final response = await http.get(_endpoint + id.toString());

    if (response.statusCode == 200) {
      developer.log(response.body, name: 'user.com.getUserById');
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future createUser(UserModel user) async {
    final response = await http.post(_endpoint,
        headers: {"Content-Type": "application/json"}, body: json.encode(user));
    developer.log(response.body, name: 'user.com.createUser');
    return response.body;
  }

  Future updateUser(UserModel user) async {
    final response = await http.put(_endpoint + user.id.toString(),
        headers: {"Content-Type": "application/json"}, body: json.encode(user));
    developer.log(response.body, name: 'user.com.updateUser');
    return response.body;
  }

  Future deleteUser(UserModel user) async {
    final response = await http.delete(_endpoint + user.id.toString(),
        headers: {"Content-Type": "application/json"});
    developer.log(response.statusCode.toString(), name: 'user.com.deleteUser');
    return response.body;
  }
}
