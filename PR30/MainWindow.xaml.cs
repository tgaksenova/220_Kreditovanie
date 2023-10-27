using PR30.Pages;
using System.Windows;
using System.Windows.Navigation;

namespace PR30
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            MainFrame.Navigate(new AuthorizationPage());
        }
    }
}
