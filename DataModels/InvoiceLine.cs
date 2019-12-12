using database_final_project;

namespace database_final_project
{
  public class InvoiceLine : IModel
  {
    #region Properties

    public int nInvoiceLineId { get; set; }
    public int nInvoiceId { get; set; }
    public int nProductId { get; set; }
    public int nQuantity { get; set; }

    #endregion

  }

}