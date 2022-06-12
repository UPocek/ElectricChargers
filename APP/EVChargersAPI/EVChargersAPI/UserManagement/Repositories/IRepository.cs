namespace EVChargersAPI.UserManagement.Repositories
{
    public interface IRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAll();
        T Create(T item);
        T Update(T item);
        void Save();

    }
}
