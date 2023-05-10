class LoginRequest {
  final String phone;
  final String password;

  LoginRequest({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class RegisterRequest {
  final String phone;
  final String password;
  final String username;
  final String address;
  final String email;
  final int age;
  final String fullName;

  RegisterRequest({
    required this.phone,
    required this.email,
    required this.password,
    required this.address,
    required this.username,
    required this.age,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'username': username,
      'email': email,
      'address': address,
      'age': age,
      'fullname': fullName,
    };
  }
}
