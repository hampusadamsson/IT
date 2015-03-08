import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;


public class tester 
{ public static void main(String[] args) 
	{ 
		String url = "jdbc:mysql://groucho.it.uu.se:3306/"; 
		String dbName = "Hotel_db"; 
		String driver = "com.mysql.jdbc.Driver"; 
		String userName = "ht_15_user28"; 
		String password = "pwd28"; 
		try { 
			Class.forName(driver).newInstance(); 
			Connection conn = DriverManager.getConnection(url+dbName,userName,password); 
			conn.close(); 
		} catch (Exception e) 
		{ e.printStackTrace(); 
		} 
	} 
}

/*
Connection groucherino = DriverManager.getConnection(
	"jdbc:myDriver:myDatabase",
	username,
	password
	);

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT a, b, c FROM Table1");

while (rs.next()) 
{
	int x = rs.getInt("a");
	String s = rs.getString("b");
	float f = rs.getFloat("c");

	if (stmt != null) 
	{

		try {
			smtm.close();
			} 
			catch (SQLException sqlEx) {} //ignore
	smtm = null;
	}
}

*/