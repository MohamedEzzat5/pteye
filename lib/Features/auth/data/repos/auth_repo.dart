abstract class AuthRepo
{
  Future<void> loginUser(String email , String password);
  Future<void> registerUser(String email , String password);
}