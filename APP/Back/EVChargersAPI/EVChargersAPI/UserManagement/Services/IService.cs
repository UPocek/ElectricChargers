namespace EVChargersAPI.UserManagement.Services
{
    public interface IService<T> where T : class
    {
        Task<IEnumerable<T>> GetAll();
        Task<T> Create(T item);
    }
}