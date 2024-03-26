package com.msa2024.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msa2024.member.vo.MmemberVO1;

/**
 * Servlet implementation class MmemberController
 */
@WebServlet("/MmemberController")
public class MmemberController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//xml 또는 어노터이션 처리하면 스프링 
  	//어노터이션 처리하면 스프링 부트 
	MmemberService1 memberService = new MmemberService1();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MmemberController1() {
        super();
        // TODO Auto-generated constructor stub
    }

  	public Object list(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("목록");
  		
  		//1. 처리
  		List<MmemberVO1> list = memberService.list(member);
  		
  		//2. jsp출력할 값 설정
  		request.setAttribute("list", list);
  		
  		return "list";
  	}
  	
  	public Object view(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("상세보기");
  		//String userid = request.getParameter("userid");
  		//1. 처리
  		//2. jsp출력할 값 설정
  		request.setAttribute("user", memberService.view(member));
  		return "view";
  	}
  	
  	public Object delete(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("삭제");
  		//1. 처리
  		int updated = memberService.delete(member);
  		
  		Map<String, Object> map = new HashMap<>();
  		
  		if (updated == 1) { //성공
  			map.put("status", 0);
  		} else {
  			map.put("status", -99);
  			map.put("statusMessage", "회원 정보 삭제 실패하였습니다");
  		}
  		return map;
  	}
  	
  	public Object updateForm(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("수정화면");
  		//1. 처리
  		//usersDAO.read(user);
  		
  		//2. jsp출력할 값 설정
  		request.setAttribute("user", memberService.updateForm(member));
  		
  		return "updateForm"; 
  	}
  	
  	public Object update(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("수정");
  		
  		//1. 처리
  		int updated = memberService.update(member);
  		
  		Map<String, Object> map = new HashMap<>();
  		
  		if (updated == 1) { //성공
  			map.put("status", 0);
  		} else {
  			map.put("status", -99);
  			map.put("statusMessage", "회원정보 수정에 실패하였습니다");
  		}
  		return map;
  	}
  	
  	public Object insertForm(HttpServletRequest request) throws ServletException, IOException {
  		System.out.println("등록화면");
  		//1. 처리
  		
  		//2. jsp출력할 값 설정
  		return "insertForm";
  	}
  	
  	public Object insert(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("등록");
  		Map<String, Object> map = new HashMap<>();
  		
  		if (member.getMid() == null  || member.getMid().length() == 0) {
  			map.put("status", -1);
  			map.put("statusMessage", "사용자 아이디는 null 이거나 길이가 0인 문자열을 사용할 수 없습니다");
  		} else {
  			//1. 처리
  			int updated = memberService.insert(member);
  			
  			if (updated == 1) { //성공
  				map.put("status", 0);
  			} else {
  				map.put("status", -99);
  				map.put("statusMessage", "회원 가입이 실패하였습니다");
  			}
  		}
  		
  		return map;
  	}

  	public Object existUserId(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		//1. 처리
  		System.out.println("existUserId userid->" + member.getMid());
  		MmemberVO1 existMember = memberService.view(member);
  		Map<String, Object> map = new HashMap<>();
  		System.out.println(existMember);
  		
  		if (existMember == null) { //사용가능한 아이디
  			map.put("existUser", false);
  		} else { //사용 불가능 아아디 
  			map.put("existUser", true);
  		}
  		return map;
  	}

  	public Object loginForm(HttpServletRequest request) {
  		return "loginForm";
  	}

  	public Object login(HttpServletRequest request, MmemberVO1 member, HttpServletResponse response) throws ServletException, IOException {
  		MmemberVO1 loginVO = memberService.view(member);
  		
  		if (member.isEqualPassword(loginVO)) {
  			//로그인 사용자의 정보를 세션에 기록한다.
  			HttpSession session = request.getSession();
  			System.out.println("login nsession id = " + session.getId());
  			session.setAttribute("loginVO", loginVO);
  			session.setMaxInactiveInterval(30*60*1000);
  			
  			if ("Y".equals(member.getAutologin())) {
  				//1. UUID를 생성하여 사용자 테이블의 uuid를 변경한다.
  				String uuid = UUID.randomUUID().toString();
  				member.setMuuid(uuid);
  				
  				memberService.updateUUID(member);
  				
  				//2. uuid값을 쿠키에 기록한다.
  				Cookie uuidCookie = new Cookie("uuidCookie", uuid);
  				uuidCookie.setMaxAge(24*60*60); //24시간
  				uuidCookie.setPath("/");
  				
  				response.addCookie(uuidCookie);
  			}
  			
  		} else {
  			return "redirect:members1?action=loginForm&err=invalidUserId";
  		}
  		return "redirect:boards1?action=list";
  	}
  	
  	public Object logout(HttpServletRequest request) {
  		Map<String, Object> map = new HashMap<>();
  		
  		//로그인 사용자의 정보를 세션에 제거한다
  		HttpSession session = request.getSession();
  		
  		//세션에서 로그인 정보를 얻는다
  		MmemberVO1 loginVO = (MmemberVO1) session.getAttribute("loginVO");
  		//로그아웃시 uuid값을 제거한다 
  		loginVO.setMuuid("");
  		memberService.updateUUID(loginVO);
  		
  		System.out.println("logout session id = " + session.getId());
  		session.removeAttribute("loginVO"); //특정 이름을 제거한다
  		session.invalidate(); //세션에 저장된 모든 자료를 삭제한다 
  		
  		return map;
  	}
  	
  	public Object mypage(HttpServletRequest request, MmemberVO1 member) throws ServletException, IOException {
  		System.out.println("상세보기");
  		
  		return "mypage";
  	}

}
