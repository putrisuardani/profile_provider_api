class Profile {
  String id;
  String name;
  String phone;
  String profilePhoto;
  String coverPhoto;
  String quote;

  Profile({
    required this.id,
    required this.name,
    required this.phone,
    required this.profilePhoto,
    required this.coverPhoto,
    required this.quote,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'] ?? '',
      name: json['name'],
      phone: json['phone'],
      profilePhoto: json['profilePhoto'],
      coverPhoto: json['coverPhoto'],
      quote: json['quote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'profilePhoto': profilePhoto,
      'coverPhoto': coverPhoto,
      'quote': quote,
    };
  }
}
