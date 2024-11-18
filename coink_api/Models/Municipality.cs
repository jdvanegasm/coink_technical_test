using System.ComponentModel.DataAnnotations;

namespace coink_api.Models{
    public class Municipality{
        [Key]
        [Required(ErrorMessage = "This field is required")]
        public int MunicipalityId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        [StringLength(50, ErrorMessage = "The maximum length is 50 characters")]
        public string MunicipalityName {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        public int RegionId {get; set;}
    }
}