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
    
    public partial class Order
    {
        public int Order_ID { get; set; }
        public int Customer_ID { get; set; }
        public int Promo_ID { get; set; }
        public decimal Price { get; set; }
        public System.DateTime Or_Date { get; set; }
    
        public virtual Customer Customer { get; set; }
        public virtual Promotion Promotion { get; set; }
    }
}