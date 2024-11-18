using System.ComponentModel.DataAnnotations.Schema;

namespace coink_api.DTOs{
    public class RegionDto{
        [Column("region_id")]
        public int RegionId {get; set;}
        [Column("region_name")]
        public string RegionName {get; set;} = string.Empty;
    }
}