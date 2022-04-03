package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class bbsDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public bbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("db���� ����");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("db���� ����");
		}		
	}
	
	public String getDate() { // ��¥
		
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return ""; // ������ ���̽� ȣ��
		
	}
	
	public int getNext() { // �Խñ� ��ȣ
		
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ���������ؼ� ���� �Ʒ� ��ȣ ������
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // ���� ������ �Խñۿ� +1
			}
			return 1; // ù ��° �Խù��� ���
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // ������ ���̽� ����
		
	}

	public int write(String bbsTitle, String userID, String bbsContent) { // �Խñ� ��ȣ
		
		System.out.println("bbsŸ��Ʋ : "+bbsTitle);
		System.out.println("bbs���̵� : "+userID);
		System.out.println("bbs������ : "+bbsContent);
		
		
		String SQL = "insert into bbs values (?,?,?,?,?,?)"; // ���������ؼ� ���� �Ʒ� ��ȣ ������
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, getNext());
			psmt.setString(2, bbsTitle);
			psmt.setString(3, userID);
			psmt.setString(4, getDate());
			psmt.setString(5, bbsContent);
			psmt.setInt(6, 1); // available ó���� �� ���� �������� 1
			return psmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // ������ ���̽� ����
		
	}
	
	
	
	
	
	
	

}
