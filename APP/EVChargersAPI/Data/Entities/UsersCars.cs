using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("PersonsCars")]
    public class UsersCars
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("car")]
        [JsonPropertyName("car")]
        public Guid Car { get; set; }

        [Column("person")]
        [JsonPropertyName("person")]
        public Guid Person { get; set; }

    }
}
