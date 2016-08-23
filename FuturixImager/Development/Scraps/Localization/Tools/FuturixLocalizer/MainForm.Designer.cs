namespace FuturixLocalizer
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.toolStrip = new System.Windows.Forms.ToolStrip();
            this.tsbOpen = new System.Windows.Forms.ToolStripButton();
            this.tsbSave = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.tsbGenerate = new System.Windows.Forms.ToolStripSplitButton();
            this.miGenResourceScript = new System.Windows.Forms.ToolStripMenuItem();
            this.miGenCHeader = new System.Windows.Forms.ToolStripMenuItem();
            this.miGenDelphiHeader = new System.Windows.Forms.ToolStripMenuItem();
            this.tsbDebug = new System.Windows.Forms.ToolStripDropDownButton();
            this.miNewString = new System.Windows.Forms.ToolStripMenuItem();
            this.miSort = new System.Windows.Forms.ToolStripMenuItem();
            this.list = new System.Windows.Forms.ListView();
            this.idHeader = new System.Windows.Forms.ColumnHeader();
            this.pidHeader = new System.Windows.Forms.ColumnHeader();
            this.dataHeader = new System.Windows.Forms.ColumnHeader();
            this.dlgOpen = new System.Windows.Forms.OpenFileDialog();
            this.dlgSave = new System.Windows.Forms.SaveFileDialog();
            this.tsbPatch = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.miEditVersion = new System.Windows.Forms.ToolStripMenuItem();
            this.miGeneratePatch = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // toolStrip
            // 
            this.toolStrip.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsbOpen,
            this.tsbSave,
            this.toolStripSeparator1,
            this.tsbPatch,
            this.toolStripSeparator2,
            this.tsbGenerate,
            this.tsbDebug});
            this.toolStrip.Location = new System.Drawing.Point(0, 0);
            this.toolStrip.Name = "toolStrip";
            this.toolStrip.ShowItemToolTips = false;
            this.toolStrip.Size = new System.Drawing.Size(767, 25);
            this.toolStrip.TabIndex = 0;
            // 
            // tsbOpen
            // 
            this.tsbOpen.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.tsbOpen.Image = ((System.Drawing.Image)(resources.GetObject("tsbOpen.Image")));
            this.tsbOpen.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbOpen.Name = "tsbOpen";
            this.tsbOpen.Size = new System.Drawing.Size(40, 22);
            this.tsbOpen.Text = "Open";
            this.tsbOpen.Click += new System.EventHandler(this.tsbOpen_Click);
            // 
            // tsbSave
            // 
            this.tsbSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.tsbSave.Image = ((System.Drawing.Image)(resources.GetObject("tsbSave.Image")));
            this.tsbSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbSave.Name = "tsbSave";
            this.tsbSave.Size = new System.Drawing.Size(35, 22);
            this.tsbSave.Text = "Save";
            this.tsbSave.Click += new System.EventHandler(this.tsbSave_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // tsbGenerate
            // 
            this.tsbGenerate.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.tsbGenerate.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.miGenResourceScript,
            this.miGenCHeader,
            this.miGenDelphiHeader});
            this.tsbGenerate.Image = ((System.Drawing.Image)(resources.GetObject("tsbGenerate.Image")));
            this.tsbGenerate.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbGenerate.Name = "tsbGenerate";
            this.tsbGenerate.Size = new System.Drawing.Size(70, 22);
            this.tsbGenerate.Text = "Generate";
            this.tsbGenerate.ButtonClick += new System.EventHandler(this.tsbGenerate_ButtonClick);
            // 
            // miGenResourceScript
            // 
            this.miGenResourceScript.Name = "miGenResourceScript";
            this.miGenResourceScript.Size = new System.Drawing.Size(155, 22);
            this.miGenResourceScript.Text = "Resource Script";
            this.miGenResourceScript.Click += new System.EventHandler(this.miGenResourceScript_Click);
            // 
            // miGenCHeader
            // 
            this.miGenCHeader.Name = "miGenCHeader";
            this.miGenCHeader.Size = new System.Drawing.Size(155, 22);
            this.miGenCHeader.Text = "C/C++ Header";
            this.miGenCHeader.Click += new System.EventHandler(this.miGenCHeader_Click);
            // 
            // miGenDelphiHeader
            // 
            this.miGenDelphiHeader.Name = "miGenDelphiHeader";
            this.miGenDelphiHeader.Size = new System.Drawing.Size(155, 22);
            this.miGenDelphiHeader.Text = "Delphi Header";
            this.miGenDelphiHeader.Click += new System.EventHandler(this.miGenDelphiHeader_Click);
            // 
            // tsbDebug
            // 
            this.tsbDebug.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.tsbDebug.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.tsbDebug.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.miNewString,
            this.miSort,
            this.toolStripMenuItem1,
            this.miEditVersion,
            this.miGeneratePatch});
            this.tsbDebug.Image = ((System.Drawing.Image)(resources.GetObject("tsbDebug.Image")));
            this.tsbDebug.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbDebug.Name = "tsbDebug";
            this.tsbDebug.Size = new System.Drawing.Size(55, 22);
            this.tsbDebug.Text = "Debug";
            this.tsbDebug.Visible = false;
            // 
            // miNewString
            // 
            this.miNewString.Name = "miNewString";
            this.miNewString.Size = new System.Drawing.Size(166, 22);
            this.miNewString.Text = "Add New String...";
            this.miNewString.Click += new System.EventHandler(this.miNewString_Click);
            // 
            // miSort
            // 
            this.miSort.Name = "miSort";
            this.miSort.Size = new System.Drawing.Size(166, 22);
            this.miSort.Text = "Sort";
            this.miSort.Click += new System.EventHandler(this.miSort_Click);
            // 
            // list
            // 
            this.list.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.list.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.idHeader,
            this.pidHeader,
            this.dataHeader});
            this.list.Dock = System.Windows.Forms.DockStyle.Fill;
            this.list.FullRowSelect = true;
            this.list.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
            this.list.Location = new System.Drawing.Point(0, 25);
            this.list.MultiSelect = false;
            this.list.Name = "list";
            this.list.ShowGroups = false;
            this.list.ShowItemToolTips = true;
            this.list.Size = new System.Drawing.Size(767, 523);
            this.list.TabIndex = 1;
            this.list.UseCompatibleStateImageBehavior = false;
            this.list.View = System.Windows.Forms.View.Details;
            this.list.DoubleClick += new System.EventHandler(this.list_DoubleClick);
            // 
            // idHeader
            // 
            this.idHeader.Text = "ID";
            this.idHeader.Width = 84;
            // 
            // pidHeader
            // 
            this.pidHeader.Text = "PID";
            this.pidHeader.Width = 242;
            // 
            // dataHeader
            // 
            this.dataHeader.Text = "Data";
            this.dataHeader.Width = 408;
            // 
            // dlgOpen
            // 
            this.dlgOpen.DefaultExt = "fxlocale";
            this.dlgOpen.Filter = "FuturixImager Localization Dictionaries|*.fxlocale";
            this.dlgOpen.RestoreDirectory = true;
            // 
            // dlgSave
            // 
            this.dlgSave.DefaultExt = "fxlocale";
            this.dlgSave.Filter = "FuturixImager Localization Dictionaries|*.fxlocale";
            this.dlgSave.RestoreDirectory = true;
            // 
            // tsbPatch
            // 
            this.tsbPatch.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.tsbPatch.Image = ((System.Drawing.Image)(resources.GetObject("tsbPatch.Image")));
            this.tsbPatch.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbPatch.Name = "tsbPatch";
            this.tsbPatch.Size = new System.Drawing.Size(75, 22);
            this.tsbPatch.Text = "Apply Patch";
            this.tsbPatch.Click += new System.EventHandler(this.tsbPatch_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // miEditVersion
            // 
            this.miEditVersion.Name = "miEditVersion";
            this.miEditVersion.Size = new System.Drawing.Size(166, 22);
            this.miEditVersion.Text = "Edit Version...";
            this.miEditVersion.Click += new System.EventHandler(this.miEditVersion_Click);
            // 
            // miGeneratePatch
            // 
            this.miGeneratePatch.Name = "miGeneratePatch";
            this.miGeneratePatch.Size = new System.Drawing.Size(166, 22);
            this.miGeneratePatch.Text = "Generate Patch...";
            this.miGeneratePatch.Click += new System.EventHandler(this.miGeneratePatch_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(163, 6);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(767, 548);
            this.Controls.Add(this.list);
            this.Controls.Add(this.toolStrip);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FuturixImager Localization Editor";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.MainForm_KeyDown);
            this.toolStrip.ResumeLayout(false);
            this.toolStrip.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip toolStrip;
        private System.Windows.Forms.ListView list;
        private System.Windows.Forms.ColumnHeader idHeader;
        private System.Windows.Forms.ColumnHeader pidHeader;
        private System.Windows.Forms.ColumnHeader dataHeader;
        private System.Windows.Forms.ToolStripButton tsbOpen;
        private System.Windows.Forms.ToolStripButton tsbSave;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripDropDownButton tsbDebug;
        private System.Windows.Forms.ToolStripMenuItem miNewString;
        private System.Windows.Forms.ToolStripMenuItem miSort;
        private System.Windows.Forms.OpenFileDialog dlgOpen;
        private System.Windows.Forms.SaveFileDialog dlgSave;
        private System.Windows.Forms.ToolStripSplitButton tsbGenerate;
        private System.Windows.Forms.ToolStripMenuItem miGenResourceScript;
        private System.Windows.Forms.ToolStripMenuItem miGenCHeader;
        private System.Windows.Forms.ToolStripMenuItem miGenDelphiHeader;
        private System.Windows.Forms.ToolStripButton tsbPatch;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem miEditVersion;
        private System.Windows.Forms.ToolStripMenuItem miGeneratePatch;
    }
}

