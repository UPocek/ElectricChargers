public class LoginService : ILoginService
{
    private ILoginRepository _loginRepository;

    public LoginService()
    {
        _loginRepository = new LoginRepository();
    }

    public async Task CreateUser(User user)
    {
        await _loginRepository.InsertUser(user);
    }
}