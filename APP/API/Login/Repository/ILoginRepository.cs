using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public interface ILoginRepository
{
    public Task<IEnumerable<User>> InsertUser(User user);
}