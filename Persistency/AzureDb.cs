using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using database_final_project.Models;
using System.Data;
using database_final_project.Patterns;
using Newtonsoft.Json;

namespace database_final_project
{
    public class AzureDb
    {
        #region Properties

        private SqlConnectionStringBuilder _builder;
        private static AzureDb instance = null;
        private static readonly object padlock = new object();

        #endregion

        private AzureDb()
        {
            this._builder = new SqlConnectionStringBuilder();
            _builder.ConnectionString = @"Server=DESKTOP-2OUIUJB\SQLEXPRESS;Initial Catalog=WebShopDb;User Id=DBAdmin;Password=StrongPassword123;";
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

        /// <summary>
        /// Fetches all Products
        /// </summary>
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
                        var product = (Product)ModelFactory.Build("product");
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

        /// <summary>
        /// Fetches the average Product rating 
        /// based on ProductId 
        /// </summary>
        public decimal GetAverageProductRating(int ProductId)
        {
            decimal AvgRating = 0;           
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select nAvgRating from TProduct Where nProductId = @Id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", ProductId);
                    AvgRating = Convert.ToDecimal(cmd.ExecuteScalar());
                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }
            return AvgRating;
        }

        /// <summary>
        /// Fetches Products based on an search string
        /// </summary>
        public List<Product> SearchProducts(string in_request)
        {
            List<Product> result = new List<Product>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select * from [dbo].TProduct WHERE TProduct.cName LIKE @request Or TProduct.cDescription LIKE @request";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@request", "%" + in_request + "%");
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Product product =  (Product)ModelFactory.Build("product") as Product;
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

        /// <summary>
        /// Fetches a list of Products 
        /// based on the Min Price and Max Price
        /// </summary>
        public List<Product> SearchProductsOnPrice(int in_min, int in_max)
        {
            if (in_max == 0)
            {
                in_max = 1000;
            }

            List<Product> result = new List<Product>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
                {
                    conn.Open();
                    string query = "Select * from [dbo].TProduct WHERE TProduct.nUnitPrice >= @min AND TProduct.nUnitPrice <= @max Order by nUnitPrice";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@min", in_min);
                    cmd.Parameters.AddWithValue("@max", in_max);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var product = (Product)ModelFactory.Build("product");
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

        /// <summary>
        /// Fetches a list of Creditcards 
        /// based on a UserId
        /// </summary>
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
                        var card = (CreditCard)ModelFactory.Build("creditcard");

                        card.nCreditCardId = int.Parse(reader["nCreditCardId"].ToString());
                        card.nIBANCode = Int64.Parse(reader["nIBANCode"].ToString());
                        card.dExpDate = reader["dExpDate"].ToString();
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

        /// <summary>
        /// Inserts in new Invoice
        /// Inserts all the InvoiceLines
        /// and updates the associated tables
        /// </summary>
        public int InvoiceTransaction(InvoiceModel model)
        {
            Dictionary<int, int> basket = JsonConvert.DeserializeObject<Dictionary<int, int>>(model.Products);
            using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction(IsolationLevel.Serializable);
                SqlCommand cmd = conn.CreateCommand();
                cmd.Transaction = tran;

                try
                {
                    if (basket.Count == 0)
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
                    int InvoiceId = Convert.ToInt32(cmd.ExecuteScalar());

                    foreach (var product in basket)
                    {
                        int ProductID = product.Key;
                        int Quantity = product.Value;

                        //get stock
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string SelectStockQuery = @"SELECT [nStock]FROM[dbo].[TProduct] Where nProductId=@ProductId";
                        cmd.CommandText = SelectStockQuery;
                        cmd.Parameters.AddWithValue("@ProductId", ProductID);
                        int stock = Convert.ToInt32(cmd.ExecuteScalar());

                        if (stock < Quantity)
                        {
                            throw new Exception("Sorry but one or more items in your basket is out of stock, Terminating the purchace...");
                        }

                        //get unit price
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

                        var CardId = model.CreditCardId;
                        var UserId = model.UserId;
                        decimal TotalPrice = model.Total;

                        //get current total from user table
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string Userquery = "Select nTotalAmount FROM TUser WHERE nUserId = @UserId";
                        cmd.CommandText = Userquery;
                        cmd.Parameters.AddWithValue("@UserId", UserId);

                        decimal TotalAmount = Convert.ToDecimal(cmd.ExecuteScalar());
                        decimal NewTotal = TotalAmount + UnitPrice * Quantity;

                        //Update User Table
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string UserUpdateQuery = "UPDATE TUser SET nTotalAmount = @NewTotal WHERE nUserId = @UserId";
                        cmd.CommandText = UserUpdateQuery;
                        cmd.Parameters.AddWithValue("@NewTotal", NewTotal);
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.ExecuteNonQuery();

                        //Get Credit Card Total
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string NewQuery = "Select nAmountSpent FROM TCreditCard WHERE nCreditCardId = @CardId";
                        cmd.CommandText = NewQuery;
                        cmd.Parameters.AddWithValue("@CardId", CardId);

                        decimal AmountSpent = Convert.ToDecimal(cmd.ExecuteScalar());
                        decimal NewAmountSpent = AmountSpent + UnitPrice * Quantity;

                        //Update CreditCard Table
                        cmd = conn.CreateCommand();
                        cmd.Transaction = tran;
                        string CardUpdateQuery = "UPDATE TCreditCard SET nAmountSpent = @NewAmount WHERE nCreditCardId = @CardId";
                        cmd.CommandText = CardUpdateQuery;
                        cmd.Parameters.AddWithValue("@NewAmount", NewAmountSpent);
                        cmd.Parameters.AddWithValue("@CardId", CardId);
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

        /// <summary>
        /// Fetches the UnitPrice for a single Product
        /// </summary>
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
                }
            }
            catch (SqlException e)
            {
                System.Console.WriteLine(e);
            }

            return result;
        }

        /// <summary>
        /// Inserts in new Rating
        /// and updates the Products Avg rating
        /// </summary>
        public int InsertRating(int UserId, int ProductId, int Rating, string Comment)
        {
            using (SqlConnection conn = new SqlConnection(_builder.ConnectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction(IsolationLevel.Serializable);
                SqlCommand cmd = conn.CreateCommand();
                cmd.Transaction = tran;

                try
                {

                    if (Comment==null)
                    {
                        Comment = " ";
                    }
                    //insert Rating
                    string query = "Insert Into TRating ([nProductId],[nUserId],[nRating],[cComment]) Values (@ProductId, @UserId, @Rating, @Comment)";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.Parameters.AddWithValue("@Rating", Rating);
                    cmd.Parameters.AddWithValue("@Comment", Comment);
                    cmd.ExecuteNonQuery();


                    //get all ratings
                    cmd = conn.CreateCommand();
                    cmd.Transaction = tran;
                    string GetRatingsquery = "Select * FROM TRating WHERE nProductId = @ProductId ";
                    cmd.CommandText = GetRatingsquery;
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    List<int> Ratings = new List<int>();
                    decimal total = 0;
                    while (reader.Read())
                    {
                        var SingleRating = Convert.ToInt32(reader["nRating"]);
                        total += SingleRating;
                        Ratings.Add(SingleRating);
                    }
                    reader.Close();
                    var Count = Ratings.Count;

                    //calculate avg
                    decimal AverageRating = total / Count;

                    //insert avg
                    cmd = conn.CreateCommand();
                    cmd.Transaction = tran;
                    string InsertAvGRating = "UPDATE TProduct SET nAvgRating = @AverageRating WHERE nProductId = @ProductId";
                    cmd.CommandText = InsertAvGRating;
                    cmd.Parameters.AddWithValue("@AverageRating", AverageRating);
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.ExecuteNonQuery();

                    tran.Commit();
                    conn.Close();
                    return 1;

                }
                catch (SqlException ex)
                {
                    tran.Rollback();
                    conn.Close();
                    throw ex;
                }
            }
        }

        #endregion
    }
}
