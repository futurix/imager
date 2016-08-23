using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace FuturixLocalizer
{
    [XmlRoot("FuturixImagerLocalization")]
    public class FuturixLocalization
    {
        public FuturixLocalization()
            : base()
        {
            Data = new List<LocalizedString>();
            LocalizationVersion = 1;
        }
        
        [XmlAttribute("ver")]
        public int LocalizationVersion
        {
            get;
            set;
        }

        [XmlArray("Data")]
        public List<LocalizedString> Data
        {
            get;
            set;
        }
    }

    [XmlType("LocalizedString")]
    public class LocalizedString
    {
        [XmlAttribute("id")]
        public int ID
        {
            get;
            set;
        }

        [XmlAttribute("pid")]
        public string PID
        {
            get;
            set;
        }

        [XmlAttribute("data")]
        public string TextData
        {
            get;
            set;
        }
    }
}
