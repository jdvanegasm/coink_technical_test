using Microsoft.AspNetCore.Mvc;
using coink_api.Services;
using coink_api.Models;

namespace coink_api.Controllers{
    [ApiController]
    [Route("api/[Controller]")]
    public class UsersController : ControllerBase{
        private readonly IUserService _userService;
        public UsersController(IUserService userService){
            _userService = userService;
        }

        // post: api/users
        [HttpPost]
        public IActionResult RegisterUser([FromBody] UsersController user){
            var result = _userService.RegisterUser(user);
            if (!result.Success){
                return BadRequest(result.Message);
            }
            return Ok(new {Message = "User registered succesfully!"});
        }

        // get: api/users/check-phone?pone=1234567890
        [HttpGet("check-phone")]
        public IActionResult CheckPhone(string phone){
            var exist = _userService.CheckPhoneExists(phone);
            return Ok(new {PhoneExists = exists});
        }

        // get: api/users/by-location?countryId=1&regionId=1&municipalityId=1
        [HttpGet("by-location")]
        public IActionResult GetUsersByLocation(int countryId, int regionId, int municipalityId){
            var users = _userService.GetUsersByLocation(countryId, regionId, municipalityId);
            return Ok(users);
        }

        // put: api/users/{id}
        [HttpPut("{id}")]
        public IActionResult UpdateUser(Guid id, [FromBody] User user){
            var result = _userService.UpdateUser(id, user);
            if(!result.Success){
                return BadRequest(result.Message);
            }

            return Ok(new {Message = "User updated successfully!"});
        }

        // delete: api/users/{id}
        [HttpDelete("{id}")]
        public IActionResult DeleteUser(Guid id){
            var result = _userService.DeleteUser(id);
            if(!result.Success){
                return BadRequest(result.Message);
            }

            return Ok(new {Message = "User deleted successfully!"});
        }
    }
}