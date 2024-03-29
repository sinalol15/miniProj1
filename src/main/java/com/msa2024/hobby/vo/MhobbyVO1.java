package com.msa2024.hobby.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MhobbyVO1 {
	private String hnumber;
	private String hname;
	private String checked;
}