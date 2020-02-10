using database_final_project;
using database_final_project.DataModels;
using database_final_project.Models;

namespace database_final_project.Patterns
{
  public class ModelFactory
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
        case "creditcard":
          return new CreditCard();
        case "ratemodel":
          return new RateModel();
        case "usermodel":
          return new UserModel();
        default:
          return new NullModel();
      }
    }
  }

}

