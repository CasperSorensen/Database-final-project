using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace database_final_project.Models
{
    public class InvoiceModel
    {
        public int UserId { get; set; }
        public Int64 CreditCardId { get; set; }
        public string Products { get; set; }
        public decimal Total { get; set; }
        public decimal Tax { get; set; }

    }
}
