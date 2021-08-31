package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// DAO�� �����ͺ��̽� ��ü ���� �����̴�.
// �����ͺ��̽����� ȸ�������� �ҷ����ų� �����ͺ��̽��� ȸ�������� �ְ��� �Ѵ�.
public class UserDAO {
	private Connection conn; // �����ͺ��̽��� �������ִ� ��ü�̴�.
	private PreparedStatement pstmt;
	private ResultSet rs; // ��� ������ �������ִ� ��.
	
	public UserDAO() { // �ڵ����� �����ͺ��̽� ����
		try {

            String dbUrl = "jdbc:mariadb://localhost:3306/flows";
            String dbId = "youn";
            String dbPw = "0924";
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbId, dbPw);
            System.out.println("sucess");

        }catch (Exception e) {
            // TODO: handle exception
            System.out.println("�����ͺ��̽��� ���� �� �� �����ϴ�.");
            e.printStackTrace();
        }
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userpassword FROM user WHERE userid = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // ���� �߿��Ѻκ� ���� �õ��ϰ��� ���̵� �����ϴ��� �Ҽ��ִ�.
	
			rs = pstmt.executeQuery(); // ������ ����� �־��ش�. 
			
			if (rs.next()) { // ����� �����ϸ� ����
				if (rs.getString(1).equals(userPassword)) { // ����� ���� userPassword �޾Ƽ� userPassword ��
					return 1; // �α��� ����. 
				}
				else 
					return 0; // ��й�ȣ ����ġ.
			}
			return -1; // ���̵� ����. 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	public int auth(String userID) {
		String SQL = "SELECT userauth FROM user WHERE userid = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("user_auth").equals("guest")) {
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
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?)";
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
		
		return -1; // �����ͺ��̽� ����
	}
}
