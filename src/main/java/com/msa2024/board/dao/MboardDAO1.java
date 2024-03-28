package com.msa2024.board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msa2024.board.vo.MboardVO1;
import com.msa2024.member.vo.MmemberVO1;

public class MboardDAO1 {
	private static Connection conn = null;
    private static PreparedStatement boardListPstmt = null;
    private static PreparedStatement boardListPstmt2 = null;
    private static PreparedStatement boardInsertPstmt = null;
    private static PreparedStatement boardDeletePstmt = null;
    private static PreparedStatement boardDetailPstmt = null;

    private static PreparedStatement boardUpdatePstmt = null;
    private static PreparedStatement boardUpdateviewcountPstmt = null;
    private static PreparedStatement boardDeleteAllPstmt = null;

    static {

        try {
            // 1. JDBC 드라이버 로딩
            Class.forName("oracle.jdbc.OracleDriver");
            // 2. DB 연결
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521/xe",
                    "bituser", //계정이름
                    "1004" //계정비밀번호
            );
            // 3. SQL 실행 객체 준비
            // 4. SQL 실행
            System.out.println("연결 성공");
            conn.setAutoCommit(false);

            boardListPstmt = conn.prepareStatement("select B.*, M.mname tbwriter from TB_BOARD B inner join TB_MEMBER M on B.tmid = m.mid order by tbno");
            boardListPstmt2 = conn.prepareStatement("select B.*, M.mname tbwriter from TB_BOARD B inner join TB_MEMBER M on B.tmid = m.mid where tbtitle like ? order by tbno");
            boardInsertPstmt = conn.prepareStatement("insert into TB_BOARD (tbno, tbtitle, tbcontent, tmid) values (seq_bno.nextval, ?, ?, ?)");
            boardDetailPstmt = conn.prepareStatement("select B.*, M.mname tbwriter from TB_BOARD B inner join TB_MEMBER M on B.tmid = m.mid where tbno = ?");
            //delete 가 되지 않았던 이유: ? 개수에 맞춰서 setString() 을 해주어야 한다.
            boardDeletePstmt = conn.prepareStatement("delete from TB_BOARD where tbno = ?");
            boardDeleteAllPstmt = conn.prepareStatement("delete from TB_BOARD");
            boardUpdatePstmt = conn.prepareStatement("update TB_BOARD set tbtitle = ?, tbcontent = ? where tbno = ?");
            boardUpdateviewcountPstmt = conn.prepareStatement("UPDATE TB_BOARD SET tbviewcount = ? WHERE tbno = ?");
            // 5. 결과 처리
            // 6. 연결 해제
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    public List<MboardVO1> list(MboardVO1 board) {
        List<MboardVO1> list = new ArrayList<>();
        try {
        	ResultSet rs = null;
        	if (board != null && !board.isEmptySearchKey()) {
        		//검색 키워드 설정 
        		boardListPstmt2.setString(1, "%" + board.getSearchKey() + "%");
        		rs = boardListPstmt2.executeQuery();
        	} else {
                rs = boardListPstmt.executeQuery();
        	}
            while (rs.next()) {
            	MboardVO1 boards = new MboardVO1(rs.getInt("tbno")
                        , rs.getString("tbtitle")
                        , rs.getString("tbcontent")
                        , rs.getString("tbdate")
                        , rs.getString("tbwriter")
                        , rs.getInt("tbviewcount"));
                
                list.add(boards);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int insert(MboardVO1 board){
        int updated = 0;
        try{
            boardInsertPstmt.setString(1, board.getTbtitle());
            boardInsertPstmt.setString(2, board.getTbcontent());
            boardInsertPstmt.setString(3, board.getTmid());
            updated = boardInsertPstmt.executeUpdate();
            conn.commit();
        }catch (Exception e){
            e.printStackTrace();
        }
        return updated;
    }
    public MboardVO1 read(MboardVO1 boards) throws SQLException {

    	MboardVO1 board = null;
    	
        try {
            boardDetailPstmt.setInt(1, boards.getTbno());

            ResultSet rs = boardDetailPstmt.executeQuery();
            if (rs.next()) {
                board = new MboardVO1(rs.getInt("tbno")
                        , rs.getString("tbtitle")
                        , rs.getString("tbcontent")
                        , rs.getString("tbdate")
                        , rs.getString("tbwriter"));
                board.setTmid(rs.getString("tmid"));
                
                int viewCount = rs.getInt("tbviewcount");
                viewCount++;
                updateViewCount(board, viewCount);
                board.setViewcount(viewCount);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return board;
    }

    public int update(MboardVO1 board) {
        int updated = 0;
        try {
        	boardUpdatePstmt.setString(1, board.getTbtitle());
            boardUpdatePstmt.setString(2, board.getTbcontent());
            boardUpdatePstmt.setInt(3, board.getTbno());
            updated = boardUpdatePstmt.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;

    }

    public int delete(MboardVO1 board) {
        int updated = 0;

        try {
	        boardDeletePstmt.setInt(1, board.getTbno());
	        updated = boardDeletePstmt.executeUpdate();
	        conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }

    public int clear() {
        int updated = 0;
        try {
            updated = boardDeleteAllPstmt.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
    
    private int updateViewCount(MboardVO1 board, int viewcount) {
        // UPDATE 쿼리문 작성 
    	int updated = 0;
        try {
            // PreparedStatement에 파라미터 값 설정
        	boardUpdateviewcountPstmt.setInt(1, viewcount);
        	boardUpdateviewcountPstmt.setInt(2, board.getTbno());
            // 쿼리 실행
        	updated = boardUpdateviewcountPstmt.executeUpdate();
        	conn.commit();
        } catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }
        return updated;
    }
}
