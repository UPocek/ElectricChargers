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

        public async Task<IEnumerable<Reservation>> GetAll()
        {
            return await _context.Reservations.ToListAsync();
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
            return await _context.Reservations.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<bool> IsAvailable(Guid userId, DateTime date)
        {
            List<Reservation> after = await _context.Reservations
                .Where(x => x.UserId == userId)
                .Where(x => x.ReservationDate < date)
                .Where(x => x.ReservationDate.AddMinutes(30) > date)
                .ToListAsync();
            List<Reservation> before = await _context.Reservations
                .Where(x => x.UserId == userId)
                .Where(x => x.ReservationDate > date)
                .Where(x => x.ReservationDate.AddMinutes(-30) < date)
                .ToListAsync();
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
