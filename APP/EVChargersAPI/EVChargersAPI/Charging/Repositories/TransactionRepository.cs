using Data.Context;
using Data.Entities;
using EVChargersAPI.UserManagement.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace EVChargersAPI.Charging.Repositories
{
    public interface ITransactionRepository : IRepository<Transaction>
    {
        Task<IEnumerable<Transaction>> GetAllForUser(Guid userId);
    }
    public class TransactionRepository : ITransactionRepository
    {
        private readonly EVChargersContext _context;

        public TransactionRepository(EVChargersContext context)
        {
            _context = context;
        }

        public Transaction Create(Transaction item)
        {
            EntityEntry<Transaction> entityEntry = _context.Transactions.Add(item);
            return entityEntry.Entity;
        }

        public async Task<IEnumerable<Transaction>> GetAll()
        {
            return await _context.Transactions.ToListAsync();
        }

        public async Task<IEnumerable<Transaction>> GetAllForUser(Guid userId)
        {
            return await _context.Transactions.Where(x => x.UserId == userId).OrderBy(x => x.TransactionDate).ToListAsync();
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public Transaction Update(Transaction item)
        {
            throw new NotImplementedException();
        }
    }
}
