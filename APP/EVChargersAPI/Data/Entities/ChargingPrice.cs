using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("ChargingPrice")]
    public class ChargingPrice
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("dateFrom")]
        [JsonPropertyName("dateFrom")]
        public DateTime DateFrom { get; set; }

        [Column("price")]
        [JsonPropertyName("price")]
        public decimal Price { get; set; }

        [Column("station")]
        [JsonPropertyName("station")]
        public Guid StationId { get; set; }

    }
}
