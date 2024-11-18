using System.ComponentModel.DataAnnotations.Schema;

namespace coink_api.DTOs{
    public class UserByLocationDto{
        [Column("user_id")]
        public Guid UserId {get; set;}
        [Column("name")]
        public string Name {get; set;} = string.Empty;
        [Column("phone")]
        public string Phone {get; set;} = string.Empty;
        [Column("address")]
        public string Address {get; set;} = string.Empty;
        [Column("country_name")]
        public string CountryName {get; set;} = string.Empty;
        [Column("region_name")]
        public string RegionName {get; set;} = string.Empty;
        [Column("municipality_name")]
        public string MunicipalityName {get; set;} = string.Empty;
    }
}