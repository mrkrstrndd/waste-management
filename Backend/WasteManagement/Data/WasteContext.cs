using Microsoft.EntityFrameworkCore;
using WasteManagement.Entities;

namespace WasteManagement.Data
{
    public class WasteContext : DbContext
    {
        public WasteContext(DbContextOptions<WasteContext> options) : base(options)
        {

        }

        public DbSet<User> User {  get; set; }
    }
}
