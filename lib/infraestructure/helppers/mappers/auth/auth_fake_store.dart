class TokenFakeStore {
  final String token;

  TokenFakeStore({required this.token});

  factory TokenFakeStore.fromJson(Map<String, dynamic> json) =>
      TokenFakeStore(token: json["token"]);

  Map<String, dynamic> toJson() => {"token": token};
}
