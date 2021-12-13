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
using System.Windows.Shapes;

namespace AutoCalculatZP
{
    /// <summary>
    /// Логика взаимодействия для Login_Window.xaml
    /// </summary>
    public partial class Login_Window : Window
    {
        
        MainWindow mainWindow = new MainWindow();
        public int Number = 0;
        IEnumerable<Users> element;

        public Login_Window()
        {
            InitializeComponent();

        }

        private void enter_Click(object sender, RoutedEventArgs e)
        {
            element = element.ToList().Where(x => x.Password == password.Password);
            if (element.Count() == 1)
            {
                if (SalaryСalculationEntities.GetContext().Executers.ToList().Where(x => x.ID == element.First().ID).Count() == 1)
                {
                    FrameManager.Role = "Executor";
                }
                else
                {
                    FrameManager.Role = "Manager";
                }
                MessageBox.Show("Успешно! Ваша роль: " + FrameManager.Role);
                mainWindow.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("Не верный пароль!", "Введите пароль", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        private void TxtLogin_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                element = SalaryСalculationEntities.GetContext().Users.ToList().Where(x => x.Login == login.Text);
                if (element.Count() == 1)
                {
                    enter.IsEnabled = true;
                    password.IsEnabled = true;
                }
                else
                {
                    MessageBox.Show("Попробуйте ещё раз!", "Неверный логин", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                }

            }
        }
    }
}
