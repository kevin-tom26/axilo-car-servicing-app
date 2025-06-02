class UserModel {
  dynamic id;
  dynamic firebaseUid;
  dynamic name;
  dynamic profileImage;
  dynamic email;
  dynamic phone;

  UserModel({
    this.id,
    this.firebaseUid,
    this.name,
    this.profileImage,
    this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firebaseUid: json['firebaseUid'],
      name: json['name'],
      profileImage: json['profileImage'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'firebaseUid': firebaseUid,
        'name': name,
        'profileImage': profileImage,
        'email': email,
        'phone': phone
      };
}
