-- 파일맵핑

INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 12, 24);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 12, 8);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 58, 20);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 2, 3);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 58, 23);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 18, 23);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 22, 27);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 11, 12);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 19, 27);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 4, 8);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 12, 5);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 2, 20);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 32, 24);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 55, 17);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 37, 2);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 40, 5);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 14, 1);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 34, 30);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 1, 30);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 32, 22);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 32, 28);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 38, 12);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 11, 23);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 37, 11);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 53, 6);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 18, 17);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 56, 10);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 14, 23);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 46, 10);
INSERT INTO tbl_File_mapping (seq_file_mapping, seq_note, seq_file_data) VALUES (seq_file_mapping.nextVal, 48, 4);

-- 삭제
delete
from TBL_FILE_DATA
where seq_file_mapping between 1 and 62;

-- 시퀀스 1부터 시작
ALTER SEQUENCE seq_file_data RESTART START WITH 1;

--확인
select * from TBL_FILE_MAPPING;

--저장
commit ;

create sequence seq_file_mapping;





--파일 매핑
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_File_mapping;


/* 파일 매핑 테이블 생성 */
CREATE TABLE tbl_File_mapping (
    seq_file_mapping  NUMBER  NOT NULL, -- 매핑 번호
    seq_note        NUMBER  NOT NULL, -- 참조하는 글 번호 (seq_note 등)
    seq_file_data     NUMBER  NOT NULL, -- 파일 번호

    -- 기본키(PK) 설정
    CONSTRAINT PK_tbl_File_mapping PRIMARY KEY (seq_file_mapping),

    -- 외래키(FK) 설정: 게시글 테이블 참조
    CONSTRAINT FK_tbl_Note_TO_File_Mapping FOREIGN KEY (seq_note)
        REFERENCES tbl_Note (seq_note),

    -- 외래키(FK) 설정: 파일 데이터 테이블 참조
    CONSTRAINT FK_tbl_FileData_TO_File_Mapping FOREIGN KEY (seq_file_data)
        REFERENCES tbl_File_Data (seq_file_data)
);


