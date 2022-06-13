using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Data.Entities
{
    [Table("Reservation")]
    public class Reservation
    {
        [Column("id")]
        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [Column("reservationDate")]
        [JsonPropertyName("reservationDate")]
        public DateTime ReservationDate { get; set; }

        [Column("person")]
        [JsonPropertyName("person")]
        public Guid UserId { get; set; }

        [Column("charger")]
        [JsonPropertyName("charger")]
        public Guid ChargerId { get; set; }
    }
}
