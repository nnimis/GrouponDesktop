using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GrouponDesktop.Common;

namespace GrouponDesktop.ComprarGiftCard
{
    public class NewGiftCardEventArgs : EventArgs
    {
        public GiftCard GiftCard { get; set; }
    }
}
