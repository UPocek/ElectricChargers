using Data.Context;
using Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

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

        public User Create(User item)
        {
            EntityEntry<User> entityEntry = _context.Users.Add(item);
            return entityEntry.Entity;
        }

        public async Task<IEnumerable<User>> GetAll()
        {
            return await _context.Users.ToListAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }
    }

   
}
