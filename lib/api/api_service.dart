import 'package:dio/dio.dart';

import '../models/user.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<User>> getUsers({int offset = 0, int limit = 10}) async {
    print('getUsers Offset: $offset, fetchUsers Limit: $limit');
    try {
      final response = await _dio.get(
        'https://api.slingacademy.com/v1/sample-data/users',
        queryParameters: {'_page': offset, '_limit': limit},
      );

      if (response.data.containsKey('users')) {
        List<User> userList = (response.data['users'] as List)
            .map((json) => User.fromJson(json))
            .toList();
        return userList;
      } else {
        throw Exception('Response does not contain users key');
      }
    } catch (error) {
      print('Error fetching users: $error');
      throw Exception('Failed to load users');
    }
  }
}


