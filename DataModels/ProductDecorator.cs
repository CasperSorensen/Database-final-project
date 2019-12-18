using System;
using database_final_project.Models;

namespace database_final_project
{
  public abstract class ProductDecorator : IGift
  {
    public IGift _Igift;

    public ProductDecorator(IGift in_product)
    {
      this._Igift = in_product;

    }

        public abstract decimal GetnUnitPrice();

  }

}