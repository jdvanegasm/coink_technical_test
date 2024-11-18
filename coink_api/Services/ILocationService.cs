using coink_api.Models;
using coink_api.DTOs;

namespace coink_api.Services{
    public interface ILocationService{
        IEnumerable<CountryDto> GetCountries();
        IEnumerable<RegionDto> GetRegionsByCountry(int countryId);
        IEnumerable<MunicipalityDto> GetMunicipalitiesByRegion(int regionId);
    }
}