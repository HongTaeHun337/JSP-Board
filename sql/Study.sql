/* 스터디 */
DROP TABLE tbl_Study
	CASCADE CONSTRAINTS;

create sequence seq_study;

alter sequence seq_study restart start with 2;

drop sequence seq_study;

/* 스터디 */
CREATE TABLE tbl_Study (
	seq_study NUMBER NOT NULL, /* 스터디번호 */
	seq_user NUMBER NOT NULL, /* 회원번호(스터디장) */
	title VARCHAR2(100) NOT NULL, /* 스터디명 */
	introduce VARCHAR2(2000), /* 스터디소개 */
	max_population NUMBER NOT NULL, /* 최대인원 */
	population NUMBER DEFAULT 0 NOT NULL, /* 모집상태 (0/1 : 모집중/모집완료) */
	regdate DATE DEFAULT SYSDATE NOT NULL, /* 생성일 */
	fixdate DATE, /* 수정일 */
	status NUMBER DEFAULT 0 NOT NULL, /* 종료 여부 (0/1 : 진행/종료) */
	location VARCHAR2(1000), /* 모임장소 */
	isonline NUMBER DEFAULT 0 NOT NULL, /* 온/오프라인 (0/1 : 온라인/오프라인) */

	CONSTRAINT PK_tbl_Study PRIMARY KEY (seq_study),
	CONSTRAINT FK_tbl_User_TO_tbl_Study FOREIGN KEY (seq_user)
		REFERENCES tbl_User (seq_user)
);

/* 모집상태 유효값 확인 */
ALTER TABLE tbl_Study
ADD CONSTRAINT CK_tbl_Study_population
CHECK (population IN (0, 1));

/* 종료여부 유효값 확인 */
ALTER TABLE tbl_Study
ADD CONSTRAINT CK_tbl_Study_status
CHECK (status IN (0, 1));

/* 온/오프라인 유효값 확인 */
ALTER TABLE tbl_Study
ADD CONSTRAINT CK_tbl_Study_isonline
CHECK (isonline IN (0, 1));

/* 스터디명 중복방지 */
ALTER TABLE tbl_Study
ADD CONSTRAINT UQ_tbl_Study_title UNIQUE (title);

select * from tbl_Study;

DELETE FROM tbl_Study
WHERE seq_study BETWEEN 21 AND 39;

insert into tbl_Study values (seq_study.nextVal, 1, '테스트스터디', '테스트입니다.', 30, 0,
                         sysdate, default, 0, '테스트장소', 0);

commit;

INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 9, 'Docker 스터디 37기', 'Docker 스터디 37기 프로젝트 중심으로 진행됩니다.', 15, 0, sysdate - 85, NULL, 0, '판교 테크노밸리', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 41, 'Node.js 그룹 3기', 'Node.js 그룹 3기 같이 성장하실 분들을 찾습니다.', 15, 0, sysdate - 87, NULL, 1, '판교 테크노밸리', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 93, 'Java 모임 32기', 'Java 모임 32기 실력 향상을 목표로 합니다.', 20, 1, sysdate - 78, NULL, 1, '종로 공유오피스', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 54, 'SQL 스터디 모집 18기', 'SQL 스터디 모집 18기 진행 중입니다. 초보자도 참여 가능합니다.', 15, 1, sysdate - 75, NULL, 0, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 9, 'Node.js 프로젝트 42기', 'Node.js 프로젝트 42기 같이 성장하실 분들을 찾습니다.', 20, 0, sysdate - 49, NULL, 0, '홍대 카페', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 33, 'SQL 그룹 26기', 'SQL 그룹 26기 진행 중입니다. 초보자도 참여 가능합니다.', 15, 0, sysdate - 49, NULL, 0, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 76, '알고리즘 그룹 34기', '알고리즘 그룹 34기 실력 향상을 목표로 합니다.', 15, 1, sysdate - 47, NULL, 1, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 44, 'React 프로젝트 45기', 'React 프로젝트 45기 프로젝트 중심으로 진행됩니다.', 10, 1, sysdate - 77, NULL, 1, '판교 테크노밸리', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 74, '알고리즘 프로젝트 33기', '알고리즘 프로젝트 33기 실력 향상을 목표로 합니다.', 20, 0, sysdate - 59, NULL, 1, '신촌 카페', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 44, 'SQL 그룹 50기', 'SQL 그룹 50기 실력 향상을 목표로 합니다.', 15, 0, sysdate - 70, NULL, 1, '종로 공유오피스', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 99, 'SQL 그룹 35기', 'SQL 그룹 35기 함께 하실 분 모집합니다. 꾸준히 참여 가능하신 분 환영합니다.', 20, 1, sysdate - 73, NULL, 1, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 9, 'AWS 그룹 10기', 'AWS 그룹 10기 함께 하실 분 모집합니다. 꾸준히 참여 가능하신 분 환영합니다.', 20, 0, sysdate - 71, NULL, 1, '잠실 스터디룸', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 92, 'CS 스터디 14기', 'CS 스터디 14기 같이 성장하실 분들을 찾습니다.', 10, 1, sysdate - 62, NULL, 0, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 74, 'AWS 스터디 모집 40기', 'AWS 스터디 모집 40기 프로젝트 중심으로 진행됩니다.', 15, 1, sysdate - 17, NULL, 1, '잠실 스터디룸', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 15, 'CS 스터디 모집 46기', 'CS 스터디 모집 46기 실력 향상을 목표로 합니다.', 20, 1, sysdate - 86, NULL, 0, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 54, 'Spring 모임 2기', 'Spring 모임 2기 실력 향상을 목표로 합니다.', 15, 0, sysdate - 42, NULL, 0, '종로 공유오피스', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 65, 'React 모임 16기', 'React 모임 16기 실력 향상을 목표로 합니다.', 15, 0, sysdate - 64, NULL, 1, '판교 테크노밸리', 1);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 56, 'Java 스터디 모집 44기', 'Java 스터디 모집 44기 진행 중입니다. 초보자도 참여 가능합니다.', 10, 1, sysdate - 85, NULL, 0, NULL, 0);
INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 31, '알고리즘 모임 36기', '알고리즘 모임 36기 실력 향상을 목표로 합니다.', 15, 1, sysdate - 65, NULL, 1, '잠실 스터디룸', 1);

/*INSERT INTO tbl_Study (seq_study, seq_user, title, introduce, max_population, population, regdate, fixdate, status, location, isonline) VALUES (seq_study.nextVal, 1, 'React 프로젝트 17기', 'React 프로젝트 17기 같이 성장하실 분들을 찾습니다.', 20, 1, sysdate - 89, NULL, 1, NULL, 0);*/