package com.team404.command;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class ReplyVO {
	
	private int rno;
	private int bno;
	
	private String reply;
	private String replyId;
	private String replyPw;
	private Timestamp replyDate;
	private Timestamp updateDate;
}
