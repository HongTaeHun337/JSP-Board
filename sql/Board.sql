--게시판(tbl_board)
/* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_Board CASCADE CONSTRAINTS;


/* 게시판 테이블 생성 */
CREATE TABLE tbl_Board (
    seq_board  NUMBER         NOT NULL, -- 게시판 번호
    name       VARCHAR2(100)  NOT NULL, -- 게시판명
    status     NUMBER         NOT NULL, -- 사용여부

    -- 기본키(PK) 설정: 별도의 INDEX 생성 구문 없이도 자동으로 UNIQUE INDEX가 생성됩니다.
    CONSTRAINT PK_tbl_Board PRIMARY KEY (seq_board)
);