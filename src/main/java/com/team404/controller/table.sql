--글
create table freeboard(
    bno number(10, 0),
    title varchar2(300) not null,
    writer varchar2(50) not null,
    content varchar2(2000) not null,
    regdate date default sysdate, --����ð�
    updatedate date default sysdate
);
alter table freeboard add CONSTRAINT freeboard_pk PRIMARY KEY (bno);
create SEQUENCE freeboard_seq INCREMENT by 1 start with 1 nocache;

--댓글
create table FREEREPLY(

    rno number(10, 0), --댓글번호(PK)
    bno number(10, 0), --글번호(FK)
    reply varchar2(1000), -- 내용
    replyId varchar2(50), -- 글쓴이
    replyPw varchar2(50), -- 비밀번호
    replyDate date default sysdate, --등록일
    updateDate date default sysdate --수정일

);
create SEQUENCE freereply_seq INCREMENT by 1 start with 1 nocache;
alter table freereply add CONSTRAINT freereply_pk PRIMARY KEY (rno);