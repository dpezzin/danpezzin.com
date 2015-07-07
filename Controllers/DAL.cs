using System;
using System.Data;
using Npgsql;

namespace App1
{
    public class Dal
    {
        static string serverName = "127.0.0.1"; //localhost
        static string port = "5432"; // default port 
        static string userName = "postgres"; //admin name
        static string password = "Michfball#16"; //admin password
        static string databaseName = "TestDB"; //database name

        string connString = String.Format("Server={0};Port={1};User Id={2};Password={3};Database={4};",
                                           serverName, port, userName, password, databaseName);

        //Get all records
        public DataTable GetAllRecords()
        { 

            DataTable dtRecord = new DataTable();

            try
            {
                using (NpgsqlConnection pgsqlConnection = new NpgsqlConnection(connString))
                {
                    // Open the PgSQL Connection.                
                    pgsqlConnection.Open();
                    string selectCommand = "Select * from tblPlayers";

                    using (NpgsqlDataAdapter Adpt = new NpgsqlDataAdapter(selectCommand, pgsqlConnection))
                    {
                        Adpt.Fill(dtRecord);
                    }                   
                }
            }
            catch (NpgsqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dtRecord;
        }

        //Insert records
        public void InsertRecord(string PlayerName, int Age, string BelongsTo, int Salary)
        {
           
            try
            {
                using (NpgsqlConnection pgsqlConnection = new NpgsqlConnection(connString))
                {
                    // Open the PgSQL Connection.                  
                    pgsqlConnection.Open();

                    string insertCommand = String.Format(
                                                            "Insert Into tblPlayers(playername,age,belongsto,salary) values('{0}',{1},'{2}',{3})",
                                                            PlayerName,Age,BelongsTo,Salary
                                                        );

                    using (NpgsqlCommand pgsqlcommand = new NpgsqlCommand(insertCommand, pgsqlConnection))
                    {
                        pgsqlcommand.ExecuteNonQuery();
                    }                    
                }
            }
            catch (NpgsqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //Update records
        public void UpdateRecord(string PlayerName, int Salary)
        {
            try
            {
                using (NpgsqlConnection pgsqlConnection = new NpgsqlConnection(connString))
                {
                    // Open the PgSQL Connection.                  
                    pgsqlConnection.Open();

                    string updateCommand = String.Format(
                                                            "Update tblPlayers Set salary  = salary + {0} Where playername = '{1}'",
                                                            Salary, PlayerName
                                                        );

                    using (NpgsqlCommand pgsqlcommand = new NpgsqlCommand(updateCommand, pgsqlConnection))
                    {
                        pgsqlcommand.ExecuteNonQuery();
                    }
                }
            }
            catch (NpgsqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //Delete records
        public void DeleteRecord(string PlayerName)
        {
            try
            {
                using (NpgsqlConnection pgsqlConnection = new NpgsqlConnection(connString))
                {
                    // Open the PgSQL Connection.                  
                    pgsqlConnection.Open();

                    string insertCommand = String.Format(
                                                            "Delete From tblPlayers Where playername = '{0}'",
                                                            PlayerName
                                                        );

                    using (NpgsqlCommand pgsqlcommand = new NpgsqlCommand(insertCommand, pgsqlConnection))
                    {
                        pgsqlcommand.ExecuteNonQuery();
                    }
                }
            }
            catch (NpgsqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}
