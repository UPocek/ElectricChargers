using MySqlConnector;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
public class LoginRepository : ILoginRepository
{
    private readonly SimsContext _context;

    public LoginRepository()
    {
        // builder = new MySqlConnectionStringBuilder
        // {
        //     Server = "your-server",
        //     UserID = "database-user",
        //     Password = "P@ssw0rd!",
        //     Database = "database-name",
        // };

        _context = new SimsContext();
    }
    public async Task<IEnumerable<User>> InsertUser(User user)
    {
        return await _context.Users.ToListAsync();
    }
}