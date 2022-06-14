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
        Task<ChargingPrice> GetPrice(Guid stationId);
        double GetMonthlyPrice(Guid userId);
        double GetMonthlyKwh(Guid userId);
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
            return await _context.Transactions
                .Include(x => x.Station)
                .ThenInclude(x => x.Address)
                .ThenInclude(x => x.City)
                .ToListAsync();
        }

        public async Task<IEnumerable<Transaction>> GetAllForUser(Guid userId)
        {
            return await _context.Transactions
                .Where(x => x.UserId == userId)
                .Include(x => x.Station)
                .ThenInclude(x => x.Address)
                .ThenInclude(x => x.City)
                .OrderByDescending(x => x.TransactionDate).ToListAsync();
        }

        public double GetMonthlyKwh(Guid userId)
        {
            return (double)_context.Transactions
                .Where(x => x.UserId == userId)
                .Where(x => x.TransactionDate >= DateTime.Now.AddDays(-30))
                .Sum(x => x.Kwh);
        }

        public double GetMonthlyPrice(Guid userId)
        {
            return (double)_context.Transactions
                .Where(x => x.UserId == userId)
                .Where(x => x.TransactionDate >= DateTime.Now.AddDays(-30))
                .Sum(x => x.Price);
        }

        public async Task<ChargingPrice> GetPrice(Guid stationId)
        {
            return await _context.ChargingPrices
                .Where(x => x.StationId == stationId)
                .Where(x => x.DateFrom < DateTime.Now)
                .OrderByDescending(x => x.DateFrom)
                .FirstOrDefaultAsync();
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
