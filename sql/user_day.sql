/* 일정참여 */
DROP TABLE tbl_User_Day
	CASCADE CONSTRAINTS;

create sequence seq_user_day;

/* 일정참여 */
CREATE TABLE tbl_User_Day (
	seq_user_day NUMBER NOT NULL, /* 일정참여번호 */
	seq_user NUMBER, /* 회원번호 */
	seq_study_day NUMBER, /* 일정번호 */

    CONSTRAINT PK_tbl_User_Day PRIMARY KEY (seq_user_day),
    CONSTRAINT FK_tbl_Study_day_TO_tbl_User_Day FOREIGN KEY (seq_study_day)
		REFERENCES tbl_Study_day (seq_study_day),
    CONSTRAINT FK_tbl_User_TO_tbl_User_Day FOREIGN KEY (seq_user)
		REFERENCES tbl_User (seq_user)
);
