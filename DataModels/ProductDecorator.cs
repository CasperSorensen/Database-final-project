using System;
using database_final_project.Models;

namespace database_final_project
{
  public class ProductDecorator : IGift
  {
    public Product _product;

    public ProductDecorator(Product in_product)
    {
      this._product = in_product;

    }

    public virtual decimal nUnitPrice
    {
      get
      {
        return _product.nUnitPrice;
      }
      set
      {
        _product.nUnitPrice = value;
      }
    }

  }

}