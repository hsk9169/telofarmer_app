class AuthEntity {
  final String? id;
  final List<int>? authority;
  final String? accessToken;

  AuthEntity({
    this.id,
    this.authority,
    this.accessToken,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json, String accessToken) {
    return AuthEntity(
      id: json['id'],
      authority: json['authority']
          .map<int>((dynamic element) => int.parse(element.toString()))
          .toList(),
      accessToken: accessToken,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'authority': authority,
        'accessToken': accessToken,
      };
}
