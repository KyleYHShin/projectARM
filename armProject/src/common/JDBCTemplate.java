package common;

import java.sql.*;

//싱글톤 제작
public class JDBCTemplate {

	private JDBCTemplate() {
	}

	public static Connection getConnection() {
		Connection con = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String user = "arm";
			String password = "arm";


		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);

			// 자동 커밋 방지!! 잊지 말기!!
			con.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public static void close(Connection con) {
		try {
			if (!con.isClosed()){
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void close(PreparedStatement pstmt) {
		try {
			if (!pstmt.isClosed()){
				pstmt.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if (!stmt.isClosed()){
				stmt.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rset) {
		try {
			if (!rset.isClosed()){
				rset.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void commit(Connection con) {
		try {
			if (!con.isClosed()){
				con.commit();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void rollback(Connection con) {
		try {
			if (!con.isClosed()){
				con.rollback();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
