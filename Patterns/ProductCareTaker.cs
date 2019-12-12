﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace database_final_project.Patterns
{
    public class ProductCareTaker
    {
        private Product _Product;
        

        public ProductCareTaker(Product product)
        {
            _Product=product;
        }

        public Product GetInstance() 
        {
            if (_Product==null)
            {
                return null;
            }
            else
            {
                return _Product;
            }
        }
    }
}
