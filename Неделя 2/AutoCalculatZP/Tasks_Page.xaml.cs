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
    /// Логика взаимодействия для Tasks_Page.xaml
    /// </summary>
    public partial class Tasks_Page : Page
    {
        string role;
        int id;
        IEnumerable<Tasks> tasks1;
        IEnumerable<Tasks> tasksSave;
        IEnumerable<Tasks> tasksHelp;
        List<int?> statusesId = new List<int?>();
        int idStatuses;
        public Tasks_Page()
        {
            InitializeComponent();
            role = FrameManager.Role;
            id = FrameManager.ID;
            cmbExecutors.ItemsSource = SalaryСalculationEntities.GetContext().Executers.ToList();
            taskInfo.ItemsSource = SalaryСalculationEntities.GetContext().Tasks.ToList();
            MessageBox.Show(id + "");
        }

        private void Add(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new EditTasks_Page(null));
        }

        private void Delete(object sender, RoutedEventArgs e)
        {
            var tasksForRemoving = taskInfo.SelectedItems.Cast<Tasks>().ToList();
            if (MessageBox.Show($"Вы точно хотите удалить следующие {tasksForRemoving.Count()} элементов? ",
                "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    SalaryСalculationEntities.GetContext().Tasks.RemoveRange(tasksForRemoving);
                    SalaryСalculationEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены");
                    taskInfo.ItemsSource = SalaryСalculationEntities.GetContext().Tasks.ToList();

                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        private void BtnEditTask_Click(object sender, RoutedEventArgs e)
        {
            Tasks elem = taskInfo.SelectedItem as Tasks;
            if (elem != null)
            {
                NavigationService.Navigate(new EditTasks_Page(elem));
            }
            else
            {
                MessageBox.Show("Выберите задачу!");
            }

        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                SalaryСalculationEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                if (role == "Executor")
                {
                    tasks1 = SalaryСalculationEntities.GetContext().Tasks.ToList();
                    taskInfo.ItemsSource = tasks1;
                    addd.Visibility = Visibility.Collapsed;
                    delete.Visibility = Visibility.Collapsed;
                    tasksSave = tasks1;
                }
                else
                {
                    var executors = SalaryСalculationEntities.GetContext().Executers.ToList();
                    tasks1 = executors.Select(t => t.Tasks).SelectMany(d => d).ToArray();
                    taskInfo.ItemsSource = tasks1;
                    tasksSave = tasks1;
                }
            }
        }


        private void TxtSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            tasksSave = tasks1;
            if (txtSearch.Text == "")
            {
                taskInfo.ItemsSource = tasksSave;
            }
            else
            {
                tasksSave = tasksSave.ToList().Where(x => x.Title.Contains(txtSearch.Text));
            }

            taskInfo.ItemsSource = tasksSave;
        }

        private void CmbExecutors_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (txtSearch.Text == "")
                tasksSave = tasks1;
            Executers elem = cmbExecutors.SelectedItem as Executers;

            tasksSave = tasksSave.ToList().Where(x => x.ExecuterID == elem.ID);
            taskInfo.ItemsSource = tasksSave;

        }

        private void CmbAccess_Checked(object sender, RoutedEventArgs e)
        {
            if (cmbAccess.IsChecked == true)
            {
                idStatuses = 3;
                statusesId.Add(idStatuses);
            }
            if (cmbCancel.IsChecked == true)
            {
                idStatuses = 4;
                statusesId.Add(idStatuses);
            }
            if (cmbPlan.IsChecked == true)
            {
                idStatuses = 1;
                statusesId.Add(idStatuses);
            }
            if (cmbProceccing.IsChecked == true)
            {
                idStatuses = 2;
                statusesId.Add(idStatuses);
            }
            tasksHelp = tasksSave;
            if (statusesId.Count() > 1)
            {
                tasksHelp = tasksHelp.Where(a => statusesId.Contains(a.StatusID));
                //tasksHelp = tasksSave.ToList().Where(x => );
            }
            else
            {
                tasksHelp = tasksSave.ToList().Where(x => x.StatusID == idStatuses);
            }
            taskInfo.ItemsSource = tasksHelp;
        }



        private void CmbAccess_Unchecked(object sender, RoutedEventArgs e)
        {
            if (cmbAccess.IsChecked == false)
            {
                statusesId.Remove(3);
            }
            if (cmbCancel.IsChecked == false)
            {
                statusesId.Remove(4);
            }
            if (cmbPlan.IsChecked == false)
            {
                statusesId.Remove(1);
            }
            if (cmbProceccing.IsChecked == false)
            {
                statusesId.Remove(2);
            }
            tasksHelp = tasksSave;
            if (statusesId.Count() > 1)
            {
                tasksHelp = tasksHelp.Where(a => statusesId.Contains(a.StatusID));
            }
            else
            {
                tasksHelp = tasksSave.ToList().Where(x => x.StatusID == idStatuses);
            }
            taskInfo.ItemsSource = tasksHelp;

            
        }

        
    }
}
