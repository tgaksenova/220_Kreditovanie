using PR30.Database;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace PR30.Pages
{
    public partial class ViewingLoanBalancesPage : Page
    {
        private CreditsEntities _db = new CreditsEntities();
        private int _debtorId;

        public ViewingLoanBalancesPage(int debtorId)
        {
            InitializeComponent();
            _debtorId = debtorId;
            UpdateList();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
            => NavigationService.GoBack();

        private void UpdateList()
        {
            Loans.ItemsSource = _db.Loans.Where(l => l.DebtorID == _debtorId && l.IsAccepted == true && l.IsPaid == false).Select(l => new
            {
                l.StartDate,
                l.InformationAboutLoan.DownPayment,
                l.InformationAboutLoan.MonthlyPayment,
                l.RealEstateObject.RealEstateType.EstateType,
                l.RealEstateObject.RealEstateCategory.EstateCategory,
                l.RealEstateObject.Price,
                l.RealEstateObject.Address,
                l.RealEstateObject.Paid,
                l.AdditionalConditions,
                Bank = l.Bank.BankName,
                l.InformationAboutLoan.LoansTerm,
                l.InformationAboutLoan.LoansName,
                l.InformationAboutLoan.InterestRate,
                l.InformationAboutLoan.LifeInsurance,
            }).ToList();
        }
    }
}
