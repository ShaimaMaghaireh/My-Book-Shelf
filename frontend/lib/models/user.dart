class User {
  final String name;
  final String email;
  final String password;
 final String profileImage;
 
  User({
    required this.email,
    required this.name,
    required this.password,
    required this.profileImage
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      password: json['password'],
      profileImage:json['profileImage'],
    );
  }

  
}