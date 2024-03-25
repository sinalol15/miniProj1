package com.msa2024.board.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MboardVO1 {
	private int tbno;
	private String tbtitle;
	private String tbcontent;
	private String tbwriter;
	private String tbdate;
	
	//실행 명령 필드 
	private String action;
	
	//검색키
	private String searchKey;
	
	public boolean isEmptySearchKey() {
		return searchKey == null || searchKey.length() == 0; 
	}
	
	public MboardVO1(int tbno, String tbtitle, String tbcontent, String tbwriter, String tbdate) {
		super();
		this.tbno = tbno;
		this.tbtitle = tbtitle;
		this.tbcontent = tbcontent;
		this.tbwriter = tbwriter;
		this.tbdate = tbdate;
	}

	public MboardVO1(int tbno, String tbtitle, String tbcontent, String tbwriter) {
		super();
		this.tbno = tbno;
		this.tbtitle = tbtitle;
		this.tbcontent = tbcontent;
		this.tbwriter = tbwriter;
	}

	public MboardVO1(String tbtitle, String tbcontent, String tbwriter) {
		super();
		this.tbtitle = tbtitle;
		this.tbcontent = tbcontent;
		this.tbwriter = tbwriter;
	}
}
