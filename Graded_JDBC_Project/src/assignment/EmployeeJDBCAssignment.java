package assignment;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class EmployeeJDBCAssignment 
{
	static Connection con=null;
	static Statement st=null;

	public static void main(String[] args) throws SQLException 
	{


		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch(ClassNotFoundException e)
		{
			System.out.println(e.getMessage());
		}

		try 
		{
			con=DriverManager.getConnection("jdbc:mysql://127.0.0.1/gl?useSSL=false","root","1234");
			st=con.createStatement();




			/*
			 * Query to create employee table 
			 */
			String tableCreation="create table employee (Id int primary key, Name varchar(50) NOT NULL,Email_Id varchar(50) NOT NULL,Phone_Number varchar(10))";
			st.execute(tableCreation);
			System.out.println("Table created Succesfully");





			/*
			 * Query to insert record in  employee table 
			 */
			String insertionQuery="insert into employee(Id,Name,Email_Id,Phone_Number) values"
					+ " (1,\"Joseph\",\"joseph@gmail.com\",\"9687698769\"),"
					+ "(2,\"Jacob Jack\",\"jackjacob@gmail.com\",\"8965746985\"),"
					+ "(3,\"Steve\",\"steve@gmail.com\",\"7869547866\"),"
					+ "(4,\"Zack \",\"zack@gmail.com\",\"9865475896\"),"
					+ "(5,\"Simon\",\"simon@gmail.com\",\"9564324569\")";


			st.executeUpdate(insertionQuery);
			System.out.println("Insertion completed ");


			/*
			 * Query to update Email_Id column 
			 */
			String emailModify="alter table employee modify Email_Id varchar(30) not null";

			st.executeUpdate(emailModify);
			System.out.println("Table modified succesfully ");



			/*
			 * Query to insert 2 records after updating Email_Id column 
			 */
			String newInsert="insert into employee(Id,Name,Email_Id,Phone_Number) values"
					+" (6,\"Marc\",\"marc@gmail.com\",\"7854236941\"),"
					+ "(7,\"Chris\",\"chris@gmail.com\",\"6325632569\")";

			st.executeUpdate(newInsert);
			System.out.println("Insertion completed ");



			/*
			 * Query to update employee 3 record  
			 */
			String update="update employee set Name=\"Karthik\" ,Phone_Number=\"9999999999\" where Id=3 ";

			st.executeUpdate(update);
			System.out.println("updation completed ");





			/*
			 * Query to delete  Records 3 and 4 from employee table 
			 */
			String deleteRecord="delete from employee where Id in(3,4)";

			st.executeUpdate(deleteRecord);

			System.out.println("Records 3 and 4 have been deleted successfully");



			/*
			 * Query to delete all Records from employee table 
			 */
			String deleteAllRecord="delete from employee";

			st.executeUpdate(deleteAllRecord);

			System.out.println("All records deleted successfully ");


		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			con.close();
			st.close();
		}


	}
}
