<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebServicesDemo.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student</title>

    <link href="WebForm1.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous"/>
    
</head>
<body>
    <!--Stranica mora biti web form bez master page-a da bi radio Javascript.-->
    <br />

    <div class="container2">

        <h1>Student Form</h1>

        <form id="Forma" runat="server">

            <!--ScriptManager omogucava da se koristi ASP.NET AJAX. Nalazi se u
                Toolbox -> AJAX Extensions -> ScriptManager. Menadzeru treba dodati
                referencu na nas veb servis.
                Mi pozivamo veb servis u Javascriptu koristeci ASP NET AJAX.
                -->

            <asp:ScriptManager ID="ScriptManager1" runat="server">

                <Services>
                    <asp:ServiceReference Path="~/StudentService.asmx" />
                </Services>

            </asp:ScriptManager>

            <div>

                <div class="form-group">

                    <asp:Label ID="Label1" runat="server" Text="Student ID" Font-Bold="true"></asp:Label>

                    <asp:TextBox ID="TextBoxStudentID" runat="server" CssClass="form-control"></asp:TextBox>

                    

                </div>

                <br />

                <input id="ButtonGetStudent" type="button" value="Get Student" class="btn btn-info" />

                <div class="form-group">

                    <asp:Label ID="Label2" runat="server" Text="Last Name" Font-Bold="true"></asp:Label>

                    <asp:TextBox ID="TextBoxLastName" runat="server" CssClass="form-control"></asp:TextBox>

                </div>

                <div class="form-group">

                    <asp:Label ID="Label3" runat="server" Text="First Name" Font-Bold="true"></asp:Label>

                    <asp:TextBox ID="TextBoxFirstName" runat="server" CssClass="form-control"></asp:TextBox>

                </div>

                <div class="form-group">

                    <asp:Label ID="Label4" runat="server" Text="Year" Font-Bold="true"></asp:Label>

                    <asp:TextBox ID="TextBoxYear" runat="server" CssClass="form-control"></asp:TextBox>

                </div>

                <br />

                <h3>Vreme ispod se ne menja jer klikom na dugme imamo parcijalni post back, a NE full page postback</h3>

                <!--Parcijalni post back stranice znaci da se samo deo stranice azurira, ovde je to web forma.
                    Brze je i efikasnije od full page postback-a koji smo do sada imali i kod parcijalnog postback-a nema
                    page flickering-a(treperenja) tj. da su vidljivi efekti ponovnog ucitavanja stranice.
                   -->
                <asp:Label ID="LabelTime" runat="server" Font-Bold="true" Font-Size="14pt" ForeColor="Red"></asp:Label>


            </div>
        </form>

    </div>

    <script type="text/javascript" language ="javascript">

        /*javascript kod. Dohvatamo uneti ID iz TextBoxa. To moze jer kad se ovaj
         kod izvrsava taj textbox postaje obican HTML input i DOM ga vidi.*/

        function GetStudentById() {
            let id = document.getElementById("TextBoxStudentID").value;
            /*sad pozivamo namespace veb servisa tj. dohvatamo njegov metod GetStudentByID.
             Dakle,
             GetStudentById - metod javascripta
             GetStudentByID - metod veb servisa.
             */
            WebServicesDemo.StudentService.GetStudentByID(id, GetStudentByIDSuccessCallback, GetStudentByIDFailedCallback);
            /*U Javascript-u postoji mogucnost pozivanja fja kao argumente funkcija. Takve fje se zovu callback funkcije.
             GetStudentByIDSuccessCallback funkcija se poziva kada veb servis se uspesno vrati.
             GetStudentByIDFailedCallback funkcija se poziva kada veb servis ne vrati uspesno podatke, npr.
             ako korisnik ne unese tacan ID npr. unese slova.*/
        }

        function GetStudentByIDSuccessCallback(results) {
            /*fja dohvata rezultate koje je vratio veb servis i upisuje ih u TextBox-ove.*/
            document.getElementById("TextBoxLastName").value = results["LastName"];
            document.getElementById("TextBoxFirstName").value = results["FirstName"];
            document.getElementById("TextBoxYear").value = results["Year"];

        }

        function GetStudentByIDFailedCallback(errors) {
            /*funkcija ispisuje gresku korisniku*/
            alert(errors.get_message());
        }

        /*U TextBox-ove ispisujemo podatke studenta kada se klikne na dugme.*/

        let buttonGetStudent = document.getElementById("ButtonGetStudent");

        buttonGetStudent.addEventListener("click", function (ev) {

            GetStudentById();
        });

    </script>
</body>
</html>
