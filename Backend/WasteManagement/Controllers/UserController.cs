using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WasteManagement.Data;

namespace WasteManagement.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly WasteContext context;
        public UserController(WasteContext _context)
        {
            context = _context;
        }

        [HttpGet(Name = "User")]
        public IActionResult Get()
        {
            var users = context.User.Select(x => x);
            return Ok(users);
        }
    }
}
