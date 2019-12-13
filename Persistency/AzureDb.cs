using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using database_final_project.Models;
using System.Data;

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
        public int InvoiceTransaction(ObjectOfFieldsForDatabase model,Dictionary<int,int> basket)
        {
            int InvoiceId = 0;   
            using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction(IsolationLevel.Serializable);
                SqlCommand cmd = conn.CreateCommand();
                cmd.Transaction = tran;
                
                try
                {
                if (basket.Count==0)
                {
                    throw new Exception("basket was empty");
                }

                    //insert invoice
                    string query = "EXEC pro_CreateInvoice @nUserId = @UserId, @nCardId = @CardId, @dTax = @Tax, @nTotalAmount = @TotalAmount, @dDate = @Date";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@UserId", model.UserId);
                    cmd.Parameters.AddWithValue("@CardID", model.CreditCardId);
                    cmd.Parameters.AddWithValue("@Tax", model.Tax);
                    cmd.Parameters.AddWithValue("@TotalAmount", model.Total);
                    cmd.Parameters.AddWithValue("@Date", DateTime.Now);
                   cmd.ExecuteNonQuery();
                    
                    //get invoice Id
                    string SelectQuery = @"SELECT TOP (1) [nInvoiceId]FROM[dbo].[TInvoice]ORDER BY nDate Desc";
                    cmd.CommandText = SelectQuery;
                    InvoiceId = Convert.ToInt32(cmd.ExecuteScalar());

                    
                   

                    foreach (var product in basket)
                    {
                        int ProductID = product.Key;
                        int Quantity = product.Value;

                        //get stock
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string SelectStockQuery = @"SELECT TOP (1) [nStock]FROM[dbo].[TProduct] Where nProductId=@ProductId";
                        cmd.CommandText = SelectStockQuery;
                        cmd.Parameters.AddWithValue("@ProductId", ProductID);
                        int stock = Convert.ToInt32(cmd.ExecuteScalar());

                        if (stock < Quantity)
                        {
                            throw new Exception("Sorry but one or more items in your basket is out of stock, Terminating the purchace...");
                        }


                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;                                                
                        decimal UnitPrice = AzureDb.Instance.GetUnitPriceForProduct(ProductID);

                        //inser invoice line
                        string newquery = "EXEC pro_CreateInvoiceLine @nInvoiceId = @InvoiceId, @nProductId = @ProductId, @nQuantity = @Quantity, @nUnitPrice = @UnitPrice";
                        cmd.CommandText = newquery;
                        cmd.Parameters.AddWithValue("@InvoiceId", InvoiceId);
                        cmd.Parameters.AddWithValue("@ProductId", ProductID);
                        cmd.Parameters.AddWithValue("@Quantity", Quantity);
                        cmd.Parameters.AddWithValue("@UnitPrice", UnitPrice);
                        cmd.ExecuteNonQuery();


                        //update stocks
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        int NewStock = stock - Quantity;
                        string stockUpdateQuery = "UPDATE TProduct SET nStock = @NewStock WHERE nProductId = @ProductId";
                        cmd.CommandText = stockUpdateQuery;
                        cmd.Parameters.AddWithValue("@NewStock", NewStock);
                        cmd.Parameters.AddWithValue("@ProductId", ProductID);
                        cmd.ExecuteNonQuery();


                    }


                        


                tran.Commit();
                    conn.Close();
                return 1;
                }
                catch
                {
                    tran.Rollback();
                    conn.Close();
                    throw;
                        
                }
                
            }
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
                    string query = "Insert Into TRating ([nProductId],[nUserId],[nRating],[cComment]) Values (@ProductId, @UserId, @Rating, @Comment)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
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
