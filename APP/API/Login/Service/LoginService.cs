using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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