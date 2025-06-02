class CarBrand {
  final String id;
  final String brand;
  final List<CarModel>? cars;

  CarBrand({required this.id, required this.brand, this.cars});

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      id: json['id'],
      brand: json['brand'],
      cars: json['cars'] != null
          ? List<Map<String, dynamic>>.from(json['cars']).map((car) => CarModel.fromJson(car)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'cars': cars?.map((e) => e.toJson()).toList(),
    };
  }
}

class CarModel {
  final String model;
  final String type;

  CarModel({required this.model, required this.type});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      model: json['model'],
      type: json['type'],
    );
  }

  Map<String, String> toJson() {
    return {
      'model': model,
      'type': type,
    };
  }
}
