using Data.Entities;
using EVChargersAPI.Charging.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.Charging.Services
{
    public interface IReservationService : IService<Reservation>
    {
        Task<Reservation> GetById(Guid id);

    }

    public class ReservationService : IReservationService
    {
        private readonly IReservationRepository _reservationRepository;
        public ReservationService(IReservationRepository reservationRepository)
        {
            _reservationRepository = reservationRepository;
        }

        public Task<IEnumerable<Reservation>> GetAll()
        {
            return _reservationRepository.GetAll();
        }

        public Task<Reservation> GetById(Guid id)
        {
            return _reservationRepository.GetById(id);
        }
    }
}
