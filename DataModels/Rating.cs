using database_final_project;

namespace database_final_project
{
  public class Rating : IModel
  {
    #region Properties

    public int nRatingId { get; set; }
    public int nProductId { get; set; }
    public int nuserId { get; set; }
    public int nRating { get; set; }
    public string cComment { get; set; }

    #endregion

  }

}