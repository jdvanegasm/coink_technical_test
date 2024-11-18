using Microsoft.EntityFrameworkCore;
using coink_api.Models;
using coink_api.data;
using coink_api.DTOs;

namespace coink_api.Services{
    public class LocationService : ILocationService{
        private readonly ApplicationDbContext _context;

        public LocationService(ApplicationDbContext context){
            _context = context;
        }

        public IEnumerable<CountryDto> GetCountries(){
            return _context.Set<CountryDto>().FromSqlRaw("select * from public.sp_get_countries()").ToList();
        }

        public IEnumerable<RegionDto> GetRegionsByCountry(int countryId){
            return _context.Set<RegionDto>().FromSqlRaw(
                "select * from public.sp_get_regions_by_country({0})",
                countryId
            ).ToList();
        }

        public IEnumerable<MunicipalityDto> GetMunicipalitiesByRegion(int regionId){
            return _context.Set<MunicipalityDto>().FromSqlRaw(
                "select * from public.sp_get_municipalities_by_region({0})",
                regionId
            ).ToList();
        }
    }
}