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

namespace AutoCalculatZP
{
    /// <summary>
    /// Логика взаимодействия для Executers_Page.xaml
    /// </summary>
    public partial class Executers_Page : Page
    {
        string role;
        int id;
        IEnumerable<Tasks> tasks1;
        IEnumerable<Tasks> tasksSave;
        public Executers_Page()
        {
            InitializeComponent();
            role = FrameManager.Role;
            id = FrameManager.ID;
            cmb.ItemsSource = SalaryСalculationEntities.GetContext().Executers.ToList();
            taskGrid.ItemsSource = SalaryСalculationEntities.GetContext().Tasks.ToList();


        }



        //private void Cmb_SelectionChanged(object sender, SelectionChangedEventArgs e)
        //{
        //    tasksSave = tasksSave.ToList().Where(x => xS)
        //}

        private void Delete(object sender, RoutedEventArgs e)
        {
            var tasksForRemoving = taskGrid.SelectedItems.Cast<Tasks>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить следующие {tasksForRemoving.Count()} Элументов?",
                "Внимание!", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    SalaryСalculationEntities.GetContext().Tasks.RemoveRange(tasksForRemoving);
                    SalaryСalculationEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные удвлены");
                    taskGrid.ItemsSource = SalaryСalculationEntities.GetContext().Tasks.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                SalaryСalculationEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(x => x.Reload());
                if (role == "Executor")
                {
                    tasks1 = SalaryСalculationEntities.GetContext().Tasks.ToList().Where(x => x.ExecuterID == id);
                    taskGrid.ItemsSource = tasks1;
                    delete.Visibility = Visibility.Collapsed;
                }
                else
                {
                    var executors = SalaryСalculationEntities.GetContext().Executers.ToList().Where(x => x.ManagerID== id);
                    tasks1 = executors.Select(t => t.Tasks).SelectMany(d => d).ToArray();
                    taskGrid.ItemsSource = tasks1;
                }

            }
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            tasksSave = tasks1;
            if (txtSearch.Text == "")
            {
                taskGrid.ItemsSource = tasks1;
            }
            else
            {
                tasks1 = tasks1.ToList().Where(x => x.Title.Contains(txtSearch.Text));
            }
            taskGrid.ItemsSource = tasks1;
        }
    }
}
