import 'package:flutter_api/data/api/user_api_service.dart';
import 'package:flutter_api/data/models/user_model.dart';

abstract class UserApiRepository {
  Future<List<UserModel>> getUsers();

  Future<UserModel> getUserById(int id);

  Future createUser(UserModel user);

  Future updateUser(UserModel user);

  Future deleteUser(UserModel user);
}

class UserApiRepositoryImpl implements UserApiRepository {
  final UserApiService _userApiService = UserApiService.userApiService;
  //interceptores-->checkInternet

  @override
  Future createUser(UserModel user) {
    return _userApiService.createUser(user);
  }

  @override
  Future deleteUser(UserModel user) {
    return _userApiService.deleteUser(user);
  }

  @override
  Future<UserModel> getUserById(int id) => _userApiService.getUserById(id);

  @override
  Future<List<UserModel>> getUsers() => _userApiService.getUsers();

  @override
  Future updateUser(UserModel user) => _userApiService.updateUser(user);
}

class UserDBRepositoryImpl implements UserApiRepository {
  final UserApiService _userApiService = UserApiService.userApiService;


  @override
  Future createUser(UserModel user) {
    return _userApiService.createUser(user);
  }

  @override
  Future deleteUser(UserModel user) {
    return _userApiService.deleteUser(user);
  }

  @override
  Future<UserModel> getUserById(int id) => _userApiService.getUserById(id);

  @override
  Future<List<UserModel>> getUsers() => _userApiService.getUsers();

  @override
  Future updateUser(UserModel user) => _userApiService.updateUser(user);
}