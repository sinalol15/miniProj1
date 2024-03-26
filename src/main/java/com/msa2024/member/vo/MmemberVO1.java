package com.msa2024.member.vo;

import com.msa2024.member.vo.MmemberVO1;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MmemberVO1 {
	private String mid;
	private String mpassword;
	private String mname;
	private String mhabbit1=null;
	private String mhabbit2=null;
	private String mhabbit3=null;
	private int    mage;
	private String memail;
	
	private String mpassword2;
	private String err;
	//실행 명령 필드 
	private String action;

	//검색키
	private String searchKey;
	
	//uuid
	private String muuid;
	
	//자동로그인 여부
	private String autologin;
	
	public MmemberVO1(String mid, String mpassword, String mname, int mage, String memail) {
		super();
		this.mid = mid;
		this.mpassword = mpassword;
		this.mname = mname;
		this.mage = mage;
		this.memail = memail;
	}

	public boolean isEmptySearchKey() {
		return searchKey == null || searchKey.length() == 0; 
	}
	
	public boolean isEqualPassword(MmemberVO1 memberVO) {
		return memberVO != null && mpassword.equals(memberVO.getMpassword()); 

	}
}
