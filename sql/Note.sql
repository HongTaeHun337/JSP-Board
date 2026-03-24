--게시글
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_Note CASCADE CONSTRAINTS;


/* 게시글 테이블 생성 */
CREATE TABLE tbl_Note (
    seq_note    NUMBER                NOT NULL, -- 게시글 번호
    seq_user    NUMBER                NOT NULL, -- 회원번호
    seq_board   NUMBER                NOT NULL, -- 게시판 번호
    title       VARCHAR2(100)         NOT NULL, -- 제목
    detail      VARCHAR2(2000)        NOT NULL, -- 내용
    regdate     DATE DEFAULT sysdate  NOT NULL, -- 작성일
    fixdate     DATE,                           -- 수정일
    viewcount   NUMBER DEFAULT 0      NOT NULL, -- 조회수 (기본값 0 추가 권장)

    -- 기본키(PK) 설정
    CONSTRAINT PK_tbl_Note PRIMARY KEY (seq_note),

    -- 외래키(FK) 설정: 게시판 테이블 참조
    CONSTRAINT FK_tbl_Board_TO_tbl_Note FOREIGN KEY (seq_board)
        REFERENCES tbl_Board (seq_board),

    -- 외래키(FK) 설정: 회원 테이블 참조
    CONSTRAINT FK_tbl_User_TO_tbl_Note FOREIGN KEY (seq_user)
        REFERENCES tbl_User (seq_user)
);





