package com.team404.command;

import java.sql.Timestamp;
import lombok.Data;

@Data //게터, 세터 자동생성
public class FreeBoardVO {

	private int bno;
	private String title;
	private String writer;
	private String content;
	private Timestamp regdate;
	private Timestamp updatedate;
}
