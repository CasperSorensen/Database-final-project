using System;
using Datamodels;

namespace database_final_project
{
    public class CreditCard : Data
    {
        #region Properties

        public int nCreditCardId { get; set; }
        public int nUserId { get; set; }
        public string nIBANCode { get; set; }
        public DateTime dExpDate { get; set; }
        public int nCcv { get; set; }
        public string cCardHolderName { get; set; }
        public decimal nTotalAmount { get; set; }

        #endregion

    }

}