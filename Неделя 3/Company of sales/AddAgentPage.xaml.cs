using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace QualityLeGang
{
    /// <summary>
    /// Логика взаимодействия для AddAgentPage.xaml
    /// </summary>
    public partial class AddAgentPage : Page
    {

        agents agents = new agents();
        public AddAgentPage(View_1 view)
        {
            InitializeComponent();
            cmbTypes.ItemsSource = SalesCompanyEntities.GetContext().type_agents.ToList();
            if (view != null)
                agents = SalesCompanyEntities.GetContext().agents.Where(x => x.Id == view.Id).First();
            DataContext = agents;
        }

        private void saveAgent_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if(agents.Id == 0)
                    SalesCompanyEntities.GetContext().agents.Add(agents);
                SalesCompanyEntities.GetContext().SaveChanges();
                MessageBox.Show("Все успешно");
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void cmbTypes_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            type_agents type = cmbTypes.SelectedItem as type_agents;
            agents.idTypeAgent = type.id;
        }

        private void btnDeleteAgent_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show($"Вы точно хотите удалить агента {agents.NameAgent} ", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    SalesCompanyEntities.GetContext().agents.Remove(agents);
                    SalesCompanyEntities.GetContext().SaveChanges();
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
            }
        }

        private void Back(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }
    }
}
