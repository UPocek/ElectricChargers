#nullable disable
using Microsoft.AspNetCore.Mvc;

[Route("api/[controller]")]
[ApiController]
public class LoginController : ControllerBase
{
    private ILoginService _loginService;

    public LoginController()
    {
        _loginService = new LoginService();
    }

    [HttpPost("")]
    public async Task<IActionResult> GetHospitalPolls(User user)
    {
        await _loginService.CreateUser(user);
        return Ok();
    }

}