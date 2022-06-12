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

        public async Task<Reservation> GetById(Guid id)
        {
            return await _context.Reservations.Where(x => x.Id == id).FirstOrDefaultAsync();
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
