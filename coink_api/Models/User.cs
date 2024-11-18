using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace coink_api.Models{
    [Table("users")]
    public class User{
        [Key]
        [Column("user_id")]
        [Required(ErrorMessage = "This field is required")]
        public Guid UserId {get; set;}
        [Column("name")]
        [Required(ErrorMessage = "This field is required")]
        [StringLength(50, ErrorMessage = "The maximum length is 50 characters")]
        public string Name {get; set;} = string.Empty;
        [Column("phone")]
        [Required(ErrorMessage = "This field is required")]
        [StringLength(20, ErrorMessage = "The maximum length is 20 characters")]
        [RegularExpression(@"^\d+$", ErrorMessage = "The phone number must contain only digits.")]
        public string Phone {get; set;} = string.Empty;
        [Column("address")]
        [Required(ErrorMessage = "This field is required")]
        [StringLength(50, ErrorMessage = "The maximum length is 50 characters")]
        public string Address {get; set;} = string.Empty;
        [Required(ErrorMessage = "This field is required")]
        public int UserCountryId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        public int UserRegionId {get; set;}
        [Required(ErrorMessage = "This field is required")]
        public int UserMunicipalityId {get; set;}
    }
}