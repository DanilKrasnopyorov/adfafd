using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QualityLeGang
{
    partial class SalesCompanyEntities
    {
        public static SalesCompanyEntities _context;
        public static SalesCompanyEntities GetContext()
        {
            if (_context == null)
            {
                _context = new SalesCompanyEntities();
            }
            return _context;
        }
    }
}
