namespace coink_api.Models{
    public class GlobalRegion{
        [Required(ErrorMessage = "This field is required")]
        public int GlobalRegionId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(10, ErrorMessage = "The maximum length is 10 characters")]
        public string GlobalRegionCode {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(40, ErrorMessage = "The maximum length is 40 characters")]
        public string GlobalRegionName {get; set;} = string.Empty;
    }
}