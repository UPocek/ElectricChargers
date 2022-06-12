using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("City")]
    public class City
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("name")]
        [JsonPropertyName("name")]
        public string Name { get; set; }

        [Column("postalCode")]
        [JsonPropertyName("postalCode")]
        public int PostalCode { get; set; }

    }
}
