using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace database_final_project.Models
{
  public class UserModel : IModel
  {
    public int UserId { get; set; }

    public string UserName { get; set; }
  }
}
