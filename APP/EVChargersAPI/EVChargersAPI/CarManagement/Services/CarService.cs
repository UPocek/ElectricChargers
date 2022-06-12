using Data.Entities;
using EVChargersAPI.CarManagement.Repositories;
using EVChargersAPI.UserManagement.Repositories;
using EVChargersAPI.UserManagement.Services;
using System.Linq;

namespace EVChargersAPI.CarManagement.Services
{
    public interface ICarService : IService<Car>
    {
        Task<Car> GetById(Guid id);
        Task<UsersCars> SetUsersCar(Guid userId, Guid carId);
        Task<IEnumerable<Car>> GetUsersCars(Guid userId);
    }

    public class CarService : ICarService
    {
        private readonly ICarRepository _carRepository;
        private readonly IUserRepository _userRepository;
        public CarService(ICarRepository carRepository, IUserRepository userRepository)
        {
            _carRepository = carRepository;
            _userRepository = userRepository;
        }

        public async Task<IEnumerable<Car>> GetAll()
        {
            return await _carRepository.GetAll();
        }

        public async Task<Car> GetById(Guid id)
        {
            return await _carRepository.GetById(id);
        }

        public async Task<IEnumerable<Car>> GetUsersCars(Guid userId)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User do not exist.");

            IEnumerable<UsersCars> usersCars = await _carRepository.GetUsersCars(userId);
            List<Car> cars = new List<Car>();
            foreach (var item in usersCars)
                cars.Add(await _carRepository.GetById(item.CarId));
            return cars;
        }

        public async Task<UsersCars> SetUsersCar(Guid userId, Guid carId)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User do not exist.");

            Car car = await _carRepository.GetById(carId);
            if (car == null) throw new Exception("Car do not exist.");

            UsersCars usersCars = new UsersCars
            {
                Id = Guid.NewGuid(),
                CarId = carId,
                UserId = userId
            };

            _ = _carRepository.SetPersonsCar(usersCars);
            _carRepository.Save();
            return usersCars;
        }
    }
}
