using System;

namespace database_final_project
{
  public class Invoice
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