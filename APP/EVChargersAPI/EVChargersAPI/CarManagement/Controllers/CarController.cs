using Data.Entities;
using EVChargersAPI.CarManagement.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.CarManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CarController : ControllerBase
    {
        private readonly ICarService _carService;

        public CarController(ICarService carService)
        {
            _carService = carService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Car>>> GetAll()
        {
            IEnumerable<Car> cars = await _carService.GetAll();
            return Ok(cars);
        }

        [HttpGet]
        [Route("getById")]
        public async Task<ActionResult<IEnumerable<Car>>> GetById(Guid id)
        {
            Car car = await _carService.GetById(id);
            return Ok(car);
        }

        [HttpPost]
        [Route("setPersonsCar")]
        public async Task<ActionResult<UsersCars>> SetPersonsCar(Guid userId, Guid carId)
        {
            UsersCars usersCars;
            try
            {
                usersCars = await _carService.SetUsersCar(userId, carId);
            }
            catch (Exception ex)
            {
                return NotFound();
            }
            return Ok(usersCars);
        }

        [HttpGet]
        [Route("getPersonsCars")]
        public async Task<ActionResult<IEnumerable<Car>>> GetPersonsCars(Guid userId)
        {
            IEnumerable<Car> usersCars;
            try
            {
                usersCars = await _carService.GetUsersCars(userId);
            }
            catch (Exception ex)
            {
                return NotFound();
            }
            return Ok(usersCars);
        }


    }
}
