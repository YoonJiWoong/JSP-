package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
			
		} catch (Exception e) {
			e.printStackTrace();
			
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
	
	public ArrayList<bbs> getlist(int pageNumber) {
		
		
		String SQL = "SELECT * FROM BBS WHERE bbsAvailabe = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?"; // �����ȵ�(bbsAvailable = 1)�� 10������..
		
		
		
		ArrayList<bbs> list = new ArrayList<bbs>();
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, (pageNumber -1) * 10);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	
		return list; 
		
	}
	
	
	public boolean nextPage(int pageNumber) {
		

		
		
		String SQL = "SELECT * FROM BBS WHERE bbsAvailabe = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";
		ArrayList<bbs> list = new ArrayList<bbs>();
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, (pageNumber -1) * 10);
			rs = psmt.executeQuery();
			if(rs.next()) {
				
				return true;
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	
		
		
	}
	
	public bbs getbbs(int bbsID) {
		
		
		
		String SQL = "SELECT * FROM BBS WHERE bbsID=?";
		
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, bbsID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
				
				
				
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;

	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		
		String SQL = "update bbs SET bbsTitle=?, bbsContent=? WHERE bbsID=? "; // ���������ؼ� ���� �Ʒ� ��ȣ ������
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setString(1, bbsTitle);
			psmt.setString(2, bbsContent);
			psmt.setInt(3, bbsID);			
			return psmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // ������ ���̽� ����	
	}
	
	public int delete(int bbsID) {
		
		
		String SQL = "update bbs SET bbsAvailabe=0 WHERE bbsID=? "; // ���������ؼ� ���� �Ʒ� ��ȣ ������
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, bbsID);
					
			return psmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // ������ ���̽� ����	
	}
		
	}
	
	


