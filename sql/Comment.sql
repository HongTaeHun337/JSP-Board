--댓글
    /* 기존 테이블 및 하위 제약 조건 삭제 */
DROP TABLE tbl_Comment CASCADE CONSTRAINTS;


/* 댓글 테이블 생성 */
CREATE TABLE tbl_Comment (
    seq_comment NUMBER                NOT NULL, -- 댓글 번호
    seq_user    NUMBER                NOT NULL, -- 회원번호
    seq_note    NUMBER                NOT NULL, -- 게시글 번호
    detail      VARCHAR2(2000)        NOT NULL, -- 댓글 내용
    regdate     DATE DEFAULT sysdate  NOT NULL, -- 작성일
    fixdate     DATE,                           -- 수정일
    status      NUMBER DEFAULT 0      NOT NULL, -- 삭제 여부 (0:미삭제, 1:삭제)

    -- 기본키(PK) 설정: 별도의 인덱스 생성 구문 없이도 자동으로 PK 인덱스가 생성됩니다.
    CONSTRAINT PK_tbl_Comment PRIMARY KEY (seq_comment),

    -- 외래키(FK) 설정: 게시글 테이블 참조
    CONSTRAINT FK_tbl_Note_TO_tbl_Comment FOREIGN KEY (seq_note)
        REFERENCES tbl_Note (seq_note),

    -- 외래키(FK) 설정: 회원 테이블 참조
    CONSTRAINT FK_tbl_User_TO_tbl_Comment FOREIGN KEY (seq_user)
        REFERENCES tbl_User (seq_user)
);



