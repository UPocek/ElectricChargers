using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Address")]
    public class Address
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("street")]
        [JsonPropertyName("street")]
        public string Street { get; set; }

        [Column("number")]
        [JsonPropertyName("number")]
        public int Number { get; set; }

        [Column("city")]
        [JsonPropertyName("city")]
        public Guid CityId { get; set; }

        [JsonPropertyName("fullCity")]
        public City City { get; set; }
    }
}
