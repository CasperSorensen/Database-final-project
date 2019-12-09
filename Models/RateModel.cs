using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace database_final_project.Models
{
    public class RateModel
    {
        public int UserId { get; set; }

        public int ProductId { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; }

    }
}
