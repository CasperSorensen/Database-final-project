using System;
using database_final_project.Models;

namespace database_final_project
{
  public class GiftDecorator : ProductDecorator
  {
        public IGift _In_product;
    public GiftDecorator(IGift in_product)
    : base(in_product)
    {
            this._In_product = in_product;
    }

      public override decimal GetnUnitPrice()
    {
            Product product = (Product)_In_product;
             return product.nUnitPrice+20;
            
    }

     
  }

}