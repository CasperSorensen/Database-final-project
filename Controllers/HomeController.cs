using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using database_final_project.Models;
using Newtonsoft.Json;

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

            if (TempData["IsLoggedIn"] == null)
            {
                TempData["IsLoggedIn"] = string.Empty;
                return View();
            }
            else
            {
                return View();
            }

        }

        public IActionResult CheckoutPage(ObjectOfFieldsForDatabase data)
        {




            return View(data);
        }
     

        public IActionResult Login(UserModel model)
        {
            var UserData = new AzureDb().LoginUser(model);
            if (UserData.UserId == 0)
            {
                TempData["IsLoggedIn"] = "";
                TempData["LogginMessage"] = "No user with such Id in Our Database";
                return View("./Index");
            }
            else
            {


                TempData["IsLoggedIn"] = UserData.UserName +","+ UserData.UserId;
                return View("./Index", UserData);
            }
        }
        public IActionResult AddToBasket(Product SelectedProduct)
        {
            var basketAsObj = TempData["Basket"];
            
            if (basketAsObj == string.Empty || basketAsObj == null)
            {
                
                //first int is product id , second int is quantity
                Dictionary<int, int> Basket = new Dictionary<int, int>();
                Basket.Add(SelectedProduct.nProductId, 1);
                var JsonString = JsonConvert.SerializeObject(Basket);
                TempData["basket"] = JsonString;
                var se = "";

            }
            else
            {
                var basket = basketAsObj.ToString();
                Dictionary<int,int> Basket = JsonConvert.DeserializeObject<Dictionary<int, int>>(basket);
                int Id = SelectedProduct.nProductId;
                //product is allready in basket - increase quantity
                if (Basket.ContainsKey(Id))
                {
                    int quant = Basket.GetValueOrDefault(Id);
                    Basket.Remove(Id);
                    Basket.Add(Id, quant + 1);

                    
                }
                //product is not yet in basket - just add it
                else
                {
                    Basket.Add(Id, 1);

                }

                var JsonString = JsonConvert.SerializeObject(Basket);
                TempData["basket"] = JsonString;

            }
            
            return View("./Products");
        }
        public IActionResult RateProduct(Product rateProduct)
        {
            return View("./RateProduct");
        }

        public IActionResult DoneRate(Product donerate)
        {
            return View("./Products");
        }
        public IActionResult Logout()
        {

            TempData["IsLoggedIn"] = "";
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

        public IActionResult Privacy()
        {
            var sd = TempData["IsLoggedIn"].ToString();
            return View();
        }
        public IActionResult Products()
        {
            
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
      return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
  }
}
