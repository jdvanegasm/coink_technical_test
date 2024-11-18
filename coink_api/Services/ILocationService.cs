using coink_api.Models;

namespace coink_api.Services{
    public interface ILocationService{
        IEnumerable<Country> GetCountries();
        IEnumerable<Region> GetRegionsByCountry(int countryId);
        IEnumerable<Municipality> GetMunicipalitiesByRegion(int regionId);
    }
}