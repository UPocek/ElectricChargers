using Data.Entities;
using EVChargersAPI.DTO;
using EVChargersAPI.UserManagement.Repositories;

namespace EVChargersAPI.UserManagement.Services
{
    public interface IUserService : IService<User>
    {
        Task<User> Login(string email, string password);
        Task<User> GetById(Guid id);
        Task<User> SetBankCard(InsertingCreditCardDTO dto);
    }

    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly ICreditCardRepository _creditCardRepository;
        public UserService(IUserRepository userRepository, ICreditCardRepository creditCardRepository)
        {
            _userRepository = userRepository;
            _creditCardRepository = creditCardRepository;
        }

        public async Task<User> Create(User item)
        {
            item.Id = Guid.NewGuid();
            User createdUser = _userRepository.Create(item);
            _userRepository.Save();
            return createdUser;
        }

        public async Task<IEnumerable<User>> GetAll()
        {
            return await _userRepository.GetAll();
        }

        public async Task<User> GetById(Guid id)
        {
            return await _userRepository.GetById(id);
        }

        public async Task<User> Login(string email, string password)
        {
            return await _userRepository.Login(email, password);
        }

        public async Task<User> SetBankCard(InsertingCreditCardDTO dto)
        {
            User user = await GetById(dto.UserId);
            if (user == null) throw new Exception("User not found");
            CreditCard creditCard = new CreditCard
            {
                Id = Guid.NewGuid(),
                CardHolderName = dto.CardHolderName,
                CardNumber = dto.CardNumber,
                CvvCode = dto.CvvCode,
                ExpiryDate = dto.ExpiryDate
            };

            _creditCardRepository.Create(creditCard);
            _creditCardRepository.Save();

            user.CardId = creditCard.Id;
            User updatedUser = _userRepository.Update(user);
            _userRepository.Save();
              
            return updatedUser;
        }
    }
}
