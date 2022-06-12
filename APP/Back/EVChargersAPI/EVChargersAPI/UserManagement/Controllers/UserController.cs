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
        
        [HttpPost]
        public async Task<ActionResult<User>> Add(User user)
        {
            User createdUser = await _userService.Create(user);
            return Ok(createdUser);
        }

        [HttpGet]
        [Route("/login")]
        public async Task<ActionResult<User>> Login(string email, string password)
        {
            User loggedUser = await _userService.Login(email, password);
            if (loggedUser == null)
                return NotFound();
            return Ok(loggedUser);
        }

        [HttpGet]
        [Route("/getbyId")]
        public async Task<ActionResult<User>> GetById(Guid id)
        {
            User user = await _userService.GetById(id);
            if (user == null)
                return NotFound();
            return Ok(user);
        }
    }
}
