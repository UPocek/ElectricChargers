using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Person")]
    public class User
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid? Id { get; set; }

        [Column("firstName")]
        [JsonPropertyName("firstName")]
        public string FirstName { get; set; }

        [Column("lastName")]
        [JsonPropertyName("lastName")]
        public string LastName { get; set; }

        [Column("email")]
        [JsonPropertyName("email")]
        public string Email { get; set; }

        [Column("password")]
        [JsonPropertyName("password")]
        public string Password { get; set; }

        [Column("bankCard")]
        [JsonPropertyName("bankCard")]
        public string? BankCard { get; set; }


    }
}
