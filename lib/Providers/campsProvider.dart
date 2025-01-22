import 'dart:convert';
import 'dart:io';
import 'package:Life_Connect_admin/Model/campModel.dart';
import 'package:Life_Connect_admin/Model/campRegistrationsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Campsprovider extends ChangeNotifier {
  List<CampsModel> camp = [];
  bool _isLoading = false;
  String? errorMessage;
  List<CampRegistrationsModel> campRegistrations = [];

  bool get isLoading => _isLoading;

  // Fetch camps and notify listeners
  fetchCamps(BuildContext context) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            'https://lifeproject.pythonanywhere.com/hospital/hospital/blood-donation-camps/'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        camp.clear(); // Clear the existing camps
        camp = List<CampsModel>.from(data.map((x) => CampsModel.fromJson(x)));
      } else {
        errorMessage =
            'Failed to load camps. Server returned ${response.statusCode}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage!),
          duration: const Duration(seconds: 2),
        ));
      }
    } on SocketException {
      errorMessage = 'No Internet connection. Please try again later.';
    } catch (error) {
      errorMessage = 'Failed to fetch camps: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  fetchRegistrations(
    int? campId,
    BuildContext context,
  ) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            'https://lifeproject.pythonanywhere.com/hospital/camps/${campId}/donors/'),
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        campRegistrations.clear(); // Clear the existing camps

        final parsedCampRegistration = CampRegistrationsModel.fromJson(data);

        campRegistrations.add(parsedCampRegistration);
      } else {
        errorMessage =
            'Failed to load camps. Server returned ${response.statusCode}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage!),
          duration: const Duration(seconds: 2),
        ));
      }
    } on SocketException {
      errorMessage = 'No Internet connection. Please try again later.';
    } catch (error) {
      errorMessage = 'Failed to fetch camps: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  deleteCamp(
    int? campId,
    String? hospitalName,
    BuildContext context,
  ) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse(
            'https://lifeproject.pythonanywhere.com/hospital/hospital/blood-donation-camps/$hospitalName/$campId/'),
      );

      if (response.statusCode == 204) {
        fetchCamps(context);
        Navigator.pop(context);
      } else {
        errorMessage = 'Failed to Delete ${response.statusCode}';
        
      }
    } on SocketException {
      errorMessage = 'No Internet connection. Please try again later.';
    } catch (error) {
      errorMessage = 'Failed to Delete: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage!),
        duration: const Duration(seconds: 2),
      ));
      errorMessage = null;
    }
  }
}
