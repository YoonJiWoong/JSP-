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
			System.out.println("db접속 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("db접속 실패");
		}		
	}
	
	public String getDate() { // 날짜
		
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
		return ""; // 데이터 베이스 호출
		
	}
	
	public int getNext() { // 게시글 번호
		
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // 내림차순해서 가장 아래 번호 가져옴
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // 가장 마지막 게시글에 +1
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // 데이터 베이스 오류
		
	}

	public int write(String bbsTitle, String userID, String bbsContent) { // 게시글 번호
		
		System.out.println("bbs타이틀 : "+bbsTitle);
		System.out.println("bbs아이디 : "+userID);
		System.out.println("bbs컨텐츠 : "+bbsContent);
		
		
		String SQL = "insert into bbs values (?,?,?,?,?,?)"; // 내림차순해서 가장 아래 번호 가져옴
		try {
			PreparedStatement psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, getNext());
			psmt.setString(2, bbsTitle);
			psmt.setString(3, userID);
			psmt.setString(4, getDate());
			psmt.setString(5, bbsContent);
			psmt.setInt(6, 1); // available 처음에 글 삭제 안했으니 1
			return psmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1; // 데이터 베이스 오류
		
	}
	
	
	
	
	
	
	

}
