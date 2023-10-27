using PR30.Database;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace PR30.Pages
{
    public partial class AuthorizationPage : Page
    {
        private CreditsEntities _db = new CreditsEntities();

        public AuthorizationPage()
            => InitializeComponent();

        ~AuthorizationPage()
        { 
            _db.Dispose();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                User user = _db.Users.FirstOrDefault(u => u.Login == Login.Text && u.Password == Password.Password);
                if (user is null) throw new System.Exception("Пользователь не найден");
                MessageBox.Show($"Добро пожаловать, {user.Name} {user.Patronymic}");
                Debtor debtor = _db.Debtors.FirstOrDefault(d => d.UserID == user.ID);
                if (debtor != null)
                    NavigationService.Navigate(new MainPageForDebtors(debtor.ID));
                else
                    NavigationService.Navigate(new MainPageForBankEmployeer());
            }
            catch
            {
                MessageBox.Show("Некорректные данные");
            }
        }
    }
}
