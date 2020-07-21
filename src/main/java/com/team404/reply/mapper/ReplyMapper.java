package com.team404.reply.mapper;

import java.util.ArrayList;

import com.team404.command.ReplyVO;

public interface ReplyMapper {

	public int replyRegist(ReplyVO vo); //댓글등록
	public ArrayList<ReplyVO> getList(int bno);
	public int confirm(int rno, String replyPw); //댓글 비밀번호확인
	public int update(int rno, String modalReply);
}
