using System;
using System.Data.SqlClient;

namespace database_final_project
{
  public class AzureDb
  {
    public AzureDb()
    {

    }

    // In here the methods for connecting 
    // to the database should be located
    /*
    try
      {
        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
        builder.DataSource = "name of the mssql server";
        builder.UserID = "userid";
        builder.Password = "password";
        builder.InitialCatalog = "The name of the database";

        using (SqlConnection conn = new SqlConnection(builder.ConnectionString))
        {
          conn.Open();
          string query = "Select * from [dbo].TBook";
          using (SqlCommand cmd = new SqlCommand(query, conn))
          {
            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
              while (sdr.Read())
              {
                Console.WriteLine("BookId: {0} BookTitle: {1}", sdr.GetInt32(0), sdr.GetString(1));
              }
            }
          }
        }
      }
      catch (SqlException e)
      {
      }    
     */
  }
}