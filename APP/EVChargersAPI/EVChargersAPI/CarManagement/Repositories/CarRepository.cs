using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.CarManagement.Repositories
{
    public interface ICarRepository : IRepository<Car>
    {
        Task<Car> GetById(Guid id);
        object SetPersonsCar(UsersCars usersCars);
        Task<IEnumerable<UsersCars>> GetUsersCars(Guid userId);
    }
    public class CarRepository : ICarRepository
    {
        private readonly EVChargersContext _context;

        public CarRepository(EVChargersContext context)
        {
            _context = context;
        }

        public Car Create(Car item)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Car>> GetAll()
        {
            return await _context.Cars.ToListAsync();
        }

        public async Task<Car> GetById(Guid id)
        {
            return await _context.Cars.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<UsersCars>> GetUsersCars(Guid userId)
        {
           return await _context.UsersCars.Where(x => x.UserId == userId).ToListAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public object SetPersonsCar(UsersCars usersCars)
        {
            EntityEntry<UsersCars> entityEntry = _context.UsersCars.Add(usersCars);
            return entityEntry.Entity;
        }

        public Car Update(Car item)
        {
            throw new NotImplementedException();
        }
    }
}
