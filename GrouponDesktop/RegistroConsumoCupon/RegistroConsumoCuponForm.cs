﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GrouponDesktop.Core;
using GrouponDesktop.Common;
using GrouponDesktop.Business;
using System.Collections;

namespace GrouponDesktop.RegistroConsumoCupon
{
    [PermissionRequired(Functionalities.RegistrarConsumoCupones)]
    public partial class RegistroConsumoCuponForm : Form
    {
        private CompraCuponManager _manager = new CompraCuponManager();

        public RegistroConsumoCuponForm()
        {
            InitializeComponent();
        }

        private void RegistroConsumoCuponForm_Load(object sender, EventArgs e)
        {
            dataGridView.DataSourceChanged += new EventHandler(dataGridView_DataSourceChanged);
            dataGridView.AutoGenerateColumns = false;
            dataGridView.DataSource = _manager.GetAll(new Proveedor() { UserID = Session.User.UserID });
        }

        void dataGridView_DataSourceChanged(object sender, EventArgs e)
        {
            var dataSource = dataGridView.DataSource as IList;
            lblResults.Text = dataSource.Count.ToString();
        }

        private void btnRegistrarConsumo_Click(object sender, EventArgs e)
        {
            if (dataGridView.SelectedRows == null || dataGridView.SelectedRows.Count == 0) return;
            var row = dataGridView.SelectedRows[0];
            var compraCupon = row.DataBoundItem as CompraCupon;
            if (MessageBox.Show(string.Format("Confirma que desea registrar el consumo de la compra '{0}'?", compraCupon.Codigo)
                , "Confirmar consumo", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                _manager.ConsumirCompra(compraCupon);
                MessageBox.Show(string.Format("Se ha registrado el consumo de la compra '{0}'", compraCupon.Codigo));
                ((BindingList<CompraCupon>)dataGridView.DataSource).Remove(compraCupon);
                dataGridView.Refresh();
            }
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            dataGridView.DataSource = _manager.GetAll(new Proveedor() { UserID = Session.User.UserID });
            dataGridView.Refresh();
        }
    }
}
