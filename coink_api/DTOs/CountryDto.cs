using System.ComponentModel.DataAnnotations.Schema;

namespace coink_api.DTOs{
    public class CountryDto{
        [Column("country_id")]
        public int CountryId {get; set;}
        [Column("country_name")]
        public string CountryName {get; set;} = string.Empty;
        [Column("country_code")]
        public string CountryCode {get; set;} = string.Empty;
        [Column("global_region_name")]
        public string GlobalRegionName {get; set;} = string.Empty;
        [Column("division_type")]
        public string DivisionType {get; set;} = string.Empty;
    }
}