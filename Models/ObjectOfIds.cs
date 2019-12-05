using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace database_final_project.Models
{
    public class ObjectOfFieldsForDatabase
    {
        public int UserId { get; set; }
        public int CreditCardId { get; set; }
        public string Products { get; set; }
        public decimal Total { get; set; }
        public decimal Tax { get; set; }

    }
}
