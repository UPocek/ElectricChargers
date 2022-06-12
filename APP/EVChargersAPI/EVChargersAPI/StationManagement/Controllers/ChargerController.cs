using Data.Entities;
using EVChargersAPI.StationManagement.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.StationManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ChargerController : ControllerBase
    {
        private readonly IChargerService _chargerService;

        public ChargerController(IChargerService chargerService)
        {
            _chargerService = chargerService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Charger>>> GetAll()
        {
            IEnumerable<Charger> chargers = await _chargerService.GetAll();
            return Ok(chargers);
        }

        [HttpGet]
        [Route("getById")]
        public async Task<ActionResult<IEnumerable<Charger>>> GetById(Guid id)
        {
            Charger charger = await _chargerService.GetById(id);
            return Ok(charger);
        }
    }
}
