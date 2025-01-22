class CertificateModel {
  final String username;
  final String certificateUrl;
  final String signImageUrl;
  final DateTime consentDate;
  final bool isConsentGiven;

  CertificateModel({
    required this.username,
    required this.certificateUrl,
    required this.signImageUrl,
    required this.consentDate,
    required this.isConsentGiven,
  });

  // Factory method to create an instance from JSON
  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      username: json['username'],
      certificateUrl: json['certificate'],
      signImageUrl: json['signimage'],
      consentDate: DateTime.parse(json['consent_date']),
      isConsentGiven: json['is_consent_given'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'certificate': certificateUrl,
      'signimage': signImageUrl,
      'consent_date': consentDate.toIso8601String(),
      'is_consent_given': isConsentGiven,
    };
  }
}
