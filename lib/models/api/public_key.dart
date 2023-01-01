class PublicKey {
  final String format;
  final String crypto;
  final String padding;
  final String publicKey;

  PublicKey({
    required this.format,
    required this.crypto,
    required this.padding,
    required this.publicKey,
  });

  factory PublicKey.fromJson(Map<String, dynamic> json) {
    return PublicKey(
      format: json['format'],
      crypto: json['crypto'],
      padding: json['padding'],
      publicKey: json['publicKey'],
    );
  }

  Map<String, dynamic> toJson() => {
    'format': format,
    'crypto': crypto,
    'padding': padding,
    'publicKey': publicKey,
  };
}