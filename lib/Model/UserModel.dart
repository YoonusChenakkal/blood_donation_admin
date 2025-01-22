class UserModel {
  final int id;
  final String name;
  final String email;
  final int contactNumber;
  final String address;
  final String idProof;
  final String? image; // Nullable as not all donors have a profile image
  final String bloodGroup;
  final bool willingToDonateOrgan;
  final dynamic organsToDonate;
  final bool willingToDonateBlood;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.idProof,
    this.image, // Nullable field
    required this.bloodGroup,
    required this.willingToDonateOrgan,
    required this.organsToDonate,
    required this.willingToDonateBlood,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["user"],
        email: json["email"],
        contactNumber: json["contact_number"],
        address: json["address"],
        idProof: json["id_proof"],
        image: json["profile_image"], // Parse the profile image
        bloodGroup: json["blood_group"],
        willingToDonateOrgan: json["willing_to_donate_organ"],
        organsToDonate: json["organs_to_donate"],
        willingToDonateBlood: json["willing_to_donate_blood"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": name,
        "email": email,
        "contact_number": contactNumber,
        "address": address,
        "id_proof": idProof,
        "profile_image": image, // Include the profile image in JSON
        "blood_group": bloodGroup,
        "willing_to_donate_organ": willingToDonateOrgan,
        "organs_to_donate": organsToDonate,
        "willing_to_donate_blood": willingToDonateBlood,
        "created_at": createdAt.toIso8601String(),
      };
}
