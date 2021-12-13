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
    /// Логика взаимодействия для EditTasks_Page.xaml
    /// </summary>
    public partial class EditTasks_Page : Page
    {
        public Tasks task = new Tasks();
        public EditTasks_Page(Tasks _task)
        {
            InitializeComponent();
            if (FrameManager.Role == "Executor")
            {
                cmbExecutors.IsEnabled = false;
            }
            if (_task != null)
            {
                if (_task.Status.ToString() == "Отменена" || _task.Status.ToString() == "Выполнена")
                {
                    DGMain.IsEnabled = false;
                }


                task = _task;
            }

            cmbExecutors.ItemsSource = SalaryСalculationEntities.GetContext().Executers.ToList();
            CBStatuses.ItemsSource = SalaryСalculationEntities.GetContext().Status.ToList();
            List<string> workTypes = new List<string>();
            workTypes.Add("анализ и проектирование");
            workTypes.Add("установка оборудования");
            workTypes.Add("техническое обслуживание и сопровождение");
            CBTypeWork.ItemsSource = workTypes;
            DataContext = task;
            txtCreateDate.Text = DateTime.Now.ToShortDateString();
        }

        private void AddTasks_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (task.ID == 0)
                {
                    task.CreateDateTime = Convert.ToString(txtCreateDate.Text);
                    SalaryСalculationEntities.GetContext().Tasks.Add(task);
                }
                SalaryСalculationEntities.GetContext().SaveChanges();
                MessageBox.Show("Все успешно");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void CBStatuses_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (CBStatuses.SelectedIndex == 2 || CBStatuses.SelectedIndex == 3)
            {
                DGMain.IsEnabled = false;
            }
            else
            {
                DGMain.IsEnabled = true;
            }
        }
    }
}
