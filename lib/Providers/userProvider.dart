import 'dart:convert';
import 'package:Life_Connect_admin/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<UserModel> user = [];
  List<UserModel> filteredUser = [];
  bool _isLoading = false;
  String? errorMessage;

  bool get isLoading => _isLoading; // Getter for _isLoading

  // Fetch user from the API
  Future<void> loadUser() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://lifeproject.pythonanywhere.com/hospital/donors/'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = List<UserModel>.from(data.map((x) => UserModel.fromJson(x)));
        filteredUser = List.from(user); // Initialize filtered user
      } else {
        throw Exception(
            'Failed to load user. Server returned ${response.statusCode}');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch user: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search user by query
  void searchUser(String query) {
    if (query.isEmpty) {
      filteredUser = List.from(user); // Show all user if the query is empty
    } else {
      filteredUser = user.where((user) {
        final lowerQuery = query.toLowerCase();
        return user.name.toLowerCase().contains(lowerQuery) || // Match name
            user.bloodGroup
                .toLowerCase()
                .contains(lowerQuery) || // Match blood group
            user.address.toLowerCase().contains(lowerQuery); // Match address
      }).toList();
    }
    notifyListeners();
  }

  Future<void> deleteUser(int userId, BuildContext context) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse(
            'https://lifeproject.pythonanywhere.com/hospital/donors/$userId/'),
      );
      if (response.statusCode == 204) {
        Navigator.pop(context);
        loadUser();
      } else {
        throw Exception(
            'Failed to delete hospital. Server returned ${response.statusCode}');
      }
    } catch (error) {
      errorMessage = 'Failed to delete hospital: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter user by blood group
  void filterByBloodGroup(String group) {
    if (group == 'All') {
      filteredUser = List.from(user); // Show all user if "All" is selected
    } else {
      filteredUser = user.where((user) {
        return user.bloodGroup.toLowerCase() == group.toLowerCase();
      }).toList();
    }
    notifyListeners();
  }
}
