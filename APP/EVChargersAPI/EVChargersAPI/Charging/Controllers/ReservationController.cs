using Data.Entities;
using EVChargersAPI.Charging.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.Charging.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReservationController : ControllerBase
    {
        private readonly IReservationService _reservationService;

        public ReservationController(IReservationService reservationService)
        {
            _reservationService = reservationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Reservation>>> GetAll()
        {
            IEnumerable<Reservation> chargers = await _reservationService.GetAll();
            return Ok(chargers);
        }

        [HttpGet]
        [Route("getById")]
        public async Task<ActionResult<IEnumerable<Reservation>>> GetById(Guid id)
        {
            Reservation charger = await _reservationService.GetById(id);
            return Ok(charger);
        }
    }
}
