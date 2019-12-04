using Datamodels;

namespace database_final_project
{
    public class InvoiceLine : Data
    {
        #region Properties

        public int nInvoiceLineId { get; set; }
        public int nInvoiceId { get; set; }
        public int nProductId { get; set; }
        public int nQuantity { get; set; }

        #endregion

    }

}