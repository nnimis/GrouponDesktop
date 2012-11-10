namespace GrouponDesktop.ArmarCupon
{
    partial class NuevoCupon
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
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtCodigo = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.dtpFechaPublicacion = new System.Windows.Forms.DateTimePicker();
            this.dtpFechaVigencia = new System.Windows.Forms.DateTimePicker();
            this.dtpFechaVencimiento = new System.Windows.Forms.DateTimePicker();
            this.label4 = new System.Windows.Forms.Label();
            this.txtPrecio = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtPrecioOriginal = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtCantidad = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtCantidadPorUsuario = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.cities = new System.Windows.Forms.Label();
            this.clbCiudades = new System.Windows.Forms.CheckedListBox();
            this.txtDescripcion = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(19, 96);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(121, 13);
            this.label3.TabIndex = 17;
            this.label3.Text = "Vencimiento de la oferta";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(30, 70);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(110, 13);
            this.label2.TabIndex = 15;
            this.label2.Text = "Fecha de Publicación";
            // 
            // txtCodigo
            // 
            this.txtCodigo.Location = new System.Drawing.Point(141, 13);
            this.txtCodigo.Name = "txtCodigo";
            this.txtCodigo.ReadOnly = true;
            this.txtCodigo.Size = new System.Drawing.Size(181, 20);
            this.txtCodigo.TabIndex = 14;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(99, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(40, 13);
            this.label1.TabIndex = 13;
            this.label1.Text = "Código";
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(22, 402);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 12;
            this.btnCancel.Text = "Cancelar";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSave.Location = new System.Drawing.Point(247, 402);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 11;
            this.btnSave.Text = "Guardar";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // dtpFechaPublicacion
            // 
            this.dtpFechaPublicacion.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFechaPublicacion.Location = new System.Drawing.Point(141, 67);
            this.dtpFechaPublicacion.Name = "dtpFechaPublicacion";
            this.dtpFechaPublicacion.Size = new System.Drawing.Size(181, 20);
            this.dtpFechaPublicacion.TabIndex = 21;
            // 
            // dtpFechaVigencia
            // 
            this.dtpFechaVigencia.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFechaVigencia.Location = new System.Drawing.Point(141, 93);
            this.dtpFechaVigencia.Name = "dtpFechaVigencia";
            this.dtpFechaVigencia.Size = new System.Drawing.Size(181, 20);
            this.dtpFechaVigencia.TabIndex = 22;
            // 
            // dtpFechaVencimiento
            // 
            this.dtpFechaVencimiento.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpFechaVencimiento.Location = new System.Drawing.Point(141, 119);
            this.dtpFechaVencimiento.Name = "dtpFechaVencimiento";
            this.dtpFechaVencimiento.Size = new System.Drawing.Size(181, 20);
            this.dtpFechaVencimiento.TabIndex = 24;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(11, 122);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(128, 13);
            this.label4.TabIndex = 23;
            this.label4.Text = "Vencimiento del consumo";
            // 
            // txtPrecio
            // 
            this.txtPrecio.Location = new System.Drawing.Point(141, 145);
            this.txtPrecio.Name = "txtPrecio";
            this.txtPrecio.Size = new System.Drawing.Size(181, 20);
            this.txtPrecio.TabIndex = 26;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(82, 148);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(57, 13);
            this.label5.TabIndex = 25;
            this.label5.Text = "Precio real";
            // 
            // txtPrecioOriginal
            // 
            this.txtPrecioOriginal.Location = new System.Drawing.Point(141, 171);
            this.txtPrecioOriginal.Name = "txtPrecioOriginal";
            this.txtPrecioOriginal.Size = new System.Drawing.Size(181, 20);
            this.txtPrecioOriginal.TabIndex = 28;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(69, 174);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(70, 13);
            this.label6.TabIndex = 27;
            this.label6.Text = "Precio ficticio";
            // 
            // txtCantidad
            // 
            this.txtCantidad.Location = new System.Drawing.Point(141, 198);
            this.txtCantidad.Name = "txtCantidad";
            this.txtCantidad.Size = new System.Drawing.Size(181, 20);
            this.txtCantidad.TabIndex = 36;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(41, 201);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(99, 13);
            this.label7.TabIndex = 35;
            this.label7.Text = "Cantidad disponible";
            // 
            // txtCantidadPorUsuario
            // 
            this.txtCantidadPorUsuario.Location = new System.Drawing.Point(141, 224);
            this.txtCantidadPorUsuario.Name = "txtCantidadPorUsuario";
            this.txtCantidadPorUsuario.Size = new System.Drawing.Size(181, 20);
            this.txtCantidadPorUsuario.TabIndex = 38;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(35, 227);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(104, 13);
            this.label8.TabIndex = 37;
            this.label8.Text = "Cantidad por usuario";
            // 
            // cities
            // 
            this.cities.AutoSize = true;
            this.cities.Location = new System.Drawing.Point(27, 250);
            this.cities.Name = "cities";
            this.cities.Size = new System.Drawing.Size(108, 13);
            this.cities.TabIndex = 40;
            this.cities.Text = "Zonas de adquisición";
            // 
            // clbCiudades
            // 
            this.clbCiudades.FormattingEnabled = true;
            this.clbCiudades.Location = new System.Drawing.Point(141, 250);
            this.clbCiudades.Name = "clbCiudades";
            this.clbCiudades.Size = new System.Drawing.Size(181, 139);
            this.clbCiudades.TabIndex = 39;
            // 
            // txtDescripcion
            // 
            this.txtDescripcion.Location = new System.Drawing.Point(141, 40);
            this.txtDescripcion.Name = "txtDescripcion";
            this.txtDescripcion.Size = new System.Drawing.Size(181, 20);
            this.txtDescripcion.TabIndex = 42;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(72, 43);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(63, 13);
            this.label9.TabIndex = 41;
            this.label9.Text = "Descripción";
            // 
            // NuevoCupon
            // 
            this.AcceptButton = this.btnSave;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(344, 437);
            this.Controls.Add(this.txtDescripcion);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.cities);
            this.Controls.Add(this.clbCiudades);
            this.Controls.Add(this.txtCantidadPorUsuario);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.txtCantidad);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txtPrecioOriginal);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.txtPrecio);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.dtpFechaVencimiento);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.dtpFechaVigencia);
            this.Controls.Add(this.dtpFechaPublicacion);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCodigo);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSave);
            this.Name = "NuevoCupon";
            this.Text = "Nuevo Cupón";
            this.Load += new System.EventHandler(this.NuevoCupon_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtCodigo;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.DateTimePicker dtpFechaPublicacion;
        private System.Windows.Forms.DateTimePicker dtpFechaVigencia;
        private System.Windows.Forms.DateTimePicker dtpFechaVencimiento;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtPrecio;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtPrecioOriginal;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtCantidad;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtCantidadPorUsuario;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label cities;
        private System.Windows.Forms.CheckedListBox clbCiudades;
        private System.Windows.Forms.TextBox txtDescripcion;
        private System.Windows.Forms.Label label9;

    }
}