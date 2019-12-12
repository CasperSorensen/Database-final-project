using System;
using database_final_project;

namespace database_final_project
{
  public class Invoice : IModel
  {
    #region Properties

    public int nInvoiceId { get; set; }
    public int nUserId { get; set; }
    public int nCreditCardId { get; set; }
    public int nTax { get; set; }
    public decimal nTotalAmount { get; set; }
    public DateTime dDate { get; set; }

    #endregion

  }

}
