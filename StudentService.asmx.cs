using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebServicesDemo
{
    /// <summary>
    /// Summary description for StudentService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class StudentService : System.Web.Services.WebService
    {

        /*Pozivanje veb servisa Javascript-om iz ASP.NET AJAX.
         Moramo skinuti komentar od koda iznad imena klase.*/

        public string GetConnectionString()
        {
            return "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=University;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        }

        [WebMethod]
        public Student GetStudentByID(int id)
        {
            
            /*metod dohvata studenta iz baze na osnovu ID-a
             i podatke upisuje u objekat tipa Student ciji se property-ji
            poklapaju sa podacima tabele Students.
            BITNO! Veb servis je isto C# aplikacija tako da moze da radi sa ADO.NET, XML, tekstualnim fajlovima, excel, ...
             */

            SqlConnection con = new SqlConnection(GetConnectionString());

            string query = "SELECT * FROM Students WHERE StudentID = @id";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlParameter p1 = new SqlParameter();

            p1.Value = id;

            p1.ParameterName = "@id";
        
            cmd.Parameters.Add(p1);

            Student student= new Student();

            using(con)
            {
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while(reader.Read())
                {
                    student.StudentID = Convert.ToInt32(reader["StudentID"]);

                    student.LastName = reader["LastName"].ToString();

                    student.FirstName = reader["FirstName"].ToString();

                    student.Year = Convert.ToInt32(reader["Year"]);

                }

                return student;
            }


        }
    }
}
