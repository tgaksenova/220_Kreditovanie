using PR30.Database;
using System;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace PR30.Pages
{
    public partial class MainPageForBankEmployeer : Page
    {
        private CreditsEntities _db = new CreditsEntities();

        public MainPageForBankEmployeer()
        {
            InitializeComponent();
            UpdateList();
        }

        ~MainPageForBankEmployeer()
        {
            _db.Dispose();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
            => Click(Int32.Parse(((Button)sender).Tag.ToString()), "одобрен", true, false);

        private void Button_Click_1(object sender, RoutedEventArgs e)
            => Click(Int32.Parse(((Button)sender).Tag.ToString()), "отклонен", false, true);

        private void Click(int loanId, string message, bool isAccepted, bool isDecline)
        {
            var loan = _db.Loans.Find(loanId);
            _db.Entry(loan).State = EntityState.Modified;
            loan.IsAccepted = isAccepted;
            loan.IsDecline = isDecline;
            _db.SaveChanges();
            MessageBox.Show($"Кредит для {loan.Debtor.User.Surname} {loan.Debtor.User.Name} {loan.Debtor.User.Patronymic} {message}!");
            UpdateList();
        }

        private void UpdateList()
        {
            Loans.ItemsSource = _db.Loans.Where(l => new[] { l.IsDecline, l.IsAccepted, l.IsPaid }.All(p => p.Value == false)).Select(l => new
            {
                Id = l.ID,
                DebtorSurname = l.Debtor.User.Surname,
                DebtorName = l.Debtor.User.Name,
                DebtorPatronymic = l.Debtor.User.Surname,
                l.AdditionalConditions,
                Bank = l.Bank.BankName,
                l.InformationAboutLoan.LoansTerm,
                l.InformationAboutLoan.LoansName,
                l.InformationAboutLoan.InterestRate,
                l.InformationAboutLoan.LifeInsurance
            }).ToList();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
            => NavigationService.Navigate(new AuthorizationPage());
    }
}
