using database_final_project;

namespace database_final_project.Models
{
  public class Factory
  {
    public Factory()
    {

    }

    public static Product CreateProduct()
    {
      return new Product();
    }

    public static User CreateUser()
    {
      return new User();
    }

    public static Rating CreateRating()
    {
      return new Rating();
    }

    public static Invoice CreateInvoice()
    {
      return new Invoice();
    }

    public static InvoiceLine CreateInvoiceLine()
    {
      return new InvoiceLine();
    }

    public static CreditCard CreateCreditCard()
    {
      return new CreditCard();
    }

  }
}