using Data.Context;
using Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EVChargersAPI.UserManagement.Repositories
{
    public interface IUserRepository : IRepository<User>
    {
    }
    public class UserRepository : IUserRepository
    {
        private readonly EVChargersContext _context;

        public UserRepository(EVChargersContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<User>> GetAll()
        {
            return await _context.Users.ToListAsync();
        }
    }

   
}
