using coink_api.data;
using coink_api.Models;

namespace coink_api.Services{
    public class UserService: IUserService{
        private readonly ApplicationDbContext _context;

        public UserService(ApplicationDbContext context){
            _context = context;
        }

        public ServiceResult RegisterUser(User user){
            try{
                _context.Database.ExecuteSqlRaw(
                    "call sp_register_user({0}, {1}, {2}, {3}, {4}, {5})",
                    user.Name, user.Phone, user.Address, user.UserCountryId, user.UserRegionId, user.UserMunicipalityId
                );
                return new ServiceResult {Success = true};
            }
            catch(Exception ex){
                return new ServiceResult {Success = false, Message = ex.Message};
            }
        }

        public bool CheckPhoneExists(string phone){
            try{
                var result = _context.Database
                    .ExecuteSqlInterpolated($"select sp_check_phone_exists({phone})");
                return Convert.ToBoolean(result);
            }
            catch(Exception ex){
                return false;
            }
        }

        public IEnumerable<User> GetUsersByLocation(int countryId, int regionId, int municipalityId){
            return _context.Users.FromSqlRaw(
                "select * from sp_get_users_by_location({0}, {1}, {2})",
                countryId, regionId, municipalityId
            ).ToList();
        }

        public ServiceResult UpdateUser(Guid userId, User user){
            try{
                _context.Database.ExecuteSqlRaw(
                    "call sp_update_user({0}, {1}, {2}, {3}, {4}, {5}, {6})",
                    userId, user.Name, user.Phone, user.Address, user.UserCountryId,
                    user.UserRegionId, user.UserMunicipalityId
                );
                return new ServiceResult {Success = true};
            }
            catch(Exception ex){
                return new ServiceResult {Success = false, Message = ex.Message};
            }
        }

        public ServiceResult DeleteUser(Guid userId){
            try{
                _context.Database.ExecuteSqlRaw(
                    "call sp_delete_user({0})", userId
                );
                return new ServiceResult {Success = true};
            }
            catch(Exception ex){
                return new ServiceResult {Success = false, Message = ex.Message};
            }
        }
    }
}