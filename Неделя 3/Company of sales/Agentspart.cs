using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QualityLeGang
{
    partial class View_1
    {
        public string ResourceLogoAgent
        {
            get
            {
                if (LogoAgent == null)
                    return null;
                return "/Resources" + LogoAgent;
            }
        }
        public bool Value
        {
            get
            {
                if (Скидка_агента >= 5)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
