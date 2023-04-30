class RegisterResult {
  final String message;
  final int statusCode;
  final String? typeUser;
  final String? token;

  RegisterResult(
      {required this.message,
      required this.statusCode,
      this.typeUser,
      this.token});
}
