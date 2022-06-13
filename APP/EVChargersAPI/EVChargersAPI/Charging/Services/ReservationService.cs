using Data.Entities;
using EVChargersAPI.Charging.Repositories;
using EVChargersAPI.StationManagement.Repositories;
using EVChargersAPI.StationManagement.Services;
using EVChargersAPI.UserManagement.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.Charging.Services
{
    public interface IReservationService : IService<Reservation>
    {
        Task<Reservation> GetById(Guid id);
        Task<Reservation> Create(Guid userId, Guid stationId, DateTime date);
        Task<Reservation> Delete(Guid id);
        Task<IEnumerable<Reservation>> GetForUser(Guid userId);
    }

    public class ReservationService : IReservationService
    {
        private readonly IReservationRepository _reservationRepository;
        private readonly IUserRepository _userRepository;
        private readonly IStationRepository _stationRepository;
        private readonly IChargerRepository _chargerRepository;
        public ReservationService(IReservationRepository reservationRepository, IUserRepository userRepository, IStationRepository stationRepository, IChargerRepository chargerRepository)
        {
            _reservationRepository = reservationRepository;
            _userRepository = userRepository;
            _stationRepository = stationRepository;
            _chargerRepository = chargerRepository;
        }

        public async Task<Reservation> Create(Guid userId, Guid stationId, DateTime date)
        {
            
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User do not exist");
            Station station = await _stationRepository.GetById(stationId);
            if (station == null) throw new Exception("Station do not exist");
            if (!(await _reservationRepository.IsAvailable(userId, date))) throw new Exception("User already has reservation!");
            IEnumerable<Charger> chargers = await _chargerRepository.GetAllOnStation(stationId);
            Reservation reservation = new Reservation
            {
                UserId = userId,
                ReservationDate = date,
                Id = Guid.NewGuid()
            };
            foreach(Charger charger in chargers)
            {
                if (await _reservationRepository.IsChargerAvailable(charger.Id, date))
                {
                    reservation.ChargerId = (Guid)charger.Id;
                    break;
                }
            }
            if (reservation.ChargerId == null) throw new Exception();
            _ = _reservationRepository.Create(reservation);
            _reservationRepository.Save();
            return reservation;

        }

        public async Task<Reservation> Delete(Guid id)
        {
            Reservation reservation = await _reservationRepository.GetById(id);
            if (reservation == null) throw new Exception("Reservation do not exist.");
            _ = _reservationRepository.Delete(reservation);
            _reservationRepository.Save();
            return reservation;
                    
        }

        public Task<IEnumerable<Reservation>> GetAll()
        {
            return _reservationRepository.GetAll();
        }

        public Task<Reservation> GetById(Guid id)
        {
            return _reservationRepository.GetById(id);
        }

        public async Task<IEnumerable<Reservation>> GetForUser(Guid userId)
        {
            User user = await _userRepository.GetById(userId);
            if (user == null) throw new Exception("User do not exist.");
            return await _reservationRepository.GetAllForUser(userId);
        }
    }
}
