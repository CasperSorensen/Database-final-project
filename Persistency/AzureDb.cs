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
                        product.nStock = int.Parse(reader["nStock"].ToString());
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
                    
                    while (reader.Read())
                    {
                        var card = Factory.CreateCreditCard();

                        card.nCreditCardId = int.Parse(reader["nCreditCardId"].ToString());
                        card.nIBANCode = Int64.Parse(reader["nIBANCode"].ToString());
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

        public int InsertInvoice(ObjectOfFieldsForDatabase in_invoice)
        {
            int Id = 0;
            try
            {
               
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    
                    conn.Open();
                    string query = "EXEC pro_CreateInvoice @nUserId = @UserId, @nCardId = @CardId, @dTax = @Tax, @nTotalAmount = @TotalAmount, @dDate = @Date";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", in_invoice.UserId);
                    cmd.Parameters.AddWithValue("@CardID", in_invoice.CreditCardId);
                    cmd.Parameters.AddWithValue("@Tax", in_invoice.Tax);
                    cmd.Parameters.AddWithValue("@TotalAmount", in_invoice.Total);
                    cmd.Parameters.AddWithValue("@Date", DateTime.Now);
                    var res = cmd.ExecuteReader();
                    conn.Close();

                    conn.Open();
                    string SelectQuery = @"SELECT TOP (1) [nInvoiceId]FROM[dbo].[TInvoice]ORDER BY nDate Desc";
                    cmd = new SqlCommand(SelectQuery, conn);

                    

                    Id  = Convert.ToInt32(cmd.ExecuteScalar());
                   
                 


                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }

            return Id;
        }

        public int InsertInvoiceLine(int InvoiceId, int ProductId, int Quantity,decimal UnitPrice)
        {
            var result = 0;   
            try
            {

                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {

                    conn.Open();
                    string query = "EXEC pro_CreateInvoiceLine @nInvoiceId = @InvoiceId, @nProductId = @ProductId, @nQuantity = @Quantity, @nUnitPrice = @UnitPrice";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@InvoiceId", InvoiceId);
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.Parameters.AddWithValue("@Quantity", Quantity);
                    cmd.Parameters.AddWithValue("@UnitPrice", UnitPrice);

                    result = cmd.ExecuteNonQuery();
                    conn.Close();

                    //conn.Open();
                    //string SelectQuery = @"SELECT TOP (1) [nInvoiceId]FROM[dbo].[TInvoice]ORDER BY nDate Desc";
                    //cmd = new SqlCommand(SelectQuery, conn);

                    //int result = int.Parse(cmd.ExecuteScalar().ToString());

                   




                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }

            return result;
        }

        public decimal GetUnitPriceForProduct(int productId)
        {
            decimal result = 0;
            try
            {

                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {

                    conn.Open();
                    string query = "Select nUnitPrice FROM TProduct WHERE nProductId = @ProductId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    result = Convert.ToDecimal(cmd.ExecuteScalar());
                    conn.Close();

                    //conn.Open();
                    //string SelectQuery = @"SELECT TOP (1) [nInvoiceId]FROM[dbo].[TInvoice]ORDER BY nDate Desc";
                    //cmd = new SqlCommand(SelectQuery, conn);

                    //int result = int.Parse(cmd.ExecuteScalar().ToString());


                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }

            return result;
        }

        public int InsertRating(int UserId, int ProductId, int Rating, string Comment)
        {
            var result = 0;
            try
            {

                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {

                    conn.Open();
                    string query = "EXEC pro_CreateInvoiceLine @nUserId = @UserId, @nProductId = @ProductId, @nRating = @Rating, @nComment = @Comment";
                    SqlCommand cmd = new SqlCommand(query, conn);                 
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.Parameters.AddWithValue("@Rating", Rating);
                    cmd.Parameters.AddWithValue("@Comment", Comment);

                    result = cmd.ExecuteNonQuery();
                    conn.Close();

                    //conn.Open();
                    //string SelectQuery = @"SELECT TOP (1) [nInvoiceId]FROM[dbo].[TInvoice]ORDER BY nDate Desc";
                    //cmd = new SqlCommand(SelectQuery, conn);

                    //int result = int.Parse(cmd.ExecuteScalar().ToString());

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
