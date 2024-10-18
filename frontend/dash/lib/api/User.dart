import 'dart:convert';

import 'package:http/http.dart' as http;

class UserApi {
  final String baseUrl = 'http://127.0.0.1:3000/api/users';

  Future<Map<String, dynamic>> getUserById(String uid) async {
    final url = Uri.parse('$baseUrl/$uid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {'error': 'User not found'};
    }
  }

  Future<http.Response> createUser(String userName, String id) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: '{"userName": "$userName", "id": "$id"}',
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<Map<String, dynamic>> updateUser(String uid, int money) async {
    final userData = await getUserById(uid);
    String body = '''
      {
        "userName": "${userData['data']['userName']}",
        "distance": ${userData['data']['distance']}, 
        "items": "${userData['data']['items'] ?? ""}",
        "money": ${userData['data']['money'] + money}
      }
    ''';

    final url = Uri.parse('$baseUrl/$uid');
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );


    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(response.body);
      throw Exception('Failed to load user');
    }
  }
}