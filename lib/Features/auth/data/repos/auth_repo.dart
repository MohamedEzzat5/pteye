abstract class AuthRepo
{
  Future<void> loginUser(String email, String password);
  Future<void> registerUser(String email, String password);
  Future<void> saveUserCredentials(String email, String password);
  Future<Map<String, String>> getUserCredentials();

}