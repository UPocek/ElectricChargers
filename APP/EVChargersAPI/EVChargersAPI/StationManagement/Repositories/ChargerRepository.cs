using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.StationManagement.Repositories
{
    public interface IChargerRepository : IRepository<Charger>
    {
        Task<Charger> GetById(Guid id);
        Task<IEnumerable<Charger>> GetAllOnStation(Guid stationId);

        Task<Charger> GetByRfid(string rfid);
    }
    public class ChargerRepository : IChargerRepository
    {
        private readonly EVChargersContext _context;

        public ChargerRepository(EVChargersContext context)
        {
            _context = context;
        }

        public Charger Create(Charger item)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Charger>> GetAll()
        {
            return await _context.Chargers.ToListAsync();
        }

        public async Task<Charger> GetById(Guid id)
        {
            return await _context.Chargers.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<Charger>> GetAllOnStation(Guid stationId)
        {
            return await _context.Chargers.Where(x => x.StationId == stationId).ToListAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public Charger Update(Charger item)
        {
            EntityEntry<Charger> updatedEntry = _context.Chargers.Attach(item);
            _context.Entry(item).State = EntityState.Modified;
            return updatedEntry.Entity;
        }

        public async Task<Charger> GetByRfid(string rfid)
        {
            return await _context.Chargers.Where(x => x.Rfid == rfid).FirstOrDefaultAsync();
        }
    }
}
