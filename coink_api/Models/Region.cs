using System.ComponentModel.DataAnnotations;

namespace coink_api.Models{
    public class Region{
        [Key]
        [Required(ErrorMessage = "This field is required")]
        public int RegionId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        [StringLength(50, ErrorMessage = "The maximum length is 50 characters")]
        public string RegionName {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        public int CountryId {get; set;}
    }
}