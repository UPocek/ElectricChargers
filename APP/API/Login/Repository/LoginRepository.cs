using MySqlConnector;

public class LoginRepository : ILoginRepository
{
    MySqlConnector.MySqlConnectionStringBuilder builder;

    public LoginRepository()
    {
        builder = new MySqlConnectionStringBuilder
        {
            Server = "your-server",
            UserID = "database-user",
            Password = "P@ssw0rd!",
            Database = "database-name",
        };
    }
    public async Task InsertUser(User user)
    {
        using var connection = new MySqlConnection(builder.ConnectionString);
        await connection.OpenAsync();

        using var command = connection.CreateCommand();
        command.CommandText = @"SELECT * FROM myuser;";

        using var reader = await command.ExecuteReaderAsync();
        while (reader.Read())
        {
            var email = reader.GetString("email");
            Console.WriteLine(email);
        }
    }
}