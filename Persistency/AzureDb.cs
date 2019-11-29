using System;
using System.Data.SqlClient;

namespace database_final_project
{
  public class AzureDb
  {
    public AzureDb()
    {

    }

    public static bool UserCheck(string Username)
    {
      bool isUser = false;
      try
      {
        //TODO Insert the real connection to the database
        // or maybe move the data to the connectionstring
        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
        builder.DataSource = "Adress of the server";
        builder.UserID = "id of the user";
        builder.Password = "password for the user";
        builder.InitialCatalog = "database name";

        using (SqlConnection conn = new SqlConnection(builder.ConnectionString))
        {
          conn.Open();
          string query = "Select * from [dbo].TUser where TUser.cName = @username";
          using (SqlCommand cmd = new SqlCommand(query, conn))
          {
            cmd.Parameters.AddWithValue("@username", Username);
            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
              if (sdr.HasRows)
              {
                isUser = true;
              }
            }
          }
        }
      }
      catch (SqlException e)
      {
        System.Console.WriteLine(e);
      }

      return isUser;
    }
  }
}