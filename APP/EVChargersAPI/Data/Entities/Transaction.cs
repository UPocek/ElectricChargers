using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Transaction")]
    public class Transaction
    {
        [Column("transactionDate")]
        [JsonPropertyName("transactionDate")]
        public DateTime TransactionDate { get; set; }

        [Column("price")]
        [JsonPropertyName("price")]
        public decimal Price { get; set; }

        [Column("station")]
        [JsonPropertyName("station")]
        public Guid StationId { get; set; }

        [Column("person")]
        [JsonPropertyName("person")]
        public Guid UserId { get; set; }

        [Column("kwh")]
        [JsonPropertyName("kwh")]
        public decimal Kwh { get; set; }

        [JsonPropertyName("fullStation")]
        public Station Station { get; set; }
    }
}
