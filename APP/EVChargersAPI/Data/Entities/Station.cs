using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Station")]
    public class Station
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("name")]
        [JsonPropertyName("name")]
        public string Name { get; set; }

        [Column("address")]
        [JsonPropertyName("address")]
        public Guid AddressId { get; set; }

        [Column("latitude")]
        [JsonPropertyName("latitude")]
        public decimal Latitude { get; set; }

        [Column("longitude")]
        [JsonPropertyName("longitude")]
        public decimal Longitude { get; set; }
        [JsonPropertyName("fullAddress")]
        public Address Address { get; set; }
    }
}
