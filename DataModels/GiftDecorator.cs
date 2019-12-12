using System;
using database_final_project.Models;

namespace database_final_project
{
  public class GiftDecorator : ProductDecorator
  {

    public GiftDecorator(Product in_product)
    : base(in_product)
    {

    }

    public override decimal nUnitPrice
    {
      get
      {
        return base._product.nUnitPrice + 20;
      }
      set
      {
        _product.nUnitPrice = value;
      }
    }

  }

}