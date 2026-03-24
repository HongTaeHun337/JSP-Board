/* 스터디참여 */
DROP TABLE tbl_Study_Join
	CASCADE CONSTRAINTS;

create sequence seq_study_join;

alter sequence seq_study_join restart start with 1;

drop sequence seq_study_join;

/* 스터디참여 */
CREATE TABLE tbl_Study_Join (
	seq_study_join NUMBER NOT NULL, /* 참여번호 */
	seq_study NUMBER NOT NULL, /* 스터디번호 */
	seq_user NUMBER NOT NULL, /* 회원번호 */
	regdate DATE, /* 가입일 */
	status NUMBER DEFAULT 0 NOT NULL, /* 참여상태 (0/1 : 미참여/참여) */
	authority NUMBER DEFAULT 0 NOT NULL, /* 역할구분 (0/1 : 일반회원/스터디장) */

    CONSTRAINT PK_tbl_Study_Join PRIMARY KEY (seq_study_join),
    CONSTRAINT FK_tbl_Study_TO_tbl_Study_Join FOREIGN KEY (seq_study)
		REFERENCES tbl_Study (seq_study),
    CONSTRAINT FK_tbl_User_TO_tbl_Study_Join FOREIGN KEY (seq_user)
		REFERENCES tbl_User (seq_user)
);

/* 참여상태 유효값 확인 */
ALTER TABLE tbl_Study_Join
ADD CONSTRAINT CK_tbl_Study_Join_status
CHECK (status IN (0, 1));

/* 역할구분 유효값 확인 */
ALTER TABLE tbl_Study_Join
ADD CONSTRAINT CK_tbl_Study_Join_authority
CHECK (status IN (0, 1));

commit;

select * from tbl_Study_Join;

delete tbl_Study_Join where seq_study_join = 2;

insert into tbl_Study_Join values (seq_study_join.nextVal, 1, 1, null,0, 0);

