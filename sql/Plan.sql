--학습계획
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_Plan CASCADE CONSTRAINTS;

/* 학습계획 테이블 생성 */
CREATE TABLE tbl_Plan (
    seq_plan    NUMBER                NOT NULL, -- 계획번호
    seq_user    NUMBER                NOT NULL, -- 회원번호
    title       VARCHAR2(100)         NOT NULL, -- 계획명
    topic       VARCHAR2(1000),                 -- 학습주제
    detail      VARCHAR2(2000),                 -- 계획내용
    endtype     NUMBER                NOT NULL, -- 종료유형
    startdate   DATE                  NOT NULL, -- 시작일
    enddate     DATE                  NOT NULL, -- 종료일
    regdate     DATE DEFAULT sysdate  NOT NULL, -- 생성일
    fixdate     DATE,                           -- 수정일
    status      NUMBER DEFAULT 0      NOT NULL, -- 진행상태
    goal        varchar2(2000),                 -- 최종 목표
    -- 기본키(PK) 설정
    CONSTRAINT PK_tbl_Plan PRIMARY KEY (seq_plan),

    -- 외래키(FK) 설정: 회원 테이블 참조
    CONSTRAINT FK_tbl_User_TO_tbl_Plan FOREIGN KEY (seq_user)
        REFERENCES tbl_User (seq_user)
);







