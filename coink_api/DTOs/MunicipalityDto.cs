using System.ComponentModel.DataAnnotations.Schema;

namespace coink_api.DTOs{
    public class MunicipalityDto{
        [Column("municipality_id")]
        public int MunicipalityId {get; set;}
        [Column("municipality_name")]
        public string MunicipalityName {get; set;} = string.Empty;
    }
}