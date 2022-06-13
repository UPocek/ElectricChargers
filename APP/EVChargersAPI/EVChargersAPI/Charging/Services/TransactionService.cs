using Data.Entities;
using EVChargersAPI.Charging.Repositories;
using EVChargersAPI.DTO;
using EVChargersAPI.StationManagement.Repositories;
using EVChargersAPI.UserManagement.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.Charging.Services
{
    public interface ITransactionService : IService<Transaction>
    {
        Task<Transaction> Create(Guid userId, Guid stationId, DateTime date);
        Task<IEnumerable<Transaction>> GetForUser(Guid userId);
        Task<bool> StartCharging(Guid userId, string rfid);
        Task<double> StopCharging(Guid userId, double kwh, string rfid);
        Task<StatsDTO> GetMonthlyStats(Guid userId);
    }

    public class TransactionService : ITransactionService
    {
        private readonly ITransactionRepository _transactionRepository;
        private readonly IReservationRepository _reservationRepository;
        private readonly IUserRepository _userRepository;
        private readonly IStationRepository _stationRepository;
        private readonly IChargerRepository _chargerRepository;
        public TransactionService(ITransactionRepository transactionRepository, IReservationRepository reservationRepository, IUserRepository userRepository, IStationRepository stationRepository, IChargerRepository chargerRepository)
        { 
            _transactionRepository = transactionRepository;
            _reservationRepository = reservationRepository;
            _userRepository = userRepository;
            _stationRepository = stationRepository;
            _chargerRepository = chargerRepository;
        }

        public Task<Transaction> Create(Guid userId, Guid stationId, DateTime date)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Transaction>> GetForUser(Guid userId)
        {
            List<Transaction> transaction = (List<Transaction>)await _transactionRepository.GetAllForUser(userId);
            if (transaction.Count <= 5) return transaction;
            List<Transaction> result = new List<Transaction>();
            for(int i = 0; i < 5; i++)
                result.Add(transaction[i]);
            return result;
        }

        public async Task<IEnumerable<Transaction>> GetAll()
        {
            return await _transactionRepository.GetAll();
        }

        public async Task<bool> StartCharging(Guid userId, string rfid)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User cannot be found!");
            if (user.AccountBalance <= 0) throw new Exception("User is blocked due to not paying chargings!");
            Charger charger = await _chargerRepository.GetByRfid(rfid);
            if (charger == null) throw new Exception("Charger cannot be found!");
            bool canStart = await _reservationRepository.IsChargerAvailable(charger.Id, DateTime.Now);
            if (canStart)
                return true;
            return false;
        }

        public async Task<double> StopCharging(Guid userId, double kwh, string rfid)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User cannot be found!");
            Charger charger = await _chargerRepository.GetByRfid(rfid);
            if (charger == null) throw new Exception("Charger cannot be found!");

            ChargingPrice chargingPrice = await _transactionRepository.GetPrice(charger.StationId);

            Transaction transaction = new Transaction
            {
                TransactionDate = DateTime.Now,
                StationId = charger.StationId,
                UserId = userId,
                Kwh = (decimal)kwh,
                Price = chargingPrice.Price * (decimal)kwh,
            };

            _ = _transactionRepository.Create(transaction);
            _transactionRepository.Save();

            user.AccountBalance -= transaction.Price;
            _ = _userRepository.Update(user);
            _userRepository.Save();


            return (double)transaction.Price;
        }

        public async Task<StatsDTO> GetMonthlyStats(Guid userId)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User cannot be found!");
            StatsDTO stats = new StatsDTO
            {
                Price = _transactionRepository.GetMonthlyPrice(userId),
                Kwh = _transactionRepository.GetMonthlyKwh(userId)
            };
            return stats;
        }
    }

}
