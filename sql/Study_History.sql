/* 스터디활동기록 */
DROP TABLE tbl_Study_History
	CASCADE CONSTRAINTS;

create sequence seq_study_history;

/* 스터디활동기록 */
CREATE TABLE tbl_Study_History (
	seq_study_history NUMBER NOT NULL, /* 활동기록번호 */
	seq_study NUMBER NOT NULL, /* 스터디번호 */
	seq_user NUMBER NOT NULL, /* 회원번호(작성자) */
	seq_study_day NUMBER NOT NULL, /* 일정번호 */
	detail VARCHAR2(2000), /* 활동내용 */
	regdate DATE DEFAULT sysdate NOT NULL, /* 작성일 */

    CONSTRAINT PK_tbl_Study_History PRIMARY KEY (seq_study_history),
    CONSTRAINT FK_tbl_Study_TO_tbl_Study_History FOREIGN KEY (seq_study)
		REFERENCES tbl_Study (seq_study),
    CONSTRAINT FK_tbl_User_TO_tbl_Study_History FOREIGN KEY (seq_user)
		REFERENCES tbl_User (seq_user),
    CONSTRAINT FK_tbl_Study_day_TO_tbl_Study_History FOREIGN KEY (seq_study_day)
		REFERENCES tbl_Study_day (seq_study_day)
);




