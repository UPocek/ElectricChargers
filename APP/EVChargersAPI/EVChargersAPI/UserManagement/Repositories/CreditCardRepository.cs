using Data.Context;
using Data.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.UserManagement.Repositories
{
    public interface ICreditCardRepository : IRepository<CreditCard>
    {
        Task<CreditCard> GetById(Guid id);

    }
    public class CreditCardRepository : ICreditCardRepository
    {
        private readonly EVChargersContext _context;

        public CreditCardRepository(EVChargersContext context)
        {
            _context = context;
        }

        public CreditCard Create(CreditCard item)
        {
            EntityEntry<CreditCard> entityEntry = _context.CreditCards.Add(item);
            return entityEntry.Entity;
        }

        public async Task<IEnumerable<CreditCard>> GetAll()
        {
            return await _context.CreditCards.ToListAsync();
        }

        public async Task<CreditCard> GetById(Guid id)
        {
            return await _context.CreditCards.Where(x => x.Id == id).FirstOrDefaultAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public CreditCard Update(CreditCard item)
        {
            throw new NotImplementedException();
        }
    }
}
