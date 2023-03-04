import 'dart:convert';
import 'package:client/repository/local_storage_repository.dart';
import 'package:client/utils/constants.dart';
import 'package:client/model/error_model.dart';
import 'package:client/model/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
// import 'package:localstorage/localstorage.dart';

// final LocalStorage storage = LocalStorage('notes');

final noteRepositoryProvider = Provider(
  (ref) => NoteRepository(
    client: Client(),
    localStorageRepository: LocalSecureStorageRepository(),
  ),
);

String removeResBrackets(String res) {
  return res
      .split(':')[1]
      .replaceAll('/', '')
      .replaceAll('}', '')
      .replaceAll('"', '');
}

class NoteRepository {
  final Client _client;
  // final LocalSecureStorageRepository _localStorageRepository;

  NoteRepository({
    required Client client,
    required LocalSecureStorageRepository localStorageRepository,
  }) : _client = client;
  // _localStorageRepository = localStorageRepository;

  Future<ErrorModel> createNote(String token) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      var res = await _client.post(
        Uri.parse('$server/notes/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': "Bearer $token"
        },
        body: jsonEncode({"title": "untitled note"}),
      );
      switch (res.statusCode) {
        case 201:
          error = ErrorModel(
            error: null,
            data: NoteModel.fromJson(res.body),
          );
          break;
        default:
          error = ErrorModel(error: removeResBrackets(res.body), data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getNoteById(String token, String id) async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      var res = await _client.get(Uri.parse('$server/notes/$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': "Bearer $token"
      });
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(error: null, data: NoteModel.fromJson(res.body));
          break;
        default:
          error = ErrorModel(error: removeResBrackets(res.body), data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getNotes(String token) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      var res = await _client.get(Uri.parse('$server/notes/'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': "Bearer $token"
      });

      switch (res.statusCode) {
        case 200:
          List<NoteModel> notes = [];

          for (int i = 0; i < jsonDecode(res.body)['count']; i++) {
            notes.add(NoteModel.fromJson(
                jsonEncode(jsonDecode(res.body)['notes'][i])));
          }
          // storage.setItem('notes', notes); // delete this --
          // print(storage.getItem('notes')); // delete this --
          error = ErrorModel(error: null, data: notes);
          break;
        default:
          error = ErrorModel(error: removeResBrackets(res.body), data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> updateNote(
      {required String token,
      required String id,
      required String title,
      required List<dynamic> content}) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      var res = await _client.patch(
        Uri.parse('$server/notes/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': "Bearer $token"
        },
        body: jsonEncode({"title": title, "content": content}),
      );
      switch (res.statusCode) {
        case 201:
          error = ErrorModel(error: null, data: "Success!");
          break;
        default:
          error = ErrorModel(error: removeResBrackets(res.body), data: null);
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> deleteNote(String token, String id) async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      var res = await _client.delete(Uri.parse('$server/notes/$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': "Bearer $token"
      });

      switch (res.statusCode) {
        case 200:
          error = ErrorModel(error: null, data: "Success!");
          break;
        default:
          error = ErrorModel(
            error: removeResBrackets(res.body),
            data: null,
          );
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
