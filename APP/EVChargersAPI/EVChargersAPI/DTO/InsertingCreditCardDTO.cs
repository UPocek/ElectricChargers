namespace EVChargersAPI.DTO
{
    public class InsertingCreditCardDTO
    {
        public Guid UserId { get; set; }
        public string CardNumber { get; set; }
        public string ExpiryDate { get; set; }
        public string CvvCode { get; set; }
        public string CardHolderName { get; set; }
    }
}
