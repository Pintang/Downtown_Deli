//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DowntownDeliProject
{
    using System;
    using System.Collections.Generic;
    
    public partial class Product_Inventory
    {
        public long Prod_Inv_ID { get; set; }
        public Nullable<long> Item_ID { get; set; }
        public Nullable<long> Product_ID { get; set; }
    
        public virtual Inventory Inventory { get; set; }
        public virtual Product Product { get; set; }
    }
}