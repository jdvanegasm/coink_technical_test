using coink_api.Models;

namespace coink_api.Services{
    public interface IUserService{
        ServiceResult RegisterUser(User user);
        bool CheckPhoneExists(string phone);
        IEnumerable<User> GetUsersByLocation(int countryId, int regionId, int municipalityId);
        ServiceResult UpdateUser(Guid userId, User user);
        ServiceResult DeleteUser(Guid userId);
    }
}