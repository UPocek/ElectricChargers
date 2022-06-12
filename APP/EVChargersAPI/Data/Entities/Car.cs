using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Car")]
    public class Car
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [Column("model")]
        [JsonPropertyName("model")]
        public string Model { get; set; }

        [Column("make")]
        [JsonPropertyName("make")]
        public string Make { get; set; }

    }
}
