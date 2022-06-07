using Data.Entities;
using EVChargersAPI.UserManagement.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.UserManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetAll()
        {
            IEnumerable<User> users = await _userService.GetAll();
            return Ok(users);
        }

    }
}
