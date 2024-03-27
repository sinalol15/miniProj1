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
	private String tbdate;
	private String tmid;
	private String mname;
	private int viewcount;

	//실행 명령 필드 
	private String action;
	
	//검색키
	private String searchKey;
	
	public boolean isEmptySearchKey() {
		return searchKey == null || searchKey.length() == 0; 
	}

	public MboardVO1(int tbno, String tbtitle, String tbcontent, String tbdate, String mname) {
		super();
		this.tbno = tbno;
		this.tbtitle = tbtitle;
		this.tbcontent = tbcontent;
		this.tbdate = tbdate;
		this.mname = mname;
	}

	public MboardVO1(int tbno, String tbtitle, String tbcontent, String tbdate, String mname, int viewcount) {
		super();
		this.tbno = tbno;
		this.tbtitle = tbtitle;
		this.tbcontent = tbcontent;
		this.tbdate = tbdate;
		this.mname = mname;
		this.viewcount = viewcount;
	}
}
