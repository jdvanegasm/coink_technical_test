using Microsoft.EntityFrameworkCore;
using coink_api.Models;
using coink_api.DTOs;

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

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<UserByLocationDto>(entity =>{
                entity.HasNoKey();
            });

            modelBuilder.Entity<CountryDto>(entity =>{
                entity.HasNoKey();
            });

            modelBuilder.Entity<RegionDto>(entity =>{
                entity.HasNoKey();
            });

            modelBuilder.Entity<MunicipalityDto>(entity =>{
                entity.HasNoKey();
            });
        }
    }
}