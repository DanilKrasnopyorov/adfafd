//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AutoCalculatZP
{
    using System;
    using System.Collections.Generic;
    
    public partial class Manager
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Manager()
        {
            this.Executers = new HashSet<Executers>();
        }
    
        public int ID { get; set; }
        public double AnalysisCoefficient { get; set; }
        public double DifficultyCoefficient { get; set; }
        public double InstallationCoefficient { get; set; }
        public double JuniorMinimum { get; set; }
        public double MiddleMinimum { get; set; }
        public double SeniorMinimum { get; set; }
        public string SupportCoefficient { get; set; }
        public System.DateTime TimeCoefficient { get; set; }
        public double ToMoneyCoefficient { get; set; }
        public int UserID { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Executers> Executers { get; set; }
        public virtual Users Users { get; set; }
    }
}
