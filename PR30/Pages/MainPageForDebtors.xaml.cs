using System.Windows;
using System.Windows.Controls;

namespace PR30.Pages
{
    public partial class MainPageForDebtors : Page
    {
        private int _debtorId;
        public MainPageForDebtors(int debtorId)
        {
            InitializeComponent();
            _debtorId = debtorId;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
            => NavigationService.Navigate(new ApplyingForLoanPage(_debtorId));

        private void Button_Click_1(object sender, RoutedEventArgs e)
            => NavigationService.Navigate(new ViewingLoanBalancesPage(_debtorId));

        private void Button_Click_2(object sender, RoutedEventArgs e)
            => NavigationService.Navigate(new EnterDataOnContributionPage(_debtorId));

        private void Button_Click_3(object sender, RoutedEventArgs e)
            => NavigationService.Navigate(new AuthorizationPage());
    }
}
