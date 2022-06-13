using Data.Entities;
using EVChargersAPI.Charging.Repositories;
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

        public Task<IEnumerable<Transaction>> GetForUser(Guid userId)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Transaction>> GetAll()
        {
            return await _transactionRepository.GetAll();
        }

        public async Task<bool> StartCharging(Guid userId, string rfid)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User cannot be found!");
            Charger charger = await _chargerRepository.GetByRfid(rfid);
            if (charger == null) throw new Exception("Charger cannot be found!");
            DateTime date = new DateTime(2022, 6, 15, 15, 15, 0);
            bool canStart = await _reservationRepository.IsChargerAvailable(charger.Id, date);
            if (canStart)
                return true;
            return false;
        }
    }

}
