package com.msa2024.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msa2024.member.dao.MmemberDAO1;
import com.msa2024.member.vo.MmemberVO1;

/**
 * Servlet implementation class MmemberService
 */
@WebServlet("/MmemberService")
public class MmemberService1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MmemberDAO1 memberDAO = new MmemberDAO1();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MmemberService1() {
        super();
        // TODO Auto-generated constructor stub
    }
    public List<MmemberVO1> list(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.list(member);
	}
	
	public MmemberVO1 view(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.read(member);
	}
	
	public int delete(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.delete(member);
	}
	
	public MmemberVO1 updateForm(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.read(member);
	}
	
	public int update(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.update(member);
	}
	
	public int insert(MmemberVO1 member) throws ServletException, IOException {
		return memberDAO.insert(member);
	}
	
	public void updateUUID(MmemberVO1 member) {
		memberDAO.updateUUID(member);
	}

}
