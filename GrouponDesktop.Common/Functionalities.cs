using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GrouponDesktop.Common
{
    /// <summary>
    /// Son los permisos administrables del sistema para determinar que usuario puede acceder a cada pantalla
    /// </summary>
    public enum Functionalities
    {
        AdministrarClientes,
        AdministrarProveedores,
        AdministrarCupones,
        CargarCredito,
        CrearCupon,
        ComprarCupones,
        GiftCards,
        Facturar,
        VerHistorialCupones,
        ListarEstadisticas,
        PedirDevoluciones,
        PublicarCupones,
        RegistrarConsumoCupones,
        AdministrarRoles
    }
}
