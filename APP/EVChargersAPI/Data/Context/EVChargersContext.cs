using Data.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Context
{
    public class EVChargersContext : DbContext
    {
        public DbSet<Address> Addresses { get; set; }
        public DbSet<Car> Cars { get; set; }
        public DbSet<Charger> Chargers { get; set; }
        public DbSet<ChargingPrice> ChargingPrices { get; set; }
        public DbSet<City> Cities { get; set; }
        public DbSet<CreditCard> CreditCards { get; set; }
        public DbSet<Reservation> Reservations { get; set; }
        public DbSet<Station> Stations { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<User> Users { get; set; }

        public EVChargersContext(DbContextOptions options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Address>().HasKey(x => x.Id);
            modelBuilder.Entity<Car>().HasKey(x => x.Id);
            modelBuilder.Entity<Charger>().HasKey(x => x.Id);
            modelBuilder.Entity<ChargingPrice>().HasKey(x => x.Id);
            modelBuilder.Entity<City>().HasKey(x => x.Id);
            modelBuilder.Entity<CreditCard>().HasKey(x => x.Id);
            modelBuilder.Entity<Reservation>().HasKey(x => x.Id);
            modelBuilder.Entity<Station>().HasKey(x => x.Id);
            modelBuilder.Entity<Transaction>().HasKey(x => new {x.StationId, x.PersonId, x.TransactionDate});
            modelBuilder.Entity<User>().HasKey(x => x.Id);
        }
    }
}
