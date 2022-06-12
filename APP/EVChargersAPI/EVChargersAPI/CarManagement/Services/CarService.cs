using Data.Entities;
using EVChargersAPI.CarManagement.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.CarManagement.Services
{
    public interface ICarService : IService<Car>
    {
        Task<Car> GetById(Guid id);
    }

    public class CarService : ICarService
    {
        private readonly ICarRepository _carRepository;
        public CarService(ICarRepository carRepository)
        {
            _carRepository = carRepository;
        }

        public async Task<IEnumerable<Car>> GetAll()
        {
            return await _carRepository.GetAll();
        }

        public async Task<Car> GetById(Guid id)
        {
            return await _carRepository.GetById(id);
        }
    }
}
