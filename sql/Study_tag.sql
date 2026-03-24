/* 스터디태그 */
DROP TABLE tbl_Study_tag
	CASCADE CONSTRAINTS;

create sequence seq_study_tag;

alter sequence seq_study_tag restart start with 2;

drop sequence seq_study_tag;

/* 스터디태그 */
CREATE TABLE tbl_Study_tag (
	seq_study_tag NUMBER NOT NULL, /* 스터디태그번호 */
	seq_study NUMBER NOT NULL, /* 스터디번호 */
	seq_tag NUMBER NOT NULL, /* 태그번호 */

    CONSTRAINT PK_tbl_Study_tag PRIMARY KEY (seq_study_tag),
    CONSTRAINT FK_tbl_Study_TO_tbl_Study_tag FOREIGN KEY (seq_study)
		REFERENCES tbl_Study (seq_study),
    CONSTRAINT FK_tbl_Tag_TO_tbl_Study_tag FOREIGN KEY (seq_tag)
		REFERENCES tbl_Tag (seq_tag)
);

select * from tbl_Study_tag;

commit;

delete tbl_Study_tag where seq_study_tag = 21;

insert into tbl_Study_tag values (seq_study_tag.nextVal,1,1);

INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 2, 8);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 2, 10);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 3, 4);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 3, 7);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 4, 13);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 4, 19);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 4, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 4, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 4, 9);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 5, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 5, 9);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 5, 4);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 5, 17);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 5, 12);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 6, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 6, 18);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 7, 9);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 7, 15);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 7, 2);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 7, 18);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 8, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 8, 12);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 8, 10);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 9, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 9, 2);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 9, 7);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 9, 3);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 10, 14);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 10, 13);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 10, 17);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 10, 5);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 10, 12);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 11, 7);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 11, 18);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 11, 14);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 11, 17);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 11, 2);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 12, 12);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 12, 19);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 12, 4);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 13, 9);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 13, 16);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 13, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 14, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 14, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 15, 16);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 15, 14);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 15, 13);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 16, 5);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 16, 7);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 16, 14);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 16, 10);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 17, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 17, 11);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 17, 5);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 17, 3);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 17, 6);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 18, 10);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 18, 18);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 19, 11);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 19, 18);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 19, 20);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 20, 8);
INSERT INTO tbl_Study_tag (seq_study_tag, seq_study, seq_tag) VALUES (seq_study_tag.nextVal, 20, 14);

