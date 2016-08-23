using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FuturixLocalizer
{
    public partial class LocalizedStringEditorDialog : Form
    {
        public LocalizedStringEditorDialog()
        {
            InitializeComponent();
        }

        public int ID
        {
            get
            {
                return (int)nudID.Value;
            }
            set
            {
                try
                {
                    nudID.Value = value;
                }
                catch
                {
                }
            }
        }

        public string PID
        {
            get
            {
                return txtPID.Text;
            }
            set
            {
                txtPID.Text = value;
            }
        }

        public string TextData
        {
            get
            {
                return txtData.Text;
            }
            set
            {
                txtData.Text = value;
            }
        }
    }
}
