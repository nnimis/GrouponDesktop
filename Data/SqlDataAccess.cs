using System;
using System.Xml;
using System.Data;
using System.Xml.XPath;
using System.Data.SqlTypes;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Data
{
    /// <summary>
    /// Represents a provider data access class only for SQL database type.
    /// <seealso cref="SqlDataAccessArgs"/>
    /// </summary>
    public sealed class SqlDataAccess
    {
        private static SqlConnection _connection;

        /// <summary>
        /// Opens a connection and instantiates a transaction for the specified connection string
        /// </summary>
        /// <param name="connectionString">Connection string.</param>
        /// <returns>The transaction oppened.</returns>
        public static SqlTransaction OpenTransaction(string connectionString)
        {
            _connection = new SqlConnection(connectionString);
            _connection.Open();
            return _connection.BeginTransaction();
        }

        /// <summary>
        /// Executes the commit for a specified transaction and closes Session's connection
        /// </summary>
        /// <param name="transaction">The transaction to be commited.</param>
        public static void Commit(SqlTransaction transaction)
        {
            transaction.Commit();
            _connection.Close();
            _connection.Dispose();
            _connection = null;
        }

        /// <summary>
        /// Rollback a specified transaction and closes Session's connection
        /// </summary>
        /// <param name="transaction">The transaction to be rolled back.</param>
        public static void Rollback(SqlTransaction transaction)
        {
            transaction.Rollback();
            _connection.Close();
            _connection.Dispose();
            _connection = null;
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns the number of rows affected.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteNonQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         SqlDataAccess.ExecuteNonQuery("connectionstring_db1", "RunCleanUp");
        ///      }
        ///   }
        /// </code>
        /// </example>        
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <returns>The number of rows affected.</returns>
        public static int ExecuteNonQuery(string connectionString, string text)
        {
            return ExecuteNonQuery(connectionString, text, null);
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns the number of rows affected.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteNonQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         SqlDataAccess.ExecuteNonQuery("connectionstring_db1", "UpdatePerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo")
        ///                 .And("@LastName", "Kerestezachi").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>The number of rows affected.</returns>
        public static int ExecuteNonQuery(string connectionString, string text, IDictionary<string, object> args)
        {
            int result = -1;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.StoredProcedure;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                        }
                    con.Open();
                    try
                    {
                        result = com.ExecuteNonQuery();
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns the number of rows affected.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteNonQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         SqlDataAccess.ExecuteNonQuery("connectionstring_db1", "UpdatePerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo")
        ///                 .And("@LastName", "Kerestezachi").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <param name="transaction">The transaction which holds the statement to be executed.</param>
        /// <returns>The number of rows affected.</returns>
        public static int ExecuteNonQuery(string text, IDictionary<string, object> args, SqlTransaction transaction)
        {
            int result = -1;

            using (SqlCommand com = new SqlCommand(text, _connection, transaction))
            {
                com.CommandType = CommandType.StoredProcedure;
                if (args != null && args.Count > 0)
                    foreach (string key in args.Keys)
                    {
                        com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                    }
                try
                {
                    result = com.ExecuteNonQuery();
                }
                finally
                {
                    try
                    {
                        com.Dispose();
                    }
                    catch { }
                }
            }

            return result;
        }

        /// <summary>
        /// Executes the query, and returns the first column of the first row in the result set returned by the query. Additional columns or rows are ignored.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteScalarQuery<T> method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         string guid = SqlDataAccess.ExecuteScalarQuery<string>("connectionstring_db1", "AddNewGuid");
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <typeparam name="T">The type of the first column of the first row in the result set returned by the query.</typeparam>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <returns>The first column of the first row in the result set, or a null reference (Nothing in Visual Basic) if the result set is empty.</returns>
        public static T ExecuteScalarQuery<T>(string connectionString, string text)
        {
            return (T)Convert.ChangeType(ExecuteScalarQuery(connectionString, text, null, null), typeof(T));
        }

        /// <summary>
        /// Executes the query, and returns the first column of the first row in the result set returned by the query. Additional columns or rows are ignored.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteScalarQuery<T> method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         int personId = SqlDataAccess.ExecuteScalarQuery<int>("connectionstring_db1", "AddPerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo")
        ///                 .And("@LastName", "Kerestezachi").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <typeparam name="T">The type of the first column of the first row in the result set returned by the query.</typeparam>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>The first column of the first row in the result set, or a null reference (Nothing in Visual Basic) if the result set is empty.</returns>
        public static T ExecuteScalarQuery<T>(string connectionString, string text, IDictionary<string, object> args)
        {
            return (T)Convert.ChangeType(ExecuteScalarQuery(connectionString, text, args, null), typeof(T));
        }

        /// <summary>
        /// Executes the query, and returns the column name passed in the last parameter of the first row in the result set returned by the query. Additional columns or rows are ignored.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteScalarQuery<T> method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         string guid = SqlDataAccess.ExecuteScalarQuery<string>("connectionstring_db1", "AddPerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo")
        ///                 .And("@LastName", "Kerestezachi").Arguments, "GUID");
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <typeparam name="T">The type of the column name passed in the last parameter of the first row in the result set returned by the query.</typeparam>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <param name="field">The field name of the specified column retrieval.</param>
        /// <returns>The column name passed in the last parameter of the first row in the result set, or a null reference (Nothing in Visual Basic) if the result set is empty.</returns>
        public static T ExecuteScalarQuery<T>(string connectionString, string text, IDictionary<string, object> args, string field)
        {
            return (T)Convert.ChangeType(ExecuteScalarQuery(connectionString, text, args, field), typeof(T));
        }

        /// <summary>
        /// Executes the query, and returns the column name passed in the last parameter of the first row in the result set returned by the query. Additional columns or rows are ignored.
        /// </summary>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <param name="field">The field name of the specified column retrieval.</param>
        /// <returns>The column name passed in the last parameter of the first row in the result set, or a null reference (Nothing in Visual Basic) if the result set is empty.</returns>
        private static object ExecuteScalarQuery(string connectionString, string text, IDictionary<string, object> args, string field)
        {
            if (field != null)
                return executeDataRowAsScalar(connectionString, text, args, field);

            object result = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.StoredProcedure;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                        }
                    con.Open();
                    try
                    {
                        result = com.ExecuteScalar();
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        public static T ExecuteScalarQuery<T>(string text, IDictionary<string, object> args, SqlTransaction transaction)
        {
            object result = null;
            
            using (SqlCommand com = new SqlCommand(text, _connection, transaction))
            {
                com.CommandType = CommandType.StoredProcedure;
                if (args != null && args.Count > 0)
                    foreach (string key in args.Keys)
                    {
                        com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                    }
                try
                {
                    result = com.ExecuteScalar();
                }
                finally
                {
                    try
                    {
                        com.Dispose();
                    }
                    catch { }
                }
            }

            return (T)Convert.ChangeType(result, typeof(T));
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datatable.aspx">DataTable</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteDataTableQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         DataTable dataTable = SqlDataAccess.ExecuteDataTableQuery("connectionstring_db1", "RetreivePersons");
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datatable.aspx">DataTable</see> class.</returns>
        public static DataTable ExecuteDataTableQuery(string connectionString, string text)
        {
            return ExecuteDataTableQuery(connectionString, text, null);
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datatable.aspx">DataTable</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteDataTableQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         DataTable dataTable = SqlDataAccess.ExecuteDataTableQuery("connectionstring_db1", "RetreivePersonsByStatus",
        ///             SqlDataAccessArgs.CreateWith("@Enabled", True).Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datatable.aspx">DataTable</see> class.</returns>
        public static DataTable ExecuteDataTableQuery(string connectionString, string text, IDictionary<string, object> args)
        {
            DataTable result = null;
            int count = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.StoredProcedure;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                        }
                    con.Open();
                    try
                    {
                        SqlDataReader dr = com.ExecuteReader();
                        if (dr.HasRows)
                        {
                            result = new DataTable();

                            while (dr.Read())
                            {
                                DataRow row = result.NewRow();
                                for (int i = 0; i < dr.FieldCount; i++)
                                {
                                    if (count == 0)
                                        result.Columns.Add(dr.GetName(i));

                                    row[i] = dr[i];
                                }
                                result.Rows.Add(row);
                                count++;
                            }
                        }
                        dr.Close();
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteDataRowQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         DataRow dataRow = SqlDataAccess.ExecuteDataRowQuery("connectionstring_db1", "RetreiveCacheConfig");
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> class.</returns>
        public static DataRow ExecuteDataRowQuery(string connectionString, string text)
        {
            return ExecuteDataRowQuery(connectionString, text, null);
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteDataRowQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         DataRow dataRow = SqlDataAccess.ExecuteDataRowQuery("connectionstring_db1", "RetreiveConfig",
        ///             SqlDataAccessArgs.CreateWith("@ConfigName", "Cache").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> class.</returns>
        public static DataRow ExecuteDataRowQuery(string connectionString, string text, IDictionary<string, object> args)
        {
            DataRow result = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.StoredProcedure;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                        }
                    con.Open();
                    try
                    {
                        SqlDataReader dr = com.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            result = new DataTable().NewRow();
                            for (int i = 0; i < dr.FieldCount; i++)
                            {
                                result.Table.Columns.Add(dr.GetName(i));
                                result[i] = dr[i];
                            }
                        }
                        dr.Close();
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteDataRowQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         DataRow dataRow = SqlDataAccess.ExecuteDataRowQuery("connectionstring_db1", "RetreiveConfig",
        ///             SqlDataAccessArgs.CreateWith("@ConfigName", "Cache").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.data.datarow.aspx">DataRow</see> class.</returns>
        public static DataRow ExecuteDataRowText(string connectionString, string text, IDictionary<string, object> args)
        {
            DataRow result = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.Text;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key]);
                        }
                    con.Open();
                    try
                    {
                        SqlDataReader dr = com.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            result = new DataTable().NewRow();
                            for (int i = 0; i < dr.FieldCount; i++)
                            {
                                result.Table.Columns.Add(dr.GetName(i));
                                result[i] = dr[i];
                            }
                        }
                        dr.Close();
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx">XmlDocument</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteXmlQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         XmlDocument doc = SqlDataAccess.ExecuteXmlQuery("connectionstring_db1", "RetreiveCacheConfig");
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx">XmlDocument</see> class.</returns>
        public static XmlDocument ExecuteXmlQuery(string connectionString, string text)
        {
            return ExecuteXmlQuery(connectionString, text, null);
        }

        /// <summary>
        /// Executes a Transact-SQL statement against the connection and returns a <see href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx">XmlDocument</see> object.
        /// </summary>
        /// <example>This sample shows how to call the ExecuteXmlQuery method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         XmlDocument doc = SqlDataAccess.ExecuteXmlQuery("connectionstring_db1", "RetreiveConfig",
        ///             SqlDataAccessArgs.CreateWith("@ConfigName", "Cache").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="connectionString">Connection string.</param>
        /// <param name="text">The store procedure name to be executed.</param>
        /// <param name="args">The arguments passed to execute the sentence.</param>
        /// <returns>An instance of a <see href="http://msdn2.microsoft.com/en-us/library/system.xml.xmldocument.aspx">XmlDocument</see> class.</returns>
        public static XmlDocument ExecuteXmlQuery(string connectionString, string text, IDictionary<string, object> args)
        {
            XmlDocument result = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand com = new SqlCommand(text, con))
                {
                    com.CommandType = CommandType.StoredProcedure;
                    if (args != null && args.Count > 0)
                        foreach (string key in args.Keys)
                        {
                            com.Parameters.AddWithValue(key, args[key] == null ? DBNull.Value : args[key]);
                        }
                    con.Open();
                    try
                    {
                        XmlReader xr = com.ExecuteXmlReader();
                        result = new XmlDocument();
                        result.Load(xr);
                        xr.Close();
                    }
                    catch (Exception ex)
                    {
                        if (ex.InnerException.GetType().Equals(typeof(SqlNullValueException)))
                            return null;
                    }
                    finally
                    {
                        try
                        {
                            con.Close();
                            con.Dispose();
                            com.Dispose();
                        }
                        catch { }
                    }
                }
            }

            return result;
        }

        private static object executeDataRowAsScalar(string connectionString, string text, IDictionary<string, object> args, string field)
        {
            DataRow row = ExecuteDataRowQuery(connectionString, text, args);
            if (row == null)
                return null;

            if (!row.Table.Columns.Contains(field))
                return null;

            return row[field];
        }

        private SqlDataAccess() { }
    }
}
