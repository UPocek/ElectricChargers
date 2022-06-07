using Microsoft.EntityFrameworkCore;

public class SimsContext : DbContext
{
    public DbSet<User> Users { get; set; }

    public SimsContext(DbContextOptions options) : base(options)
    {

    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
    }

}