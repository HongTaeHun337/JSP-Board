--파일 데이터
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_File_Data CASCADE CONSTRAINTS;


/* 파일 데이터 테이블 생성 */
CREATE TABLE tbl_File_Data (
    seq_file_data  NUMBER                NOT NULL, -- 파일 번호
    seq_user       NUMBER                NOT NULL, -- 회원번호
    origin_name    VARCHAR2(100)         NOT NULL, -- 원본 파일명
    save_name      VARCHAR2(100)         NOT NULL, -- 저장 파일명
    link           VARCHAR2(1000)        NOT NULL, -- 저장 경로
    size_byte      NUMBER                NOT NULL, -- 파일 크기 (단위: byte)
    regdate        DATE DEFAULT sysdate  NOT NULL, -- 업로드 일시

    -- 기본키(PK) 설정
    CONSTRAINT PK_tbl_File_Data PRIMARY KEY (seq_file_data),

    -- 외래키(FK) 설정: 회원 테이블 참조
    CONSTRAINT FK_tbl_User_TO_tbl_File_Data FOREIGN KEY (seq_user)
        REFERENCES tbl_User (seq_user)
);




