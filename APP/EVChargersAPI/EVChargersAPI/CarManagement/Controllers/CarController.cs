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


    }
}
