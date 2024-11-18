namespace coink_api.Models{
    public class DivisionType{
        [Required(ErrorMessage = "This field is required")]
        public int DivisionId {set; get;}
        [Required(ErrorMessage = "This field is required")]
        [StringLenght(40, ErrorMessage = "The maximum length is 40 characters")]
        public string Type {set; get;} = string.Empty;
    }
}