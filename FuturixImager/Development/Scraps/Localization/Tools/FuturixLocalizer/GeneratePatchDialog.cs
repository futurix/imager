using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FuturixLocalizer
{
    public partial class GeneratePatchDialog : Form
    {
        public GeneratePatchDialog()
        {
            InitializeComponent();
        }

        private void btnFirst_Click(object sender, EventArgs e)
        {
            dlgOpen.InitialDirectory = Path.GetDirectoryName(Application.ExecutablePath);

            if (dlgOpen.ShowDialog() == DialogResult.OK)
            {
                if (File.Exists(dlgOpen.FileName))
                {
                    txtFirst.Text = dlgOpen.FileName;
                }
            }
        }

        private void btnSecond_Click(object sender, EventArgs e)
        {
            dlgOpen.InitialDirectory = Path.GetDirectoryName(Application.ExecutablePath);

            if (dlgOpen.ShowDialog() == DialogResult.OK)
            {
                if (File.Exists(dlgOpen.FileName))
                {
                    txtSecond.Text = dlgOpen.FileName;
                }
            }
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            MessageBox.Show("");
        }
    }
}
