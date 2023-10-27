using PR30.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace PR30.Pages
{
    public partial class ApplyingForLoanPage : Page
    {
        private Dictionary<string, bool> _lifeInsurance = new Dictionary<string, bool>()
        {
            ["Да"] = true,
            ["Нет"] = false
        };

        private CreditsEntities _db = new CreditsEntities();
        private int _debtorId;

        public ApplyingForLoanPage(int debtorId)
        {
            InitializeComponent();
            _debtorId = debtorId;
            Banks.ItemsSource = _db.Banks.ToList();
            LoansName.ItemsSource = new[] { "Кредит", "Ипотека" };
            LifeInsurance.ItemsSource = _lifeInsurance.Keys;
            RealEstateType.ItemsSource = _db.RealEstateTypes.ToList();
            RealEstateCategory.ItemsSource = _db.RealEstateCategories.ToList();
            new List<ComboBox> { Banks, LoansName, LifeInsurance, RealEstateType, RealEstateCategory }.ForEach(cb => cb.SelectedIndex = 0);
        }

        ~ApplyingForLoanPage()
        {
            _db.Dispose();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (!Int32.TryParse(LoansTerm.Text, out var loansTerm))
                    throw new Exception("Срок кредита должен быть числом");

                if (loansTerm <= 0)
                    throw new Exception("Срок кредита должен быть больше или равен 1");

                if (!Decimal.TryParse(InterestRate.Text, out var interestRate))
                    throw new Exception("Процентная ставка должна быть числом");

                if (interestRate < 0)
                    throw new Exception("Процентная ставка не может быть отрицательна");

                if (!Decimal.TryParse(DownPayment.Text, out var downPayment))
                    throw new Exception("Начальный платеж должен быть числом");

                if (downPayment < 0)
                    throw new Exception("Начальный платеж не может быть отрицательным");

                if (!Decimal.TryParse(Price.Text, out var price))
                    throw new Exception("Сумма кредита должна быть числом");

                if (price <= 0)
                    throw new Exception("Сумма кредита не может быть меньше или равна 0");

                if (downPayment >= price)
                    throw new Exception("Сумма начального платежа не может быть больше или равна сумме кредита");

                decimal priceWithLoansTerm = price + price * (100 + interestRate) / 100;

                InformationAboutLoan informationAboutLoan = new InformationAboutLoan
                {
                    LoansName = LoansName.Text,
                    LoansTerm = loansTerm,
                    InterestRate = interestRate,
                    DownPayment = downPayment,
                    MonthlyPayment = (priceWithLoansTerm - downPayment) / loansTerm,
                    LifeInsurance = _lifeInsurance[LifeInsurance.Text]
                };

                _db.InformationAboutLoans.Add(informationAboutLoan);

                RealEstateObject realEstateObject = new RealEstateObject()
                {
                    RealEstateTypeID = ((RealEstateType)RealEstateType.SelectedValue).ID,
                    RealEstateCategoryID = ((RealEstateCategory)RealEstateCategory.SelectedValue).ID,
                    Price = priceWithLoansTerm,
                    Address = String.IsNullOrWhiteSpace(Address.Text) ? null : Address.Text,
                    Paid = downPayment
                };

                _db.RealEstateObjects.Add(realEstateObject);

                Loan loan = new Loan
                {
                    BankID = ((Bank)Banks.SelectedValue).ID,
                    StartDate = DateTime.Now,
                    DebtorID = _debtorId,
                    InformationAboutLoansID = informationAboutLoan.ID,
                    RealEstateObjectsID = realEstateObject.ID,
                    AdditionalConditions = String.IsNullOrWhiteSpace(AdditionalConditions.Text) ? "Отсутствует" : AdditionalConditions.Text,
                    IsAccepted = false, 
                    IsDecline = false,
                    IsPaid = false
                };

                _db.Loans.Add(loan);

                _db.SaveChanges();

                MessageBox.Show("Заявка успешно оформлена!");

                NavigationService.GoBack();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
            => NavigationService.GoBack();
    }
}
