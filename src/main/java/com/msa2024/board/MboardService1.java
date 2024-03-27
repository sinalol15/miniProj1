package com.msa2024.board;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import com.msa2024.board.dao.MboardDAO1;
import com.msa2024.board.vo.MboardVO1;

/**
 * Servlet implementation class boardService
 */
@WebServlet("/boardService")
public class MboardService1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	MboardDAO1 boardsDAO = new MboardDAO1();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MboardService1() {
        super();
        // TODO Auto-generated constructor stub
    }

    public List<MboardVO1> list(MboardVO1 board) throws ServletException, IOException {
		return boardsDAO.list(board);
	}
	
	public MboardVO1 view(MboardVO1 board) throws ServletException, IOException, SQLException {
		return boardsDAO.read(board);
	}
	
	public int delete(MboardVO1 board) throws ServletException, IOException {
		return boardsDAO.delete(board);
	}
	
	public MboardVO1 updateForm(MboardVO1 board) throws ServletException, IOException, SQLException {
		return boardsDAO.read(board);
	}
	
	public int update(MboardVO1 board) throws ServletException, IOException {
		return boardsDAO.update(board);
	}
	
	public int insert(MboardVO1 board) throws ServletException, IOException {
		return boardsDAO.insert(board);
	}

}
