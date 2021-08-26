package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// DAO는 데이터베이스 객체 접근 약자이다.
// 데이터베이스에서 회원정보를 불러오거나 데이터베이스에 회원정보를 넣고자 한다.
public class UserDAO {
	private Connection conn; // 데이터베이스에 접근해주는 객체이다.
	private PreparedStatement pstmt;
	private ResultSet rs; // 어떠한 정보를 담을수있는 곳.
	
	public UserDAO() { // 자동으로 데이터베이스 연결
//		try {
//			String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
//			String dbID = "root"; 
//			String dbPassword = "a@1096a@1096";
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//			System.out.println("sucess");
//		} catch (Exception e) {
//			e.printStackTrace(); // error 출력
//		}
		try {

            String dbUrl = "jdbc:mariadb://localhost:3308/flows";
            String dbId = "flows";
            String dbPw = "1234";
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbId, dbPw);
            System.out.println("sucess");

        }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // 가장 중요한부분 접속 시도하고자 아이디 존재하는지 할수있다.
	
			rs = pstmt.executeQuery(); // 실행한 결과를 넣어준다. 
			
			if (rs.next()) { // 결과가 존재하면 실행
				if (rs.getString(1).equals(userPassword)) { // 결과가 나온 userPassword 받아서 userPassword 비교
					return 1; // 로그인 성공. 
				}
				else 
					return 0; // 비밀번호 불일치.
			}
			return -1; // 아이디가 없음. 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	public int auth(String userID) {
		String SQL = "SELECT userAuth FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("userAuth").equals("guest")) {
					return 1; // guest
				}
				else {
					return 0; // admin
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserName());
			pstmt.setString(6, user.getUserAuth());
			return pstmt.executeUpdate();
		} catch (Exception e){
			e.printStackTrace();
		}
		
		return -1; // 데이터베이스 오류
	}
}
