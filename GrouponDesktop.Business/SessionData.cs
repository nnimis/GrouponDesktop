﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Business
{
    internal class SessionData
    {
        private static Dictionary<string, object> _data = new Dictionary<string, object>();

        public static void Set(string key, object value)
        {
            _data.Add(key, value);
        }

        public static T Get<T>(string key)
        {
            return (T)_data[key];
        }

        public static bool Contains(string key)
        {
            return _data.Keys.Contains(key);
        }
    }
}