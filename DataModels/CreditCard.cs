using System;
using database_final_project;

namespace database_final_project
{
  public class CreditCard : IModel
  {
    #region Properties

    public int nCreditCardId { get; set; }
    public int nUserId { get; set; }
    public Int64 nIBANCode { get; set; }
    public string dExpDate { get; set; }
    public int nCcv { get; set; }
    public string cCardHolderName { get; set; }
    public decimal nTotalAmount { get; set; }

    #endregion

  }

}