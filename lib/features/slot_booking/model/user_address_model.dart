class UserAddressModel {
  String type;
  String address;

  UserAddressModel({
    required this.type,
    required this.address,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
        type: json["type"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address,
      };
}
