using Microsoft.EntityFrameworkCore;
using coink_api.Models;
using coink_api.data;
using coink_api.DTOs;

namespace coink_api.Services{
    public class UserService: IUserService{
        private readonly ApplicationDbContext _context;

        public UserService(ApplicationDbContext context){
            _context = context;
        }

        public ServiceResult RegisterUser(User user){
            try{
                var nameExists = _context.Users.Any(u => u.Name == user.Name);
                if(nameExists){
                    return new ServiceResult{
                        Success = false,
                        Message = "An user with this name already exists."
                    };
                }

                var phoneExists = _context.Users.Any(u => u.Phone == user.Phone);
                if (phoneExists){
                    return new ServiceResult{
                        Success = false,
                        Message = "An user with this phone number already exists."
                    };
                }

                _context.Database.ExecuteSqlRaw(
                    "select sp_register_user({0}, {1}, {2}, {3}, {4}, {5})",
                    user.Name, user.Phone, user.Address, user.UserCountryId, user.UserRegionId, user.UserMunicipalityId
                );
                return new ServiceResult {Success = true};
            }
            catch (Exception ex){
                return new ServiceResult {Success = false, Message = ex.Message};
            }
        }

        public bool CheckPhoneExists(string phone){
            try{
                var result = _context.Database
                    .ExecuteSqlInterpolated($"select sp_check_phone_exists({phone})");
                return Convert.ToBoolean(result);
            }
            catch(Exception){
                return false;
            }
        }

        public IEnumerable<UserByLocationDto> GetUsersByLocation(int countryId, int regionId, int municipalityId){
            return _context.Set<UserByLocationDto>().FromSqlRaw(
                "select * from sp_get_users_by_location({0}, {1}, {2})",
                countryId, regionId, municipalityId
            ).ToList();
        }

        public ServiceResult UpdateUser(Guid userId, User user){
            try{
                _context.Database.ExecuteSqlRaw(
                    "select sp_update_user({0}, {1}, {2}, {3}, {4}, {5}, {6})",
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
                    "select sp_delete_user({0})", userId
                );
                return new ServiceResult {Success = true};
            }
            catch(Exception ex){
                return new ServiceResult {Success = false, Message = ex.Message};
            }
        }
    }
}