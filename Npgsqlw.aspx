<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<pre>&lt;!--  
//  
// Npgsqlw.aspx  
// Date: 2006.11.16  
// author: Hiroshi Saito(z-saito at guitar dot ocn dot ne dot jp)  
// Description: This is tried in PostgreSQL 8.1.  
// Attention: Please note it enough for the reasons of not preferable on security in use.  
//  
--&gt;

&lt;%@ Page Language=&quot;C#&quot;%&gt;  
&lt;%@ Import Namespace=&quot;System&quot; %&gt;  
&lt;%@ Import Namespace=&quot;System.Data&quot; %&gt;  
&lt;%@ Import Namespace=&quot;System.IO&quot; %&gt;  
&lt;%@ Import Namespace=&quot;System.Web&quot; %&gt;  
&lt;%@ Import Namespace=&quot;Npgsql&quot; %&gt;

&lt;script language=&quot;C#&quot; runat=&quot;server&quot;&gt;   
         
	String url = &quot;localhost&quot;;      
	String dbn = &quot;template1&quot;;      
	String usr = &quot;postgres&quot;;   
         
	NpgsqlConnection cnDB;

	protected void Page_Load(object sender, EventArgs e)      
	{          
		String constr = &quot;DATABASE=&quot; + dbn + &quot;;SERVER=&quot; + url + &quot;;UID=&quot; + usr + &quot;;Encoding=UNICODE;&quot;;          
		cnDB = new NpgsqlConnection(constr);          
		try          
		{              
		cnDB.Open();          
		}          
	catch (NpgsqlException ex)          
	{              
	Query.Text = constr;              
	Result.Text = ex.ToString();              
	return;          
	}                    
	Result.Text = &quot;Ready.&quot;;      
	}

protected void Query_TextChanged(object sender, EventArgs e)      
{          
NpgsqlCommand command = new NpgsqlCommand();          
NpgsqlDataReader dr;            
Result.Text = &quot;&quot;;                    
if (cnDB == null)          
{              
Result.Text = &quot;Sorry, The connection has been broken off.&quot;;              
return;          
}

command.Connection = cnDB;          command.CommandText = Query.Text;            try          {              dr = command.ExecuteReader();          }          catch(NpgsqlException ex)          {              Result.Text = ex.ToString();              return;          }                    //  this is empty result check.          if (!dr.HasRows)                  return;            do          {              Int32 j, i;              j = dr.FieldCount;              DataTable dt = dr.GetSchemaTable();              DataRowCollection schemarows = dt.Rows;                            for (i = 0; i &lt; j; i++)              {                  Result.Text += schemarows[i][0] + &quot;\t&quot;;              }                            Result.Text += &quot;\r&quot;;                            while(dr.Read())              {                  for (i = 0; i &lt; j; i++)                  {                      Result.Text +=  dr[i] + &quot;\t&quot;;            }                                    Result.Text += &quot;\r&quot;;              }          } while (dr.NextResult());              }    &lt;/script&gt;    &lt;!DOCTYPE html PUBLIC &quot;-//W3C//DTD XHTML 1.0 Transitional//EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;&gt;    &lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot; &gt;  &lt;head runat=&quot;server&quot;&gt;      &lt;title&gt;Npgsql (.NET Data Provider)&lt;/title&gt;  &lt;/head&gt;  &lt;body style=&quot;font-family: Times New Roman&quot;&gt;      &lt;form id=&quot;form1&quot; runat=&quot;server&quot;&gt;      &lt;div style=&quot;text-align: left&quot;&gt;          &lt;span style=&quot;color: #3399ff&quot;&gt;&lt;span style=&quot;font-size: 24pt&quot;&gt;&lt;strong&gt;          Npgsql (.NET Data Provider)&lt;/strong&gt; &lt;/span&gt;&lt;/span&gt;          &lt;br /&gt;          &lt;asp:TextBox ID=&quot;Query&quot; runat=&quot;server&quot; Height=&quot;24px&quot; Width=&quot;663px&quot; OnTextChanged=&quot;Query_TextChanged&quot; Font-Size=&quot;14pt&quot;&gt;&lt;/asp:TextBox&gt;&lt;br /&gt;          &lt;br /&gt;          &lt;asp:TextBox ID=&quot;Result&quot; runat=&quot;server&quot; BorderStyle=&quot;Solid&quot; Height=&quot;359px&quot; TextMode=&quot;MultiLine&quot;              Width=&quot;662px&quot; Font-Size=&quot;9pt&quot; BackColor=&quot;#FFE0C0&quot;&gt;&lt;/asp:TextBox&gt;&lt;br /&gt;          &lt;br /&gt;          &lt;span style=&quot;font-size: 24pt&quot;&gt;&lt;strong&gt;          Powered by PostgreSQL&lt;/strong&gt;&lt;/span&gt;&lt;/div&gt;      &lt;/form&gt;  &lt;/body&gt;  &lt;/html&gt;</pre>
</body>
</html>
