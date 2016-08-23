namespace FuturixLocalizer
{
    partial class GeneratePatchDialog
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
            this.dlgOpen = new System.Windows.Forms.OpenFileDialog();
            this.dlgSave = new System.Windows.Forms.SaveFileDialog();
            this.txtFirst = new System.Windows.Forms.TextBox();
            this.lblFirst = new System.Windows.Forms.Label();
            this.lblSecond = new System.Windows.Forms.Label();
            this.txtSecond = new System.Windows.Forms.TextBox();
            this.btnFirst = new System.Windows.Forms.Button();
            this.btnSecond = new System.Windows.Forms.Button();
            this.btnGenerate = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // dlgOpen
            // 
            this.dlgOpen.DefaultExt = "fxlocale";
            this.dlgOpen.Filter = "FuturixImager Localization Dictionaries|*.fxlocale";
            this.dlgOpen.RestoreDirectory = true;
            // 
            // dlgSave
            // 
            this.dlgSave.DefaultExt = "fxlocalepatch";
            this.dlgSave.Filter = "FuturixImager Localization Patches|*.fxlocalepatch";
            this.dlgSave.RestoreDirectory = true;
            // 
            // txtFirst
            // 
            this.txtFirst.Location = new System.Drawing.Point(12, 25);
            this.txtFirst.Name = "txtFirst";
            this.txtFirst.ReadOnly = true;
            this.txtFirst.Size = new System.Drawing.Size(352, 21);
            this.txtFirst.TabIndex = 0;
            // 
            // lblFirst
            // 
            this.lblFirst.AutoSize = true;
            this.lblFirst.Location = new System.Drawing.Point(12, 9);
            this.lblFirst.Name = "lblFirst";
            this.lblFirst.Size = new System.Drawing.Size(109, 13);
            this.lblFirst.TabIndex = 1;
            this.lblFirst.Text = "Older localization file:";
            // 
            // lblSecond
            // 
            this.lblSecond.AutoSize = true;
            this.lblSecond.Location = new System.Drawing.Point(12, 49);
            this.lblSecond.Name = "lblSecond";
            this.lblSecond.Size = new System.Drawing.Size(114, 13);
            this.lblSecond.TabIndex = 2;
            this.lblSecond.Text = "Newer localization file:";
            // 
            // txtSecond
            // 
            this.txtSecond.Location = new System.Drawing.Point(12, 65);
            this.txtSecond.Name = "txtSecond";
            this.txtSecond.ReadOnly = true;
            this.txtSecond.Size = new System.Drawing.Size(352, 21);
            this.txtSecond.TabIndex = 3;
            // 
            // btnFirst
            // 
            this.btnFirst.Location = new System.Drawing.Point(370, 24);
            this.btnFirst.Name = "btnFirst";
            this.btnFirst.Size = new System.Drawing.Size(75, 23);
            this.btnFirst.TabIndex = 4;
            this.btnFirst.Text = "Select";
            this.btnFirst.UseVisualStyleBackColor = true;
            this.btnFirst.Click += new System.EventHandler(this.btnFirst_Click);
            // 
            // btnSecond
            // 
            this.btnSecond.Location = new System.Drawing.Point(370, 64);
            this.btnSecond.Name = "btnSecond";
            this.btnSecond.Size = new System.Drawing.Size(75, 23);
            this.btnSecond.TabIndex = 5;
            this.btnSecond.Text = "Select";
            this.btnSecond.UseVisualStyleBackColor = true;
            this.btnSecond.Click += new System.EventHandler(this.btnSecond_Click);
            // 
            // btnGenerate
            // 
            this.btnGenerate.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btnGenerate.Location = new System.Drawing.Point(289, 104);
            this.btnGenerate.Name = "btnGenerate";
            this.btnGenerate.Size = new System.Drawing.Size(75, 23);
            this.btnGenerate.TabIndex = 6;
            this.btnGenerate.Text = "Generate";
            this.btnGenerate.UseVisualStyleBackColor = true;
            this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(370, 104);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            // 
            // GeneratePatchDialog
            // 
            this.AcceptButton = this.btnGenerate;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(457, 139);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnGenerate);
            this.Controls.Add(this.btnSecond);
            this.Controls.Add(this.btnFirst);
            this.Controls.Add(this.txtSecond);
            this.Controls.Add(this.lblSecond);
            this.Controls.Add(this.lblFirst);
            this.Controls.Add(this.txtFirst);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "GeneratePatchDialog";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Generate Patch";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.OpenFileDialog dlgOpen;
        private System.Windows.Forms.SaveFileDialog dlgSave;
        private System.Windows.Forms.TextBox txtFirst;
        private System.Windows.Forms.Label lblFirst;
        private System.Windows.Forms.Label lblSecond;
        private System.Windows.Forms.TextBox txtSecond;
        private System.Windows.Forms.Button btnFirst;
        private System.Windows.Forms.Button btnSecond;
        private System.Windows.Forms.Button btnGenerate;
        private System.Windows.Forms.Button btnCancel;
    }
}