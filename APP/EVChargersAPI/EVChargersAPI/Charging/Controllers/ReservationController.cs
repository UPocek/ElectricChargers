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

        [HttpPost]
        public async Task<ActionResult<Reservation>> Create(Guid userId, Guid stationId, DateTime date)
        {
            Reservation reservation;
            try
            {
                reservation = await _reservationService.Create(userId, stationId, date);
            }
            catch (Exception ex)
            {
                return NotFound();
            }
            return Ok(reservation);
        }
        [HttpDelete]
        public async Task<ActionResult<Reservation>> Delete(Guid id)
        {
            Reservation deletedReservation;
            try
            {
                deletedReservation = await _reservationService.Delete(id);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok(deletedReservation);
        }
    }
}
