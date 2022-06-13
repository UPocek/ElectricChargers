using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.Charging.Repositories
{
    public interface IReservationRepository : IRepository<Reservation>
    {
        Task<Reservation> GetById(Guid id);
        Task<IEnumerable<Reservation>> GetAllForUser(Guid userId);
        Task<bool> IsAvailable(Guid userId, DateTime date);
        Task<bool> IsChargerAvailable(Guid? id, DateTime date);
        Reservation Delete(Reservation reservation);
    }
    public class ReservationRepository : IReservationRepository
    {
        private readonly EVChargersContext _context;

        public ReservationRepository(EVChargersContext context)
        {
            _context = context;
        }

        public Reservation Create(Reservation item)
        {
            EntityEntry<Reservation> entityEntry = _context.Reservations.Add(item);
            return entityEntry.Entity;
        }

        public Reservation Delete(Reservation reservation)
        {
            EntityEntry<Reservation> entityEntry = _context.Reservations.Remove(reservation);
            return entityEntry.Entity;
        }

        public async Task<IEnumerable<Reservation>> GetAll()
        {
            return await _context.Reservations
                .Include(x => x.Charger)
                .ThenInclude(x => x.Station)
                .ThenInclude(x => x.Address)
                .ThenInclude(x => x.City)
                .ToListAsync();
        }

        public async Task<IEnumerable<Reservation>> GetAllForUser(Guid userId)
        {
            return await _context.Reservations
                .Where(x => x.UserId == userId)
                .Where(x => x.ReservationDate > DateTime.Now)
                .ToListAsync();
        }

        public async Task<Reservation> GetById(Guid id)
        {
            return await _context.Reservations.Where(x => x.Id == id)
                .Include(x => x.Charger)
                .ThenInclude(x => x.Station)
                .ThenInclude(x => x.Address)
                .ThenInclude(x => x.City)
                .FirstOrDefaultAsync();
        }

        public async Task<bool> IsAvailable(Guid userId, DateTime date)
        {
            return (await _context.Reservations
                .Where(x => x.UserId == userId)
                .Where(x => x.ReservationDate.AddMinutes(-30) < date)
                .Where(x => x.ReservationDate.AddMinutes(30) > date).ToListAsync()).Capacity == 0;

        }

        public async Task<bool> IsChargerAvailable(Guid? id, DateTime date)
        {


            return (await _context.Reservations
                .Where(x => x.ChargerId == id)
                .Where(x => x.ReservationDate.AddMinutes(-30) < date)
                .Where(x => x.ReservationDate.AddMinutes(30) > date).ToListAsync()).Capacity == 0;
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public Reservation Update(Reservation item)
        {
            throw new NotImplementedException();
        }
    }
}
