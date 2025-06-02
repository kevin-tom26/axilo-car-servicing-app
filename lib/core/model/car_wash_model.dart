class CarWashModel {
  String id;
  String thumbnail;
  String name;
  String? distance;
  String address;
  Latlong latlong;
  int waitTime;
  double minPrice;
  double maxPrice;
  double rating;
  String about;
  String providerImage;
  String providerName;
  String providerType;
  String phone;
  String whatsapp;
  List<Service> services;
  List<String> gallery;
  List<Review> reviews;

  CarWashModel({
    required this.id,
    required this.thumbnail,
    required this.name,
    this.distance = "-",
    required this.address,
    required this.latlong,
    required this.waitTime,
    required this.minPrice,
    required this.maxPrice,
    required this.rating,
    required this.about,
    required this.providerImage,
    required this.providerName,
    required this.providerType,
    required this.phone,
    required this.whatsapp,
    required this.services,
    required this.gallery,
    required this.reviews,
  });

  factory CarWashModel.fromJson(Map<String, dynamic> json) => CarWashModel(
        id: json["id"],
        thumbnail: json["thumbnail"],
        name: json["name"],
        // distance: json["distance"],
        address: json["address"],
        latlong: Latlong.fromJson(json["latlong"]),
        waitTime: json["wait_time"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        rating: json["rating"]?.toDouble(),
        about: json["about"],
        providerImage: json["provider_image"],
        providerName: json["provider_name"],
        providerType: json["provider_type"],
        phone: json["phone"],
        whatsapp: json["whatsapp"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "name": name,
        //"distance": distance,
        "address": address,
        "latlong": latlong.toJson(),
        "wait_time": waitTime,
        "min_price": minPrice,
        "max_price": maxPrice,
        "rating": rating,
        "provider_image": providerImage,
        "provider_name": providerName,
        "provider_type": providerType,
        "phone": phone,
        "whatsapp": whatsapp,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Latlong {
  double latitude;
  double longitude;

  Latlong({
    required this.latitude,
    required this.longitude,
  });

  factory Latlong.fromJson(Map<String, dynamic> json) => Latlong(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Review {
  int rating;
  String? profileImg;
  String comment;
  DateTime date;
  String reviewerName;
  String reviewerEmail;

  Review({
    required this.rating,
    this.profileImg,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        profileImg: json["profile_img"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "profile_img": profileImg,
        "comment": comment,
        "date": date.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
      };
}

class Service {
  String id;
  String name;
  double price;
  int duration;
  String description;

  Service(
      {required this.id, required this.name, required this.price, required this.duration, required this.description});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
      id: json["id"],
      name: json["name"],
      price: json["price"]?.toDouble(),
      duration: json["duration"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "duration": duration,
        "description": description,
      };
}
