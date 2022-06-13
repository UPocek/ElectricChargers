using Data.Entities;
using EVChargersAPI.StationManagement.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.StationManagement.Services
{
    public interface IChargerService : IService<Charger>
    {
        Task<Charger> GetById(Guid id);
    }

    public class ChargerService : IChargerService
    {
        private readonly IChargerRepository _chargerRepository;
        public ChargerService(IChargerRepository chargerRepository)
        {
            _chargerRepository = chargerRepository;
        }

        public Task<IEnumerable<Charger>> GetAll()
        {
            return _chargerRepository.GetAll();
        }

        public Task<Charger> GetById(Guid id)
        {
            return _chargerRepository.GetById(id);
        }
    }
}
