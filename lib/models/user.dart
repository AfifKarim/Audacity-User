class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String job;
  final String city;
  final String zipcode;
  final double latitude;
  final String profilePicture;
  final String phone;
  final String street;
  final String state;
  final String country;
  final double longitude;
  bool isFavorite;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.job,
    required this.city,
    required this.zipcode,
    required this.latitude,
    required this.profilePicture,
    required this.phone,
    required this.street,
    required this.state,
    required this.country,
    required this.longitude,
    this.isFavorite = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      job: json['job'],
      city: json['city'],
      zipcode: json['zipcode'],
      latitude: json['latitude'],
      profilePicture: json['profile_picture'],
      phone: json['phone'],
      street: json['street'],
      state: json['state'],
      country: json['country'],
      longitude: json['longitude'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  User copyWith({bool? isFavorite}) {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      dateOfBirth: dateOfBirth,
      job: job,
      city: city,
      zipcode: zipcode,
      latitude: latitude,
      profilePicture: profilePicture,
      phone: phone,
      street: street,
      state: state,
      country: country,
      longitude: longitude,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
