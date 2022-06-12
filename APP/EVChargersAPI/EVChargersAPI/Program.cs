using Data.Context;
using EVChargersAPI.CarManagement.Repositories;
using EVChargersAPI.CarManagement.Services;
using EVChargersAPI.Charging.Controllers;
using EVChargersAPI.Charging.Repositories;
using EVChargersAPI.Charging.Services;
using EVChargersAPI.StationManagement.Repositories;
using EVChargersAPI.StationManagement.Services;
using EVChargersAPI.UserManagement.Repositories;
using EVChargersAPI.UserManagement.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();




//Repositories
builder.Services.AddTransient<IUserRepository, UserRepository>();
builder.Services.AddTransient<ICreditCardRepository, CreditCardRepository>();
builder.Services.AddTransient<ICarRepository, CarRepository>();
builder.Services.AddTransient<IStationRepository, StationRepository>();
builder.Services.AddTransient<IChargerRepository, ChargerRepository>();
builder.Services.AddTransient<IReservationRepository, ReservationRepository>();




//Services
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<ICarService, CarService>();
builder.Services.AddTransient<IStationService, StationService>();
builder.Services.AddTransient<IReservationService, ReservationService>();
builder.Services.AddTransient<IChargerService, ChargerService>();

//Cors
builder.Services.AddCors(feature =>
                feature.AddPolicy(
                    "CorsPolicy",
                    apiPolicy => apiPolicy
                                    .AllowAnyHeader()
                                    .AllowAnyMethod()
                                    .SetIsOriginAllowed(host => true)
                                    .AllowCredentials()
                                ));

//Connection string
var connectionString = builder.Configuration.GetConnectionString("EVChargersConnection");
builder.Services.AddDbContext<EVChargersContext>(x => x.UseSqlServer(connectionString));


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
