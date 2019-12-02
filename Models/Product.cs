namespace database_final_project
{
  public class Product
  {
    #region Properties

    public int nProductId { get; set; }
    public string cname { get; set; }
    public string cdescription { get; set; }
    public decimal nUnitPrice { get; set; }
    public int nStock { get; set; }
    public decimal nAvgRating { get; set; }

    #endregion

  }

}