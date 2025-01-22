import 'dart:convert';
import 'package:Life_Connect_admin/Model/certificateModel.dart';
import 'package:Life_Connect_admin/Model/certificateModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CertificateProvider extends ChangeNotifier {
  List<CertificateModel> certificates = [];
  List<CertificateModel> filteredCertificates = [];
  bool _isLoading = false;
  String? errorMessage;

  bool get isLoading => _isLoading; // Getter for _isLoading

  // Fetch certificates from the API
  Future<void> fetchCertificates() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://lifeproject.pythonanywhere.com/donor/consent/'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        certificates = List<CertificateModel>.from(
            data.map((x) => CertificateModel.fromJson(x)));
        filteredCertificates =
            List.from(certificates); // Initialize filtered certificates
      } else {
        throw Exception(
            'Failed to load certificates. Server returned ${response.statusCode}');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch certificates: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search certificates by query
  void searchcertificates(String query) {
    if (query.isEmpty) {
      filteredCertificates = List.from(
          certificates); // Show all certificates if the query is empty
    } else {
      filteredCertificates = certificates.where((certificate) {
        final lowerQuery = query.toLowerCase();
        return certificate.username
            .toLowerCase()
            .contains(lowerQuery); // Match address
      }).toList();
    }
    notifyListeners();
  }
}
