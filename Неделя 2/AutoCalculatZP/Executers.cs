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
    
    public partial class Executers
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Executers()
        {
            this.Tasks = new HashSet<Tasks>();
        }
    
        public int ID { get; set; }
        public int ManagerID { get; set; }
        public int GradeID { get; set; }
        public int UserID { get; set; }
    
        public virtual Grade Grade { get; set; }
        public virtual Manager Manager { get; set; }
        public virtual Users Users { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Tasks> Tasks { get; set; }
    }
}
