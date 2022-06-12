using Data.Context;
using Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.UserManagement.Repositories
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> Login(string email, string password);
        Task<User> GetById(Guid id);

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

        public async Task<User> GetById(Guid id)
        {
            return await _context.Users.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<User> Login(string email, string password)
        {
            return await _context.Users.Where(x => x.Email == email && x.Password == password).FirstOrDefaultAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }
    }
    
}
