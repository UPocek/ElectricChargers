using Data.Entities;
using EVChargersAPI.StationManagement.Repositories;
using EVChargersAPI.UserManagement.Services;

namespace EVChargersAPI.StationManagement.Services
{
    public interface IStationService : IService<Station>
    {
        Task<Station> GetById(Guid id);

    }

    public class StationService : IStationService
    {
        private readonly IStationRepository _stationRepository;
        public StationService(IStationRepository stationRepository)
        {
            _stationRepository = stationRepository;
        }

        public Task<IEnumerable<Station>> GetAll()
        {
            return _stationRepository.GetAll();
        }

        public Task<Station> GetById(Guid id)
        {
            return _stationRepository.GetById(id);
        }
    }
}
