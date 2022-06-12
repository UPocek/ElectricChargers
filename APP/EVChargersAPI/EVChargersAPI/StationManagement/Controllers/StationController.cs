using Data.Entities;
using EVChargersAPI.StationManagement.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.StationManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StationController : ControllerBase
    {
        private readonly IStationService _stationService;

        public StationController(IStationService stationService)
        {
            _stationService = stationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Station>>> GetAll()
        {
            IEnumerable<Station> stations = await _stationService.GetAll();
            return Ok(stations);
        }

        [HttpGet]
        [Route("getById")]
        public async Task<ActionResult<IEnumerable<Station>>> GetById(Guid id)
        {
            Station station = await _stationService.GetById(id);
            return Ok(station);
        }
    }
}
