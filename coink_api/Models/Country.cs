namespace coink_api.Models{
    public class Country{
        public int CountryId {get; set;}
        public string CountryName {get; set;} = string.Empty;
        public string CountryCode {get; set;} = string.Empty;
        public int GlobalRegionId {get; set;}
        public int DivisionId {get; set;}
    }
}