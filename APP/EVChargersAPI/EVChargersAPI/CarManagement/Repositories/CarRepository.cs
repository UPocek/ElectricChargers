using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;

namespace EVChargersAPI.CarManagement.Repositories
{
    public interface ICarRepository : IRepository<Car>
    {
        Task<Car> GetById(Guid id);
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

        public void Save()
        {
            _context.SaveChanges();
        }

        public Car Update(Car item)
        {
            throw new NotImplementedException();
        }
    }
}
