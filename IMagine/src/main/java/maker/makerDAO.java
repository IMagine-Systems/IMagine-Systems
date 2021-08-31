package maker;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

	public class makerDAO {
		private Connection conn; // 데이터베이스에 접근해주는 객체이다.
		private PreparedStatement pstmt;
		private ResultSet rs;
		private int count = 0;
		
		public makerDAO() {
			try {

				String dbUrl = "jdbc:mariadb://localhost:3306/flows";
				String dbId = "youn";
				String dbPw = "0924";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(dbUrl, dbId, dbPw);
				System.out.println("sucess");

			}	catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		public void makerSetNum(int makerNum) {
			String SQL = "INSERT INTO maker VALUES (?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setInt(1, makerNum);
				pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
}
