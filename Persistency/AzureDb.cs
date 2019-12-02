using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using database_final_project.Models;

namespace database_final_project
{
  public class AzureDb
  {
    #region Properties
       
    private SqlConnectionStringBuilder _builder;

    #endregion


    public AzureDb()
    {
      this._builder = new SqlConnectionStringBuilder();
      _builder.DataSource = "web-shop-server.database.windows.net";
      _builder.UserID = "ServerUser";
      _builder.Password = "SecretPassword123";
      _builder.InitialCatalog = "WebShopDB";
    }

    #region Methods

    public List<string> GetUsers()
    {
      List<string> result = new List<string>();
      try
      {
        using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
        {
          conn.Open();
          string query = "Select * from [dbo].TUser";
          SqlCommand cmd = new SqlCommand(query, conn);
          SqlDataReader reader = cmd.ExecuteReader();

          while (reader.Read())
          {
            result.Add(reader["cFirstName"].ToString());
          }

        }
      }
      catch (SqlException e)
      {
        System.Console.WriteLine(e);
      }
      return result;

    }


       public UserModel LoginUser(UserModel user)
        {
            var id = user.UserId;
            UserModel result = new UserModel();
            
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select * from [dbo].TUser Where TUser.nUserId = @Id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            result.UserId = int.Parse(reader["nUserId"].ToString());
                            result.UserName = reader["cFirstName"].ToString();
                        }
                       
                    }
                    else
                    {
                        return result;
                    }

                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }
            return result;

        }

        #endregion
    }
}
