package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	//Database ���� ��ü�� ����� conn�� �������ְ�,
	private Connection conn;
	// ������ ���� �� �ִ� ��ü ����
	private PreparedStatement pstmt;
	private ResultSet rs;

	//UserDAO�� �����ڷ� ����� �ְ�, �ڵ������� �����ͺ��̽� ������ �̷����� ���ִ� �ڵ带 §��.
	public UserDAO() {
		//���� ó���� �ϱ� ���ؼ� try&catch ���� ����.
		try {
			//dbURL�ȿ� localhost��� ���� ���� ��ǻ�Ϳ� ������ �ǹ��ϰ� 3306��Ʈ�� ����� BBSdb�� ������ �� �ְ� ���ش�.
			//���Ƕ� ��� ������ �ٸ����ؼ� �ڿ� �������� ����;
			String dbURL =  "jdbc:mysql://localhost:3306/epicus?serverTimezone=UTC";
			//db�� �����ϴ� ID�� ��� �κ�
			String dbID = "root";
			//db�� �����ϴ� PW�� ��� �κ�
			String dbPassword = "root";
			//mysql�� ������ �� �ִ� driver�� ã���� �ְ� ���ִ� �ڵ� driver��°� mysql�� ������ �� �ֵ��� �Ű�ü ������ ���ִ� ���̺귯���̴�.
			//���ǹ������� ���� ���� ������ ��� �Ἥ ����̹� �ּҰ� ���ٸ�
			Class.forName("com.mysql.cj.jdbc.Driver");
			//getConnection�Լ� ���ο� dbURL�� root root �� ������ �� �ְ� ���ִ� �����͸� �־� ������ �Ϸ�Ǹ� conn��ü�ȿ� ���ӵ� ������ ���� �ȴ�.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		
		} catch (Exception e) {
			//������ ������ ���� �ֿܼ� ���� ���� �Լ��̴�.
			e.printStackTrace();
		}
	}

	//�������� ������ mysql�� ������ �ϰ� ���ִ� �κ��̰�, ���� ������ �α����� �õ��ϴ� �ϳ��� �Լ� ���� userID,userPassword�� �Է� �޾Ƽ� �����Ѵ�.
	public int login(String userID, String userPwd) {
		//���� �Է¹��� userID �� PW�� ��ġ�ϴ��� Ȯ���� �ϱ����ؼ� db������ userID ���� ���� PW�� ��ȸ�ϴ� ������ �־��ش�. *1.��ŷ������ ���� �߰��� ?�� �־����
		String SQL = "SELECT userPwd FROM USER WHERE userID = ?";
		//try,catch������ ����ó���� ���ְ�
		try {
			//pstmt�� ��� ������ sql������ �����ͺ��̽��� �����ϴ� �������� �ν��Ͻ��� �����´�.
			pstmt = conn.prepareStatement(SQL); 
			//*2.���� �� userID = ? �� �ش��ϴ� �κп� �Է¹��� userID�� �־��ִ� ���̴�. �״ϱ� �ٷ� ���������� �尡�� ��ŷƴ ����ϱ� setString���� �ѹ� ��ġ����. 2��2��
			pstmt.setString(1, userID);
			//�̷��� db�� ���� ������ ������ ������. ������ ����� rs���ٰ� ����ش�.
			rs = pstmt.executeQuery();
			//���� ����� ���� ���ο� ���� �ൿ�� ��������ִ� �κ��� ����� ����, ���̵� �����Ҷ�
			if (rs.next()) {
				//���� rs�� ����ִ� ���� db������ userPW�� ��ġ�ϸ� login����
				if (rs.getString(1).equals(userPwd))
					//login ����
					return 1;
			 else 
				 //�ƴϸ� ��й�ȣ �� ��ġ �����Ѵ�. 
				return 0;
			}
			// ���̵� ������
			return -1;
		//�� ���� ���� �Ұ� ���ܴ� catch�� ����ش�.
		} catch (Exception e) {
			//�ش� ���� ���
			e.printStackTrace();
		}
		// �����ͺ��̽� ������ �ǹ�
		return -2;
	//�α��� �õ� �Լ� �ۼ� �� loginAction Page ����;
	}
	
	
	//db�� �Ѹ��� ����ڸ� �Է¹��� �� �ִ� ȸ������ �Լ� (User user) - UserŬ������ �̿��ؼ� ����� �����ִ� �ϳ��� �ν��Ͻ���.
	public int join(User user) {
		//SQL�ȿ� ��5���� ���� �������� �� �� �ִ� ������ �ۼ� �� �ش�.
		String SQL = "INSERT INTO USER VALUES (?,?, ?, ?)";
		try {
			//���� �ۼ��� SQL������ pstmt�� �ִ� ���
			pstmt = conn.prepareStatement(SQL);
			//���� �������� �� ������ ������ ����(index,��);
			//������ �Ű������� �Ѿ�� user������ getUserID()���ٰ� �־��شٴ� ���� ����;
			pstmt.setNString(1, user.getUserName());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPwd());
			pstmt.setString(4, user.getUserEmail());
			//���������� �ش� pstmt�� ������ ����� ��ȯ�� �ش�.
			return pstmt.executeUpdate();
		//insert������ ������ ��쿡�� �ݵ�� 0�̻��� ���ڰ� ��ȯ �Ǳ� ������ -1�� �ƴ� ��쿡�� �������� ȸ�������� �̷���� ���̴�.	
		}catch(Exception e) {
			e.printStackTrace();
		}
		//�����ͺ��̽� ���� �߻�
		return -1; 
	}
}

