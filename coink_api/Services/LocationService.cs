using coink_api.data;
using coink_api.Models;

namespace coink_api.Services{
    public class LocationService : ILocationService{
        private readonly ApplicationDbContext _context;

        public LocationService(ApplicationDbContext context){
            _context = context;
        }

        public IEnumerable<Country> GetCountries(){
            return _context.Countries.FromSqlRaw("select * from countries").ToList();
        }

        public IEnumerable<Region> GetRegionsByCountry(int countryId){
            return _context.Regions.FromSqlRaw(
                "select * from sp_get_regions_by_country({0})",
                countryId
            ).ToList();
        }

        public IEnumerable<Municipality> GetMunicipalitiesByRegion(int regionId){
            return _context.Municipalities.FromSqlRaw(
                "select * from sp_get_municipalities_by_region({0})",
                regionId
            ).ToList();
        }
    }
}