﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace GrouponDesktop.Core
{
    /// <summary>
    /// Administra los formularios y las pantallas en el sistema
    /// </summary>
    class ViewsManager
    {
        /// <summary>
        /// Setea cual sera la ventana principal durante la sesion
        /// </summary>
        /// <param name="mainWindow">El formulario principal que sera el padre de todos los demas</param>
        public static void SetMainWindow(Form mainWindow)
        {
            mainWindow.IsMdiContainer = true;
            _mainWindow = mainWindow;
        }

        /// <summary>
        /// Carga un formulario para su visualizacion en el sistema
        /// </summary>
        /// <param name="form">Formulario a mostrar</param>
        public static void LoadView(Form form)
        {
            ClearViews();

            form.Text = string.Empty;
            form.ShowIcon = false;
            form.ControlBox = false;
            form.Dock = DockStyle.Fill;
            form.ShowInTaskbar = false;
            form.WindowState = FormWindowState.Maximized;
            form.MdiParent = _mainWindow;
            form.TopMost = true;
            form.Show();
        }

        /// <summary>
        /// Carga el menu del sistema segun los permisos del usuario
        /// </summary>
        public static void LoadMenu()
        {
            var formTypes = typeof(MainView).Assembly.GetTypes()
                .Where(x => x.IsSubclassOf(typeof(Form))
                    && x != typeof(MainView) && x != typeof(Login.LoginForm));

            foreach (var formType in formTypes)
            {
                if(IsAccesibleForm(formType))
                    AddMenuItemForView(formType);
            }
        }

        /// <summary>
        /// Cierra todas las ventanas activas en el sistema
        /// </summary>
        public static void ClearViews()
        {
            foreach (var chilren in _mainWindow.MdiChildren)
            {
                chilren.Close();
            }

            if (_mainWindow.ActiveMdiChild != null)
                _mainWindow.ActiveMdiChild.Close();
        }

        /// <summary>
        /// Muestra un mensaje de alerta en la aplicacion
        /// </summary>
        /// <param name="message">El mensaje a mostrarse</param>
        public static void Alert(string message)
        {
            MessageBox.Show(message);
        }

        #region Private Members

        /// <summary>
        /// Es la instancia de la ventana principal en el sistema
        /// </summary>
        private static Form _mainWindow;

        /// <summary>
        /// Agrega un elemento del menu para un formulario en particular
        /// </summary>
        /// <param name="formType">El Type del formulario para el cual agregar el menu item</param>
        private static void AddMenuItemForView(Type formType)
        {
            var form = (Form)Activator.CreateInstance(formType);
            
            var menuItem = new ToolStripMenuItem(form.Text, null, new EventHandler(Navigate))
            {
                Tag = formType
            };

            _mainWindow.MainMenuStrip.Items.Add(menuItem);
        }

        /// <summary>
        /// Metodo ejecutado al seleccionar un elemento del menu
        /// </summary>
        /// <param name="sender">El elemento del menu seleccionado</param>
        /// <param name="e">Argumentos del evento</param>
        private static void Navigate(object sender, EventArgs e)
        {
            var formType = (sender as ToolStripMenuItem).Tag as Type;
            LoadView(Activator.CreateInstance(formType) as Form);
        }

        /// <summary>
        /// Determina si un formulario es accesible para el usuario logueado
        /// </summary>
        /// <param name="formType">Type del formulario a evaluar</param>
        /// <returns>Retorna true si el usuario tiene acceso al formulario, de otra forma retorna false</returns>
        private static bool IsAccesibleForm(Type formType)
        {
            var permissionAttribute = (PermissionRequiredAttribute)Attribute.GetCustomAttribute(formType, typeof(PermissionRequiredAttribute));
            if (permissionAttribute == null) return true;

            foreach (var permission in permissionAttribute.Permissions)
            {
                if (!Session.User.Permissions.Contains(permission))
                    return false;
            }

            return true;
        }

        #endregion
    }
}