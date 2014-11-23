using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TempService
{
    public static class SqlHelper
    {

        public static void ExecuteQuery(string query, SqlParameter[] parameters)
        { 
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PhilGepsLocal"].ConnectionString);
            SqlCommand comm = new SqlCommand(query, conn);
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddRange(parameters);

            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
        }
        public static List<object> ExecuteQueryResult(string query, SqlParameter[] parameters)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PhilGepsLocal"].ConnectionString);
            SqlCommand comm = new SqlCommand(query, conn);
            comm.CommandType = CommandType.StoredProcedure;
            if (parameters!=null)
                comm.Parameters.AddRange(parameters);

            conn.Open();
            var reader = comm.ExecuteReader();
            List<object> data = new List<object>();
            while (reader.Read())
            {
                data.Add(reader.GetValue(0));
            }
            reader.Dispose();
            conn.Close();
            return data;
        }
    }
}