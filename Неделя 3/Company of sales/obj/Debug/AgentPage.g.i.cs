﻿#pragma checksum "..\..\AgentPage.xaml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "A07939E2BA5188EBCC925D5EB9206F4D6485567AE1FBB275619005A83A8A8412"
//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан программой.
//     Исполняемая версия:4.0.30319.42000
//
//     Изменения в этом файле могут привести к неправильной работе и будут потеряны в случае
//     повторной генерации кода.
// </auto-generated>
//------------------------------------------------------------------------------

using QualityLeGang;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace QualityLeGang {
    
    
    /// <summary>
    /// AgentPage
    /// </summary>
    public partial class AgentPage : System.Windows.Controls.Page, System.Windows.Markup.IComponentConnector {
        
        
        #line 46 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtSearch;
        
        #line default
        #line hidden
        
        
        #line 48 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox cmbSort;
        
        #line default
        #line hidden
        
        
        #line 49 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox cmbFiltr;
        
        #line default
        #line hidden
        
        
        #line 53 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ListView LVAgent;
        
        #line default
        #line hidden
        
        
        #line 127 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button addAgent;
        
        #line default
        #line hidden
        
        
        #line 128 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button editAgent;
        
        #line default
        #line hidden
        
        
        #line 129 "..\..\AgentPage.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button delAgent;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/QualityLeGang;component/agentpage.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\AgentPage.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.txtSearch = ((System.Windows.Controls.TextBox)(target));
            
            #line 47 "..\..\AgentPage.xaml"
            this.txtSearch.TextChanged += new System.Windows.Controls.TextChangedEventHandler(this.txtSearch_TextChanged);
            
            #line default
            #line hidden
            return;
            case 2:
            this.cmbSort = ((System.Windows.Controls.ComboBox)(target));
            
            #line 48 "..\..\AgentPage.xaml"
            this.cmbSort.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.cmbSort_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 3:
            this.cmbFiltr = ((System.Windows.Controls.ComboBox)(target));
            
            #line 49 "..\..\AgentPage.xaml"
            this.cmbFiltr.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.cmbFiltr_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 4:
            this.LVAgent = ((System.Windows.Controls.ListView)(target));
            return;
            case 5:
            this.addAgent = ((System.Windows.Controls.Button)(target));
            
            #line 127 "..\..\AgentPage.xaml"
            this.addAgent.Click += new System.Windows.RoutedEventHandler(this.addAgent_Click);
            
            #line default
            #line hidden
            return;
            case 6:
            this.editAgent = ((System.Windows.Controls.Button)(target));
            
            #line 128 "..\..\AgentPage.xaml"
            this.editAgent.Click += new System.Windows.RoutedEventHandler(this.editAgent_Click);
            
            #line default
            #line hidden
            return;
            case 7:
            this.delAgent = ((System.Windows.Controls.Button)(target));
            
            #line 129 "..\..\AgentPage.xaml"
            this.delAgent.Click += new System.Windows.RoutedEventHandler(this.delAgent_Click);
            
            #line default
            #line hidden
            return;
            case 8:
            
            #line 134 "..\..\AgentPage.xaml"
            ((System.Windows.Controls.Image)(target)).MouseDown += new System.Windows.Input.MouseButtonEventHandler(this.Image_MouseDown);
            
            #line default
            #line hidden
            return;
            case 9:
            
            #line 135 "..\..\AgentPage.xaml"
            ((System.Windows.Controls.Image)(target)).MouseDown += new System.Windows.Input.MouseButtonEventHandler(this.Image_MouseDown_1);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

