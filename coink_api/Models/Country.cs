using System.ComponentModel.DataAnnotations;

namespace coink_api.Models{
    public class Country{
        [Key]
        [Required(ErrorMessage = "This field is required")]
        public int CountryId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        [StringLength(35, ErrorMessage = "The maximum length is 35 characters")]
        public string CountryName {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        [StringLength(10, ErrorMessage = "The maximum length is 10 characters")]
        public string CountryCode {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        public int GlobalRegionId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        public int DivisionId {get; set;}
    }
}