//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QualityLeGang
{
    using System;
    using System.Collections.Generic;
    
    public partial class productsale
    {
        public int id { get; set; }
        public string Name { get; set; }
        public string NameAgent { get; set; }
        public Nullable<int> idАгента { get; set; }
        public Nullable<System.DateTime> DateProduct { get; set; }
        public Nullable<double> CountProductSale { get; set; }
        public Nullable<int> idProduct { get; set; }
    
        public virtual agents agents { get; set; }
        public virtual products products { get; set; }
    }
}
