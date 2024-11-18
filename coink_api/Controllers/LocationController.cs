using Microsoft.AspNetCore.Mvc;
using coink_api.Services;

namespace coink_api.Controllers{
    [ApiController]
    [Route("api/[controller]")]
    public class LocationController : ControllerBase{
        private readonly ILocationService _locationService;

        public LocationController(ILocationService locationService){
            _locationService = locationService;
        }

        // get: api/location/countries
        [HttpGet("countries")]
        public IActionResult GetCountries(){
            var countries = _locationService.GetCountries();
            return Ok(countries);
        }

        // get: api/location/regions
        [HttpGet("regions")]
        public IActionResult GetRegionsByCountry(int countryId){
            var regions = _locationService.GetRegionsByCountry(countryId);
            return Ok(regions);
        }

        // get: api/location/municipalities?regionId=1
        [HttpGet("municipalities")]
        public IActionResult GetMunicipalitiesByRegion(int regionId){
            var municipalities = _locationService.GetMunicipalitiesByRegion(regionId);
            return Ok(municipalities);
        }
    }
}