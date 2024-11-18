using coink_api.Models;
using coink_api.DTOs;

namespace coink_api.Services{
    public interface IUserService{
        ServiceResult RegisterUser(User user);
        bool CheckPhoneExists(string phone);
        IEnumerable<UserByLocationDto> GetUsersByLocation(int countryId, int regionId, int municipalityId);
        ServiceResult UpdateUser(Guid userId, User user);
        ServiceResult DeleteUser(Guid userId);
    }
}