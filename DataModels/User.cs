using database_final_project;

namespace database_final_project
{
  public class User : IModel
  {
    #region Properties

    public int nUserId { get; set; }
    public string cFirstName { get; set; }
    public string cSurname { get; set; }
    public string cAdress { get; set; }
    public string cZipcode { get; set; }
    public string cCity { get; set; }
    public string cPhoneNo { get; set; }
    public string cEmail { get; set; }
    public decimal nAmountSpent { get; set; }

    #endregion

  }

}