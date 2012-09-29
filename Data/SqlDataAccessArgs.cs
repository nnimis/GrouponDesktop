using System;
using System.Collections.Generic;

namespace Data
{
    /// <summary>
    /// Represents the set of arguments passed to execute the sentence
    /// </summary>
    public class SqlDataAccessArgs
    {
        /// <summary>
        /// Creates a new instance of <see cref="SqlDataAccessArgs"></see>.
        /// <seealso cref="SqlDataAccess"/>
        /// </summary>
        /// <example>This sample shows how to call the CreateWith method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         SqlDataAccess.ExecuteNonQuery("connectionstring_db1", "AddPerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="name">The argument name.</param>
        /// <param name="value">The argument value.</param>
        /// <returns>A <see cref="SqlDataAccessArgs"/> instance.</returns>
        public static SqlDataAccessArgs CreateWith(string name, object value)
        {
            return new SqlDataAccessArgs(name, value);
        }

        /// <summary>
        /// Add an argument to their collection.
        /// </summary>
        /// <example>This sample shows how to call the And method.
        /// <code escaped="true" lang="C#">
        ///   class MyClass 
        ///   {
        ///      public static int Main() 
        ///      {
        ///         SqlDataAccess.ExecuteNonQuery("connectionstring_db1", "AddPerson",
        ///             SqlDataAccessArgs.CreateWith("@FirstName", "Pablo")
        ///                 .And("@LastName", "Kerestezachi").Arguments);
        ///      }
        ///   }
        /// </code>
        /// </example>
        /// <param name="name">The argument name.</param>
        /// <param name="value">The argument value.</param>
        /// <returns>A <see cref="SqlDataAccessArgs"/> instance.</returns>
        public SqlDataAccessArgs And(string name, object value)
        {
            this.args[name] = value;
            return this;
        }

        /// <summary>
        /// Gets a collection of arguments.
        /// </summary>
        /// <value>Get an <see href="http://msdn2.microsoft.com/en-us/library/s4ys34ea.aspx">IDictionary(TKey, TValue) Generic Interface</see> that represent the argument collection.</value>
        public IDictionary<string, object> Arguments
        {
            get { return this.args; }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SqlDataAccessArgs"/> class.
        /// </summary>
        /// <param name="name">The argument name.</param>
        /// <param name="value">The argument value.</param>
        private SqlDataAccessArgs(string name, object value)
        {
            this.args[name] = value;
        }

        private IDictionary<string, object> args = new Dictionary<string, object>();
    }
}
