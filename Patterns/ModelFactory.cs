using database_final_project;
using database_final_project.Models;

namespace database_final_project.Patterns
{
  public static class ModelFactory
  {

    public static IModel Build(string in_model)
    {
      switch (in_model)
      {
        case "product":
          return new Product();
        case "rating":
          return new Rating();
        case "user":
          return new User();
        case "invoice":
          return new Invoice();
        case "invoiceline":
          return new InvoiceLine();
        case "creditcard":
          return new CreditCard();
        case "ratemodel":
          return new RateModel();
        case "usermodel":
          return new UserModel();
        default:
          return null;
      }
    }
  }

}

