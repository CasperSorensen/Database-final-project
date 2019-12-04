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
        private static AzureDb instance = null;
        private static readonly object padlock = new object();

        #endregion

        public AzureDb()
        {
            this._builder = new SqlConnectionStringBuilder();
            _builder.DataSource = "web-shop-server.database.windows.net";
            _builder.UserID = "ServerUser";
            _builder.Password = "SecretPassword123";
            _builder.InitialCatalog = "WebShopDB";
        }

        public static AzureDb Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new AzureDb();
                    }
                    return instance;
                }
            }
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

        public List<Product> GetProducts()
        {
            List<Product> result = new List<Product>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select * from [dbo].TProduct";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var product = Factory.CreateProduct();
                        product.cname = reader["cName"].ToString();
                        product.cdescription = reader["cdescription"].ToString();
                        product.nStock = int.Parse (reader["nStock"].ToString());
                        product.nProductId = int.Parse(reader["nProductId"].ToString());
                        product.nUnitPrice = decimal.Parse(reader["nUnitPrice"].ToString());
                        result.Add(product);
                    }

                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }
            return result;


           
        }

        public List<CreditCard> GetCreditCardsForUser(int UserId)
        {
            List<CreditCard> cards = new List<CreditCard>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select * from [dbo].TCreditCard Where nUserId = @UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    var card = Factory.CreateCreditCard();
                    while (reader.Read())
                    {

                        card.nCreditCardId = int.Parse(reader["nCreditCardId"].ToString());
                        card.nIBANCode = int.Parse(reader["nIBANCode"].ToString());
                        card.dExpDate = DateTime.Parse(reader["dExpDate"].ToString());
                        cards.Add(card);

                    }

                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }
            return cards;



        }
        #endregion
    }
}
