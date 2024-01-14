import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<User> users = [];
  int page = 1;
  bool isLoading = false;
  int limitPerPage = 10; // Set the number of items to be fetched per page

  Future<void> fetchUsers({int offset = 0, int limit = 10}) async {
    print('fetchUsers Offset: $offset, fetchUsers Limit: $limit');
    try {
      if (isLoading) return; // Prevent multiple simultaneous requests
      isLoading = true;

      final userList = await _apiService.getUsers(offset: offset, limit: limit);
      print('Fetched users: $userList');
      if (offset == 0) {
        users = userList; // Replace the current list only if it's the first page
      } else {
        users = userList; // Replace the existing list for subsequent pages
      }

      // Retrieve favorites from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favorites = prefs.getStringList('favorites') ?? [];

      // Mark users as favorites based on the stored list
      users.forEach((user) {
        user.isFavorite = favorites.contains(user.id.toString());
      });

      notifyListeners();

      isLoading = false;
      if (offset == 0) {
        // Reset the page value when fetching data for a new page
        page = 1;
      }
    } catch (error) {
      isLoading = false;
      throw error;
    }
  }

  Future<void> toggleFavoriteStatus(User user) async {
    user = user.copyWith(isFavorite: !user.isFavorite);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (user.isFavorite) {
      favorites.add(user.id.toString());
    } else {
      favorites.remove(user.id.toString());
    }

    prefs.setStringList('favorites', favorites);
    notifyListeners();
  }
}
