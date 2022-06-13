using Data.Entities;
using EVChargersAPI.Charging.Services;
using Microsoft.AspNetCore.Mvc;

namespace EVChargersAPI.Charging.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TransactionController : ControllerBase
    {
        private readonly ITransactionService _transactionService;

        public TransactionController(ITransactionService transactionService)
        {
            _transactionService = transactionService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Transaction>>> GetAll()
        {
            IEnumerable<Transaction> chargers = await _transactionService.GetAll();
            return Ok(chargers);
        }


        [HttpGet]
        [Route("getForUser")]
        public async Task<ActionResult<IEnumerable<Transaction>>> GetForUser(Guid userId)
        {
            IEnumerable<Transaction> transactions;
            try
            {
                transactions = await _transactionService.GetForUser(userId);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok(transactions);
        }

        [HttpGet]
        [Route("startCharging")]
        public async Task<ActionResult> StartCharging(Guid userId, string rfid)
        {
            bool canStart;
            try
            {
                canStart = await _transactionService.StartCharging(userId, rfid);
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
            if (canStart) return Ok("Can start charging");
            return BadRequest("Cannot start charging");

        }

        [HttpPost]
        [Route("stopCharging")]
        public async Task<ActionResult<double>> StopCharging(Guid userId, double kwh, string rfid)
        {
            double price;
            try
            {
                price = await _transactionService.StopCharging(userId, kwh, rfid);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok(price);
        }
    }
}
