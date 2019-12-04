using Datamodels;

namespace database_final_project.Models
{
    public class Factory
    {
        public Factory()
        {

        }

        public static Data FetchObject(string type)
        {
            switch (type)
            {
                case "product":
                    return new Product();
            }
            return null;

        }

    }
}