package like;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class likeDAO {
	private Connection conn;
	
	public likeDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:3306/epicus";

			String dbID = "root";

			String dbPassword = "root";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace();

		}
	}
	public int like(String userID, String userWriteTitle, String userIP) {

		String SQL = "INSERT INTO like VALUES (?, ?, ?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			pstmt.setString(2, userWriteTitle);

			pstmt.setString(3, userIP);

			

			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -1; 

	}
	
}
