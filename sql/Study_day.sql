/* 스터디일정 */
DROP TABLE tbl_Study_day
	CASCADE CONSTRAINTS;

create sequence seq_study_day;

drop sequence seq_study_day;

/* 스터디일정 */
CREATE TABLE tbl_Study_day (
	seq_study_day NUMBER NOT NULL, /* 일정번호 */
	seq_study NUMBER NOT NULL, /* 스터디번호 */
	title VARCHAR2(100) NOT NULL, /* 일정제목 */
	startperiod DATE NOT NULL, /* 일정시작날짜 */
    endperiod DATE NOT NULL, /* 일정종료날짜 */
	topic VARCHAR2(1000) NOT NULL, /* 학습주제 */
	detail VARCHAR2(2000), /* 일정설명 */
	regdate DATE DEFAULT sysdate NOT NULL, /* 생성일 */
	fixdate DATE, /* 수정일 */

    CONSTRAINT PK_tbl_Study_day PRIMARY KEY (seq_study_day),
    CONSTRAINT FK_tbl_Study_TO_tbl_Study_day FOREIGN KEY (seq_study)
		REFERENCES tbl_Study (seq_study)
);

select * from tbl_Study_day;

commit;

insert into tbl_Study_day values (seq_study_day.nextVal, 1, '테스트일정','2026-03-23', '2026-03-31',
                                 '테스트', '테스트', sysdate, null);


