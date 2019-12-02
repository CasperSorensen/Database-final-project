using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace database_final_project
{
    public class AzureDb
    {
        public AzureDb()
        {

        }

        public List<string> GetUsers()
        {
            List<string> result = new List<string>();
            try
            {
                
                //TODO Insert the real connection to the database
                // or maybe move the data to the connectionstring
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                builder.DataSource = "web-shop-server.database.windows.net";
                builder.UserID = "ServerUser";
                builder.Password = "SecretPassword123";
                builder.InitialCatalog = "WebShopDB";

                using (SqlConnection conn = new SqlConnection(builder.ConnectionString))
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

    }
}
