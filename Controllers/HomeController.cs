using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using database_final_project.Models;
using Newtonsoft.Json;
using database_final_project.Patterns;

namespace database_final_project.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
                return View();
            
        }

        public IActionResult CheckoutPage(InvoiceModel data)
        {
            return View(data);
        }

        public IActionResult Login(UserModel model)
        {
            var UserData = AzureDb.Instance.LoginUser(model);
            if (UserData.UserId == 0)
            {
                TempData["IsLoggedIn"] = "";
                TempData["LogginMessage"] = "No user with such Id in Our Database";
                return View("./Index");
            }
            else
            {
                TempData["IsLoggedIn"] = UserData.UserName + "," + UserData.UserId;
                return View("./Index", UserData);
            }
        }

        public IActionResult AddToBasket(Product SelectedProduct)
        {

            var basketAsObj = TempData["Basket"];

            //basket not yet existing -create it
            if (basketAsObj == null)
            {

                //first int is product id , second int is quantity
                Dictionary<int, int> Basket = new Dictionary<int, int>();
                Basket.Add(SelectedProduct.nProductId, 1);
                var JsonString = JsonConvert.SerializeObject(Basket);
                TempData["basket"] = JsonString;


            }
            else
            //basket allready existing - add to it
            {
                var basket = basketAsObj.ToString();
                Dictionary<int, int> Basket = JsonConvert.DeserializeObject<Dictionary<int, int>>(basket);
                int Id = SelectedProduct.nProductId;
                //this product is allready in basket - increase quantity
                if (Basket.ContainsKey(Id))
                {
                    int quant = Basket.GetValueOrDefault(Id);
                    Basket.Remove(Id);
                    Basket.Add(Id, quant + 1);                   

                }
                //product is not yet in basket - just add it in
                else
                {
                    Basket.Add(Id, 1);

                }

                var JsonString = JsonConvert.SerializeObject(Basket);
                TempData["basket"] = JsonString;

            }

            return View("./Products");
        }

        public IActionResult RateProduct(RateModel RateModel)
        {
            return View("./RateProduct", RateModel);
        }

        public IActionResult DoneRate(RateModel RateModel)
        {
            var isLoggedIn = TempData["IsLoggedIn"].ToString();         
            var id = int.Parse(isLoggedIn.ToString().Split(',').ElementAt(1));

            // rating insert           
            var UserData = AzureDb.Instance.InsertRating(id, RateModel.ProductId, RateModel.Rating, RateModel.Comment);
            if (UserData == 0)
            {
                TempData["RatingMsg"] = "Rating Failed";
            }
            else
            {
                TempData["RatingMsg"] = "Rating was succesfull";
            }
            return View("./Index");
        }

        public IActionResult ProductDetails(Product ProductModel)
        {
            var AvgRating = AzureDb.Instance.GetAverageProductRating(ProductModel.nProductId);
            ProductModel.nAvgRating = AvgRating;
            return View("./ProductDetails", ProductModel);
        }

        public IActionResult Logout()
        {

            TempData["IsLoggedIn"] = null;
            TempData["Basket"] = null;
            return View("./Index");
        }

        public IActionResult Checkout()
        {
            return View("./CheckoutPage");
        }

        public IActionResult Basket()
        {
            return View("./Basket");
        }

        public IActionResult ClearBasket()
        {
            TempData["Basket"] = null;           
            return View("./Basket");
        }

        public IActionResult Products()
        {
            return View();
        }

        public IActionResult SearchProducts(string request)
        {
            TempData["SearchRequest"] = request;
            return View("./Products");
        }

        public IActionResult SearchProductsOnPrice(int in_min, int in_max)
        {
            TempData["MinPrice"] = in_min;
            TempData["MaxPrice"] = in_max;

            return View("./Products");
        }

        public IActionResult ClearSearchProducts()
        {
            TempData["SearchRequest"] = null;

            return View("./Products");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
