class SignInEntity {
  final String accessToken;
  final String tokenType;
  final String role;
  final String? details;

  SignInEntity(
      {required this.accessToken,
      required this.tokenType,
      required this.role,
      this.details});
}
