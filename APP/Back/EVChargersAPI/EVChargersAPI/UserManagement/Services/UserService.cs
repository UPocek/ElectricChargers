using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;

namespace EVChargersAPI.UserManagement.Services
{
    public interface IUserService : IService<User>
    {
        Task<User> Login(string email, string password);
    }

    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<User> Create(User item)
        {
            item.Id = Guid.NewGuid();
            User createdUser = _userRepository.Create(item);
            _userRepository.Save();
            return createdUser;
        }

        public async Task<IEnumerable<User>> GetAll()
        {
            return await _userRepository.GetAll();
        }

        public async Task<User> Login(string email, string password)
        {
            return await _userRepository.Login(email, password);
        }
    }
}
