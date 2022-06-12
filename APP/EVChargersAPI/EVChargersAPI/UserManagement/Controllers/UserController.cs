using Data.Entities;
using EVChargersAPI.DTO;
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
        public async Task<ActionResult<User>> Create(CreateUserDTO dto)
        {
            User createdUser = await _userService.Create(dto);
            return Ok(createdUser);
        }

        [HttpGet]
        [Route("login")]
        public async Task<ActionResult<User>> Login(string email, string password)
        {
            User loggedUser = await _userService.Login(email, password);
            if (loggedUser == null)
                return NotFound();
            return Ok(loggedUser);
        }

        [HttpGet]
        [Route("getbyId")]
        public async Task<ActionResult<User>> GetById(Guid id)
        {
            User user = await _userService.GetById(id);
            if (user == null)
                return NotFound();
            return Ok(user);
        }

        [HttpPut]
        [Route("bankCard")]
        public async Task<ActionResult<User>> SetBankCard(InsertingCreditCardDTO dto)
        {
            User user;
            try
            {
                user = await _userService.SetBankCard(dto);
            }
            catch (Exception)
            {
                return NotFound();
            }
            return Ok(user);
        }
    } 
}
