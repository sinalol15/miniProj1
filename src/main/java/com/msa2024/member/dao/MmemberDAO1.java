package com.msa2024.member.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.msa2024.member.vo.MmemberVO1;

public class MmemberDAO1 {
	// 1. 회원가입 목록 만들기
    // 2. 삭제 구현
    // 3. 수정 구현
    // 4. 상세보기 구현
    // 5. 전체삭제 구현
    // 6. 등록 구현
    private static Connection conn = null;
    private static PreparedStatement memberListPstmt = null;
    private static PreparedStatement memberListPstmt2 = null;
    private static PreparedStatement memberInsertPstmt = null;
    private static PreparedStatement memberInsertPstmt2 = null;
    private static PreparedStatement memberDeletePstmt = null;
    private static PreparedStatement memberDetailPstmt = null;
    private static PreparedStatement memberFromUUIDPstmt = null; //uuid를 이용하여 사용자 정보를 얻는다.
    private static PreparedStatement memberUpdateUUIDPstmt = null; //userid 이용하여 uuid를 변경한다.

    private static PreparedStatement memberUpdatePstmt = null;
    private static PreparedStatement memberDeleteAllPstmt = null;

    private static PreparedStatement memberValidationIdPstmt = null;
    private static PreparedStatement memberValidationPasswordPstmt = null;

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

            memberListPstmt = conn.prepareStatement("select * from tb_member order by mid");
            memberListPstmt2 = conn.prepareStatement("select * from tb_member where mname like ? order by mid");
            memberInsertPstmt = conn.prepareStatement("insert into tb_member (mid, mname, mpassword, mage, memail) values (?, ?, ?, ?, ?)");
            memberInsertPstmt2 = conn.prepareStatement("insert into tb_mhabbit (mhid, mhnumber) values (?, ?)");
            memberDetailPstmt = conn.prepareStatement("select * from tb_member where mid=?");
            
            memberFromUUIDPstmt = conn.prepareStatement("select * from tb_member where muuid=?");
            memberUpdateUUIDPstmt = conn.prepareStatement("update tb_member set muuid=? where mid=?");
            
            memberValidationIdPstmt = conn.prepareStatement("select mid from tb_member where mid=?");
            memberValidationPasswordPstmt  = conn.prepareStatement("select mpassword from tb_member where mpassword=? ");
            //delete 가 되지 않았던 이유: ? 개수에 맞춰서 setString() 을 해주어야 한다.
            memberDeletePstmt = conn.prepareStatement("delete from tb_member where userid=?");
            memberDeleteAllPstmt = conn.prepareStatement("delete from tb_member");
            memberUpdatePstmt = conn.prepareStatement("update tb_member set mname=?, mpassword=?,mage=?, memail=? where mid=?");
            // 5. 결과 처리
            // 6. 연결 해제
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    public List<MmemberVO1> list(MmemberVO1 member) {
        List<MmemberVO1> list = new ArrayList<>();
        try {
        	ResultSet rs = null;
        	if (member != null && !member.isEmptySearchKey()) {
        		//검색 키워드 설정 
        		memberListPstmt2.setString(1, "%" + member.getSearchKey() + "%");
        		rs = memberListPstmt2.executeQuery();
        	} else {
                rs = memberListPstmt.executeQuery();
        	}
            while (rs.next()) {
            	MmemberVO1 members = new MmemberVO1(rs.getString("mid")
                        , rs.getString("mpassword")
                        , rs.getString("mname")
                        , rs.getInt("mage")
                        , rs.getString("memail"));
                
                list.add(members);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int insert(MmemberVO1 members){
        int updated = 0;
        try{
            memberInsertPstmt.setString(1, members.getMid());
            memberInsertPstmt.setString(2, members.getMname());
            memberInsertPstmt.setString(3, members.getMpassword());
            memberInsertPstmt.setInt(4, members.getMage());
            memberInsertPstmt.setString(5, members.getMemail());
            updated = memberInsertPstmt.executeUpdate();
            
            if (members.getMhabbit1() != null) {
	            memberInsertPstmt2.setString(1, members.getMid());
	            memberInsertPstmt2.setString(2, members.getMhabbit1());
	            memberInsertPstmt2.executeUpdate();
            }
            if (members.getMhabbit2() != null) {
	            memberInsertPstmt2.setString(1, members.getMid());
	            memberInsertPstmt2.setString(2, members.getMhabbit2());
	            memberInsertPstmt2.executeUpdate();
            }
            if (members.getMhabbit3() != null) {
	            memberInsertPstmt2.setString(1, members.getMid());
	            memberInsertPstmt2.setString(2, members.getMhabbit3());
	            memberInsertPstmt2.executeUpdate();
            }
            
            conn.commit();
        }catch (Exception e){
            e.printStackTrace();
        }
        return updated;
    }
    public MmemberVO1 read(MmemberVO1 member) {

    	MmemberVO1 members = null;
        try {
            memberDetailPstmt.setString(1, member.getMid());

            ResultSet rs = memberDetailPstmt.executeQuery();
            if (rs.next()) {
            	members = new MmemberVO1(rs.getString("mid")
                        , rs.getString("mpassword")
                        , rs.getString("mname")
                        , rs.getInt("mage")
                        , rs.getString("memail"));
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return members;
    }

    public int update(MmemberVO1 members) {
        int updated = 0;
        try {
        	memberUpdatePstmt.setString(1, members.getMname());
        	memberUpdatePstmt.setString(2, members.getMpassword());
        	memberUpdatePstmt.setInt(3, members.getMage());
        	memberUpdatePstmt.setString(4, members.getMemail());
        	memberUpdatePstmt.setString(5, members.getMid());
            updated = memberUpdatePstmt.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;

    }

    public int delete(MmemberVO1 member) {
        int updated = 0;

        try {
        	memberDeletePstmt.setString(1, member.getMid());
            updated = memberDeletePstmt.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }

    public int clear() {
        int updated = 0;
        try {
            updated = memberDeleteAllPstmt.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }

    public boolean validationId(String memberid){
        boolean result = false;
        try {
        	memberValidationIdPstmt.setString(1, memberid);
            ResultSet rs = memberValidationIdPstmt.executeQuery();
            if (rs.next()) {
                result = true;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
    }
        return result;
    }

    public boolean validationPassword(String memberpassword){
        boolean result = false;
        try {
        	memberValidationPasswordPstmt.setString(1, memberpassword);
            ResultSet rs = memberValidationPasswordPstmt.executeQuery();
            if (rs.next()) {
                result = true;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public int updateUUID(MmemberVO1 members) {
    	int updated = 0;
    	try {
    		memberUpdateUUIDPstmt.setString(1, members.getMuuid());
    		memberUpdateUUIDPstmt.setString(2, members.getMid());
    		updated = memberUpdateUUIDPstmt.executeUpdate();
    		conn.commit();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return updated;
    }
    
    public MmemberVO1 getUserVOFromUUID(MmemberVO1 member) {
    	MmemberVO1 members = null;
    	try {
    		memberFromUUIDPstmt.setString(1, member.getMuuid());;
    		
    		ResultSet rs = memberFromUUIDPstmt.executeQuery();
    		if (rs.next()) {
    			members = MmemberVO1.builder()
                		.mid(rs.getString("mid"))
                		.mpassword(rs.getString("mpassword"))
                		.mname(rs.getString("mname"))
                		.mage(rs.getInt("mage"))
                		.memail(rs.getString("mmail"))
                		.muuid(rs.getString("muuid"))
                		.build();
    		}
    		rs.close();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return members;
    }
}
