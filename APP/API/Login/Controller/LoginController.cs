#nullable disable
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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