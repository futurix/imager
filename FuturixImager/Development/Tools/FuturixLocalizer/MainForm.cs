using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml.Serialization;

namespace FuturixLocalizer
{
    public partial class MainForm : Form
    {
        private string fileName = null;
        private FuturixLocalization glossary = null;

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            if (toolStrip.Renderer is ToolStripProfessionalRenderer)
                (toolStrip.Renderer as ToolStripProfessionalRenderer).RoundedEdges = false;
        }

        private void UpdateListView()
        {
            list.Items.Clear();
            
            if (glossary != null)
            {
                list.BeginUpdate();
                
                foreach (LocalizedString item in glossary)
                {
                    ListViewItem lvi = new ListViewItem(item.ID.ToString());
                    lvi.SubItems.AddRange(new string[] { item.PID, item.TextData });
                    lvi.Tag = item.ID;
                    
                    list.Items.Add(lvi);
                }

                list.EndUpdate();
            }
        }

        private void tsbOpen_Click(object sender, EventArgs e)
        {
            if (dlgOpen.ShowDialog() == DialogResult.OK)
            {
                if (File.Exists(dlgOpen.FileName))
                {
                    XmlSerializer xs = new XmlSerializer(typeof(FuturixLocalization));

                    using (FileStream reader = new FileStream(dlgOpen.FileName, FileMode.Open))
                    {
                        try
                        {
                            glossary = xs.Deserialize(reader) as FuturixLocalization;

                            if (glossary != null)
                            {
                                fileName = dlgOpen.FileName;

                                UpdateListView();
                            }
                        }
                        catch
                        {
                            fileName = null;
                            glossary = null;

                            MessageBox.Show("Failed to load localization file!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
            }
        }

        private void tsbSave_Click(object sender, EventArgs e)
        {
            if (glossary != null)
            {
                if (!String.IsNullOrEmpty(fileName))
                    dlgSave.FileName = Path.GetFileName(fileName);
                else
                    dlgSave.FileName = "default.fxlocale";

                if (dlgSave.ShowDialog() == DialogResult.OK)
                {
                    XmlSerializer xs = new XmlSerializer(typeof(FuturixLocalization));

                    using (FileStream writer = new FileStream(dlgSave.FileName, FileMode.Create, FileAccess.Write, FileShare.None))
                    {
                        try
                        {
                            xs.Serialize(writer, glossary);

                            fileName = dlgSave.FileName;
                        }
                        catch
                        {
                            MessageBox.Show("Failed to save localization file!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
            }
        }

        private void miGenResourceScript_Click(object sender, EventArgs e)
        {
            string location = "language_terms.rc";
            if (!String.IsNullOrEmpty(fileName))
                location = Path.Combine(Path.GetDirectoryName(fileName), location);
            
            if (glossary != null)
            {
                using (StreamWriter sw = new StreamWriter(location, false, Encoding.Unicode))
                {
                    sw.AutoFlush = false;
                    
                    // writing content
                    sw.WriteLine("STRINGTABLE");
                    sw.WriteLine("BEGIN");

                    foreach (LocalizedString item in glossary)
                    {
                        sw.WriteLine("    {0}  \"{1}\"", item.ID.ToString(), PrepareString_RC(item.TextData));
                    }
                    
                    sw.WriteLine("END");
                }
            }
        }

        private void miGenCHeader_Click(object sender, EventArgs e)
        {
            string location = "fximager_lang.h";
            if (!String.IsNullOrEmpty(fileName))
                location = Path.Combine(Path.GetDirectoryName(fileName), location);

            if (glossary != null)
            {
                using (StreamWriter sw = new StreamWriter(location, false, Encoding.Unicode))
                {
                    sw.AutoFlush = false;

                    // writing content
                    foreach (LocalizedString item in glossary)
                    {
                        sw.WriteLine("#define FXL_{0}    {1}", item.PID, item.ID.ToString());
                    }
                }
            }
        }

        private void miGenDelphiHeader_Click(object sender, EventArgs e)
        {
            string location = "c_lang.pas";
            if (!String.IsNullOrEmpty(fileName))
                location = Path.Combine(Path.GetDirectoryName(fileName), location);

            if (glossary != null)
            {
                using (StreamWriter sw = new StreamWriter(location, false, Encoding.Unicode))
                {
                    sw.AutoFlush = false;

                    // writing content
                    sw.WriteLine("unit c_lang;");
                    sw.WriteLine("");
                    sw.WriteLine("interface");
                    sw.WriteLine("");
                    sw.WriteLine("const");

                    foreach (LocalizedString item in glossary)
                    {
                        sw.WriteLine("  FXL_{0} = {1};", item.PID, item.ID.ToString());
                    }

                    sw.WriteLine("");
                    sw.WriteLine("");
                    sw.WriteLine("implementation");
                    sw.WriteLine("");
                    sw.WriteLine("end.");
                }
            }
        }

        private void tsbGenerate_ButtonClick(object sender, EventArgs e)
        {
            if (glossary != null)
            {
                miGenResourceScript_Click(this, EventArgs.Empty);
                miGenCHeader_Click(this, EventArgs.Empty);
                miGenDelphiHeader_Click(this, EventArgs.Empty);
            }
        }

        private void miNewString_Click(object sender, EventArgs e)
        {
            if (glossary == null)
            {
                glossary = new FuturixLocalization();

                UpdateListView();
            }

            using (LocalizedStringEditorDialog dlg = new LocalizedStringEditorDialog())
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    LocalizedString temp = new LocalizedString();
                    temp.ID = dlg.ID;
                    temp.PID = dlg.PID;
                    temp.TextData = dlg.TextData;

                    glossary.Add(temp);

                    UpdateListView();
                }
            }
        }

        private void miSort_Click(object sender, EventArgs e)
        {
            if (glossary != null)
            {
                glossary.Sort(
                    (x, y) =>
                    {
                        if (x.ID == y.ID)
                            return 0;
                        else if (x.ID > y.ID)
                            return 1;
                        else
                            return -1;
                    });

                UpdateListView();
            }
        }

        private void list_DoubleClick(object sender, EventArgs e)
        {
            if (glossary != null)
            {
                if (list.SelectedItems.Count > 0)
                {
                    ListViewItem lvi = list.SelectedItems[0];
                    int id = (int)lvi.Tag;

                    int index = glossary.FindIndex(
                        (ls) =>
                        {
                            return (ls.ID == id);
                        });

                    using (LocalizedStringEditorDialog dlg = new LocalizedStringEditorDialog())
                    {
                        dlg.ID = glossary[index].ID;
                        dlg.PID = glossary[index].PID;
                        dlg.TextData = glossary[index].TextData;
                        
                        if (dlg.ShowDialog() == DialogResult.OK)
                        {
                            LocalizedString temp = new LocalizedString();
                            temp.ID = dlg.ID;
                            temp.PID = dlg.PID;
                            temp.TextData = dlg.TextData;

                            glossary[index] = temp;

                            UpdateListView();
                        }
                    }

                    UpdateListView();
                }
            }
        }

        private void MainForm_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F12)
                tsbDebug.Visible = true;
        }

        private string PrepareString_RC(string input)
        {
            string temp = input;

            temp = temp.Replace("\"", "\"\"");
            temp = temp.Replace("\\n", "\\012");

            return temp;
        }
    }
}
