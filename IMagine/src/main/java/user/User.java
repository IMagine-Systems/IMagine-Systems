package user;
// 1명 회원데이터를 다룰수있는 데이터베이스 자바빈즈라고 한다. 
// 하나의 데이터를 관리하고 처리할수있는 기법을 jsp에서 구하는것 을 자바빈즈라고 한다.

public class User {
	private String userID;
	private String userPassword;
	private String userGender;
	private String userEmail;
	private String userName;
	private String userAuth;

	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserAuth() {
		return userAuth;
	}
	public void setUserAuth(String userAuth) {
		this.userAuth = userAuth;
	}
	 
}
