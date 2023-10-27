using PR30.Database;
using System;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace PR30.Pages
{
    public partial class EnterDataOnContributionPage : Page
    {
        private CreditsEntities _db = new CreditsEntities();
        private int _debtorId;

        public EnterDataOnContributionPage(int debtorId)
        {
            InitializeComponent();
            _debtorId = debtorId;
            UpdateList();
        }

        ~EnterDataOnContributionPage() 
        {
            _db.Dispose();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
            => NavigationService.GoBack();

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            int loanId = Int32.Parse(((Button)sender).Tag.ToString());
            try
            {
                Loan loan = _db.Loans.Find(loanId);
                RealEstateObject reo = loan.RealEstateObject;
                _db.Entry(reo).State = EntityState.Modified;
                reo.Paid += loan.InformationAboutLoan.MonthlyPayment;
                if (reo.Paid >= reo.Price)
                    loan.IsPaid = true;
                _db.SaveChanges();
                UpdateList();
                MessageBox.Show("Месячный платеж внесен!");
                if (loan.IsPaid.Value)
                    MessageBox.Show("Задолженность погашена!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void UpdateList()
        {
            Loans.ItemsSource = _db.Loans.Where(l => l.DebtorID == _debtorId && l.IsAccepted == true && l.IsPaid == false).Select(l => new
            {
                Id = l.ID,
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
