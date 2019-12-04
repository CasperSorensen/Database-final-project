using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using database_final_project.Models;

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
            
            if (TempData["IsLoggedIn"]==null)
            {
                TempData["IsLoggedIn"] = string.Empty;
                return View();
            }
            else
            {
                
                
                
                    return View();
                
               

            }
          
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


                TempData["IsLoggedIn"] = UserData.UserName;
                return View("./Index", UserData);
            }
        }
        public IActionResult AddToBasket(Product product1)
        {
            return View();
        }
        public IActionResult RateProduct(Product rateProduct)
        {
            return View("./RateProduct");
        }
        public IActionResult Logout()
        {

            TempData["IsLoggedIn"] = "";
            return View("./Index");
        }


        public IActionResult Privacy()
    {
            var sd = TempData["IsLoggedIn"].ToString();
            return View();
    }
        public IActionResult Products()
        {
            var sd = TempData["IsLoggedIn"].ToString();
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
      return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
  }
}
