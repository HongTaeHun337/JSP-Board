--파일 매핑
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_File_mapping CASCADE CONSTRAINTS;


/* 파일 매핑 테이블 생성 */
CREATE TABLE tbl_File_mapping (
    seq_file_mapping  NUMBER  NOT NULL, -- 매핑 번호
    type              NUMBER  NOT NULL, -- 게시판 유형 (1: 일반, 2: 스터디 등)
    seq_number        NUMBER  NOT NULL, -- 참조하는 글 번호 (seq_note 등)
    seq_file_data     NUMBER  NOT NULL, -- 파일 번호

    -- 기본키(PK) 설정
    CONSTRAINT PK_tbl_File_mapping PRIMARY KEY (seq_file_mapping),

    -- 외래키(FK) 설정: 게시글 테이블 참조
    CONSTRAINT FK_tbl_Note_TO_File_Mapping FOREIGN KEY (seq_number)
        REFERENCES tbl_Note (seq_note),

    -- 외래키(FK) 설정: 파일 데이터 테이블 참조
    CONSTRAINT FK_tbl_FileData_TO_File_Mapping FOREIGN KEY (seq_file_data)
        REFERENCES tbl_File_Data (seq_file_data)
);


