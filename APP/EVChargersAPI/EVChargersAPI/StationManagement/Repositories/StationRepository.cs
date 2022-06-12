using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;

namespace EVChargersAPI.StationManagement.Repositories
{
    public interface IStationRepository : IRepository<Station>
    {
        Task<Station> GetById(Guid id);
    }
    public class StationRepository : IStationRepository
    {
        private readonly EVChargersContext _context;

        public StationRepository(EVChargersContext context)
        {
            _context = context;
        }

        public Station Create(Station item)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Station>> GetAll()
        {
            return await _context.Stations.ToListAsync();
        }

        public async Task<Station> GetById(Guid id)
        {
            return await _context.Stations.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public Station Update(Station item)
        {
            throw new NotImplementedException();
        }
    }
}
