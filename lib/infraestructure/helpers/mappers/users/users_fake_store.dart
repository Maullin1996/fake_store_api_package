///Api fake store response to convert Dart object using QuickType.
class UsersFakeStore {
  final ApiAddress apiAddress;
  final int id;
  final String email;
  final String username;
  final String password;
  final ApiName apiName;
  final String phone;

  UsersFakeStore({
    required this.apiAddress,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.apiName,
    required this.phone,
  });

  factory UsersFakeStore.fromJson(Map<String, dynamic> json) => UsersFakeStore(
    apiAddress: ApiAddress.fromJson(json["address"]),
    id: json["id"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    apiName: ApiName.fromJson(json["name"]),
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": apiAddress.toJson(),
    "id": id,
    "email": email,
    "username": username,
    "password": password,
    "name": apiName.toJson(),
    "phone": phone,
  };
}

class ApiAddress {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  ApiAddress({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory ApiAddress.fromJson(Map<String, dynamic> json) => ApiAddress(
    city: json["city"],
    street: json["street"],
    number: json["number"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "street": street,
    "number": number,
    "zipcode": zipcode,
  };
}

class ApiName {
  final String firstname;
  final String lastname;

  ApiName({required this.firstname, required this.lastname});

  factory ApiName.fromJson(Map<String, dynamic> json) =>
      ApiName(firstname: json["firstname"], lastname: json["lastname"]);

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
  };
}
