using Microsoft.EntityFrameworkCore;
using coink_api.Models;

namespace coink_api.data{
    public class ApplicationDbContext : DbContext{
        public ApplicationDbContext (DbContextOptions<ApplicationDbContext> options)
        : base(options){

        }
        public DbSet<DivisionType> DivisionsTypes {get; set;} = null!;
        public DbSet<GlobalRegion> GlobalRegions {get; set;} = null!;
        public DbSet<Country> Countries {get; set;} = null!;
        public DbSet<Region> Regions {get; set;} = null!;
        public DbSet<Municipality> Municipalities {get; set;} = null!;
        public DbSet<User> Users {get; set;} = null!;
    }
}