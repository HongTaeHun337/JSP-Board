--학습 기록
    /* 기존 테이블 및 연관된 제약 조건 삭제 */
DROP TABLE tbl_Plan_History CASCADE CONSTRAINTS;


/* 학습기록 테이블 생성 */
CREATE TABLE tbl_Plan_History (
    seq_plan_history  NUMBER                NOT NULL, -- 기록번호
    seq_plan          NUMBER                NOT NULL, -- 계획번호
    seq_user          NUMBER                NOT NULL, -- 회원번호
    studydate         DATE                  NOT NULL, -- 학습날짜
    detail            VARCHAR2(100)         NOT NULL, -- 학습내용
    memo              VARCHAR2(2000),                 -- 메모
    regdate           DATE DEFAULT sysdate  NOT NULL, -- 작성일
    fixdate           DATE,                           -- 수정일

    -- 기본키(PK) 설정: 자동으로 유니크 인덱스가 생성됩니다.
    CONSTRAINT PK_tbl_Plan_History PRIMARY KEY (seq_plan_history),

    -- 외래키(FK) 설정: 회원 테이블 참조
    CONSTRAINT FK_tbl_User_TO_tbl_Plan_Hist FOREIGN KEY (seq_user)
        REFERENCES tbl_User (seq_user),

    -- 외래키(FK) 설정: 학습계획 테이블 참조
    CONSTRAINT FK_tbl_Plan_TO_tbl_Plan_Hist FOREIGN KEY (seq_plan)
        REFERENCES tbl_Plan (seq_plan)
);





