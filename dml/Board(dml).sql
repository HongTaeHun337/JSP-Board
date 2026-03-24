-- 게시판

insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '전체');       --1 = 전체
insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '자유게시판');    --2 = 자유게시판
insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '질문게시판');    --3 = 질문게시판
insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '경험공유');     --4 = 경험공유
insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '자료실');      --5 = 자료실
insert into TBL_BOARD (seq_board, name) values (SEQ_BOARD.nextVal, '스터디모집');    --6 = 스터디모집

-- 테이블 데이터 삭제
delete
from TBL_BOARD
where SEQ_BOARD between 1 and 15;

-- 시퀀스 1부터 다시 시작
ALTER SEQUENCE seq_board RESTART START WITH 1;

-- 확인
select * from TBL_BOARD;

--저장
commit ;






