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
    
    public partial class Employee
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Employee()
        {
            this.Empworktimes = new HashSet<Empworktime>();
        }
    
        public long Emp_ID { get; set; }
        public Nullable<long> Schedule_ID { get; set; }
        public Nullable<long> Job_ID { get; set; }
        public string F_Name { get; set; }
        public string L_Name { get; set; }
        public decimal Pay_Rate { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Emp_Address { get; set; }
        public string Emp_User_Name { get; set; }
        public string Emp_Password { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Empworktime> Empworktimes { get; set; }
        public virtual Job Job { get; set; }
        public virtual Schedule Schedule { get; set; }
    }
}
