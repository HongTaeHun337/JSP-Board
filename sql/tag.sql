/* 태그 */
DROP TABLE tbl_Tag
	CASCADE CONSTRAINTS;

create sequence seq_tag;

alter sequence seq_tag restart start with 2;

drop sequence seq_tag;

/* 태그 */
CREATE TABLE tbl_Tag (
	seq_tag NUMBER NOT NULL, /* 태그번호 */
	name VARCHAR2(100) NOT NULL, /* 태그명 */

    CONSTRAINT PK_tbl_Tag PRIMARY KEY (seq_tag)
);

commit;

select * from tbl_Tag;

delete tbl_Tag where seq_tag between 21 and  39;

insert into tbl_Tag values (seq_tag.nextVal, '테스트태그');

INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Java');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Spring');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Spring Boot');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'JPA');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Hibernate');

INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'JavaScript');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'TypeScript');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'React');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Git');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Node.js');

INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'HTML');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'CSS');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Tailwind CSS');

INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Oracle');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'MySQL');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'PostgreSQL');

INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Docker');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Kubernetes');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'AWS');
INSERT INTO tbl_Tag VALUES (seq_tag.nextVal, 'Vue.js');
