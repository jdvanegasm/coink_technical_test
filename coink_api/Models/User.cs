namespace coink_api.Models{
    public class User{
        [Required(ErrorMessage = "This field is required")]
        public Guid UserId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(50, ErrorMessage = "The maximum length is 50 characters")]
        public string Name {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(20, ErrorMessage = "The maximum length is 20 characters")]
        public string Phone {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(50, ErrorMessage = "The maximum length is 50 characters")]
        public string Address {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        public int UserCountryId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        public int UserRegionId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        public int UserMunicipalityId {get; set;}
    }
}