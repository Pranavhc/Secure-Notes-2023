import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/model/error_model.dart';
import 'package:client/model/user.dart';
import 'package:client/repository/local_storage_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  ((ref) => AuthRepository(
        client: Client(),
        localStorageRepository: LocalStorageRepository(),
      )),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final Client _client;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository({
    required Client client,
    required LocalStorageRepository localStorageRepository,
  })  : _client = client,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> registerWithEmail(
      String name, String email, String password) async {
    ErrorModel error =
        ErrorModel(error: "some unexpected error occured.", data: null);

    try {
      var res = await _client.post(Uri.parse('$server/auth/register'),
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
            "profilePic": ''
          }),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      switch (res.statusCode) {
        case 201:
          final newUser = UserModel(
            name: jsonDecode(res.body)['user']['name'],
            email: jsonDecode(res.body)['user']['email'],
            userId: jsonDecode(res.body)['user']['_id'],
            token: jsonDecode(res.body)['token'],
          );

          error = ErrorModel(error: null, data: newUser);
          _localStorageRepository.setToken(newUser.token);
          break;
        default:
          error = ErrorModel(
              error: res.body
                  .split(':')[1]
                  .replaceAll('/', '')
                  .replaceAll('}', '')
                  .replaceAll('"', ''),
              data: null);
      }
      // print("res body - ${res.body}"); // remove this later
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> loginWithEmail(String email, String password) async {
    ErrorModel error =
        ErrorModel(error: "some unexpected error occured.", data: null);

    try {
      var res = await _client.post(Uri.parse('$server/auth/login'),
          body: jsonEncode({"email": email, "password": password}),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      switch (res.statusCode) {
        case 200:
          final newUser = UserModel(
            name: jsonDecode(res.body)['user']['name'],
            email: jsonDecode(res.body)['user']['email'],
            userId: jsonDecode(res.body)['user']['_id'],
            token: jsonDecode(res.body)['token'],
          );

          error = ErrorModel(error: null, data: newUser);
          _localStorageRepository.setToken(newUser.token);
          break;
        default:
          error = ErrorModel(
              error: res.body
                  .split(':')[1]
                  .replaceAll('/', '')
                  .replaceAll('}', '')
                  .replaceAll('"', ''),
              data: null);
      }
      // print("res body - ${res.body}"); // remove this later
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(error: "some error occured!", data: null);

    try {
      String? token = await _localStorageRepository.getToken();
      if (token != null) {
        var res = await _client.get(Uri.parse('$server/auth/login'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': "Bearer $token"
        });

        switch (res.statusCode) {
          case 200:
            final newUser =
                UserModel.fromJson(jsonEncode(jsonDecode(res.body)['user']))
                    .copyWith(token: token);
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;

          default:
            error = ErrorModel(
                error: res.body
                    .split(':')[1]
                    .replaceAll('/', '')
                    .replaceAll('}', '')
                    .replaceAll('"', ''),
                data: null);
        }
        // print("res body - ${res.body}"); // remove this later
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
