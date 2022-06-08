using System.Text.Json.Serialization;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

[Table("myuser")]
public class User
{
    [Column("ID")]
    [JsonPropertyName("id")]
    public string? _Id { get; set; }

    [Column("firstname")]
    [JsonPropertyName("firstName")]
    public string FirstName { get; set; }

    [Column("lastname")]
    [JsonPropertyName("lastName")]
    public string LastName { get; set; }

    [Column("email")]
    [JsonPropertyName("email")]
    public string Email { get; set; }

    [Column("password")]
    [JsonPropertyName("password")]
    public string Password { get; set; }

}