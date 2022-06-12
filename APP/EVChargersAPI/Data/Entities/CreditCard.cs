using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("CreditCard")]
    public class CreditCard
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("cardNumber")]
        [JsonPropertyName("cardNumber")]
        public string CardNumber { get; set; }

        [Column("expiryDate")]
        [JsonPropertyName("expiryDate")]
        public string ExpiryDate { get; set; }

        [Column("cvvCode")]
        [JsonPropertyName("cvvCode")]
        public string CvvCode { get; set; }

        [Column("cardHolderName")]
        [JsonPropertyName("cardHolderName")]
        public string CardHolderName { get; set; }


    }
}
