namespace coink_api.Models{
    public class User{
        public Guid UserId {get; set;}
        public string Name {get; set;} = string.Empty;
        public string Phone {get; set;} = string.Empty;
        public string Address {get; set;} = string.Empty;
        public int UserCountryId {get; set;}
        public int UserRegionId {get; set;}
        public int UserMunicipalityId {get; set;}
    }
}