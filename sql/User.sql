/* 회원정보 */
DROP TABLE tbl_User
	CASCADE CONSTRAINTS;

create sequence seq_user;

alter sequence seq_user restart start with 1;
SELECT seq_user.CURRVAL FROM dual;

drop sequence  seq_user;

/* 회원정보 */
CREATE TABLE tbl_User (
	seq_user NUMBER NOT NULL, /* 회원번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	password VARCHAR2(20) NOT NULL, /* 비밀번호 */
	name VARCHAR2(10) NOT NULL, /* 이름 */
	nickname VARCHAR2(15) NOT NULL, /* 닉네임 */
	email VARCHAR2(50) NOT NULL, /* 이메일 */
	regdate DATE DEFAULT sysdate NOT NULL, /* 가입일 */
	status NUMBER DEFAULT 0 NOT NULL, /* 회원상태 (0/1/2 : 활동/탈퇴/정지) */
	authority NUMBER DEFAULT 1 NOT NULL, /* 권한 (0/1 : 관리자/일반 회원) */

    CONSTRAINT PK_tbl_User PRIMARY KEY (seq_user)
);

ALTER TABLE tbl_User
MODIFY nickname VARCHAR2(50);

/* id 중복방지 */
ALTER TABLE tbl_User
ADD CONSTRAINT UQ_tbl_User_id UNIQUE (id);

/* email 중복방지 */
ALTER TABLE tbl_User
ADD CONSTRAINT UQ_tbl_User_email UNIQUE (email);

/* pw 중복방지 */
ALTER TABLE tbl_User
ADD CONSTRAINT UQ_tbl_User_password UNIQUE (password);

/* 활동상태 유효값 확인 */
ALTER TABLE tbl_User
ADD CONSTRAINT CK_tbl_User_status
CHECK (status IN (0, 1, 2));

/* 권한 유효값 확인 */
ALTER TABLE tbl_User
ADD CONSTRAINT CK_tbl_User_authority
CHECK (authority IN (0, 1));

select * from tbl_User;

commit;

delete tbl_User where seq_user = 1;

insert into tbl_User values (seq_user.nextVal,'testid123','testpw123', '홍길동', 'Hong', 'hong123@test.com',
                         sysdate, 0, 1);

UPDATE tbl_User
SET authority = 0
WHERE seq_user = 1;

INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (2, 'user7a29d630', 'pw35e82a85', '박날첨', '코딩하는감자21', 'user7a29d630@test.com', sysdate - 339, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (3, 'user07afe8b9', 'pw0a3df3ae', '김촌첨', '코딩이싫다', 'user07afe8b9@test.com', sysdate - 311, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (4, 'userabeb49a5', 'pw736ec103', '박글술', '오늘도야근', 'userabeb49a5@test.com', sysdate - 216, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (5, 'user0c7bbe50', 'pwddd24cd0', '김로터', '코딩하는토끼34', 'user0c7bbe50@test.com', sysdate - 160, 0, 1);

INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (6, 'userdd740dd8', 'pwe58854cd', '이픔철', '코딩하는직장인75', 'userdd740dd8@test.com', sysdate - 148, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (7, 'useraa0762f5', 'pw3c0c3fa3', '김갑팔', '야근하는직장인71', 'useraa0762f5@test.com', sysdate - 293, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (8, 'user09a86fa5', 'pwad8960da', '김탄븝', '지친토끼', 'user09a86fa5@test.com', sysdate - 200, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (9, 'user9a9d978c', 'pw9bb5b053', '이스촙', '놀고있는개발자85', 'user9a9d978c@test.com', sysdate - 284, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (10, 'user9118edc6', 'pw29707a2d', '김흥카', '화난직장인', 'user9118edc6@test.com', sysdate - 171, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (11, 'userf54eee78', 'pw8cc95931', '이주반', '퇴근하는고양이21', 'userf54eee78@test.com', sysdate - 239, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (12, 'user48053b44', 'pwdaa411b6', '박날넌', '출근하는강아지72', 'user48053b44@test.com', sysdate - 229, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (13, 'user417aae20', 'pw0031f50a', '김몰쿤', '졸린강아지', 'user417aae20@test.com', sysdate - 68, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (14, 'user454d8ebd', 'pwc15ac1ce', '박폰움', '공부하는직장인36', 'user454d8ebd@test.com', sysdate - 118, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (15, 'user303a1770', 'pw9f7e0a7e', '박할설', '놀고있는사람64', 'user303a1770@test.com', sysdate - 118, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (16, 'usereacca996', 'pw048c05f9', '이랍숨', '출근하는학생61', 'usereacca996@test.com', sysdate - 257, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (17, 'user0a7254b4', 'pw9192775e', '이롱함', '버그너무많다', 'user0a7254b4@test.com', sysdate - 185, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (18, 'user031be661', 'pwcd1fc2ad', '이즙성', '코딩하는사람', 'user031be661@test.com', sysdate - 351, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (19, 'user606cf0f8', 'pwb0bc873a', '이법서', '행복한토끼', 'user606cf0f8@test.com', sysdate - 159, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (20, 'user87a92f02', 'pwa1c79802', '이분돈', '버그잡는사람', 'user87a92f02@test.com', sysdate - 243, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (21, 'userb0322072', 'pw52b30eff', '이폰팍', '코딩하는직장인49', 'userb0322072@test.com', sysdate - 216, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (22, 'user170ff8e6', 'pw88aeb9e4', '박틈노', '귀찮은강아지', 'user170ff8e6@test.com', sysdate - 198, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (23, 'user4c3a0da9', 'pwd294301f', '김강묵', '코딩하는고양이32', 'user4c3a0da9@test.com', sysdate - 283, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (24, 'usere6dc832a', 'pw6865639c', '박푸낭', '지친사람', 'usere6dc832a@test.com', sysdate - 21, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (25, 'user25ab6143', 'pw851ccc19', '박말툭', '버그잡는토끼', 'user25ab6143@test.com', sysdate - 4, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (26, 'userc66c3b9c', 'pw476bd81d', '박나찹', '버그잡는고양이59', 'userc66c3b9c@test.com', sysdate - 152, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (27, 'userc1cf1ae1', 'pw688b34ca', '이잔군', '졸린고양이', 'userc1cf1ae1@test.com', sysdate - 151, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (28, 'user8e4935ab', 'pwfeb71857', '이흐펍', '집에가고싶다', 'user8e4935ab@test.com', sysdate - 267, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (29, 'user98fc1d05', 'pwc66d3458', '박봄럼', '놀고있는고양이46', 'user98fc1d05@test.com', sysdate - 240, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (30, 'userfcaaf503', 'pw8b1d2601', '김홀무', '퇴근하는강아지61', 'userfcaaf503@test.com', sysdate - 82, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (31, 'user59eb6537', 'pw4ebb36dd', '박줍잠', '퇴근하는학생', 'user59eb6537@test.com', sysdate - 314, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (32, 'user6c0db2d6', 'pw3c13a139', '김탁탕', '배고픈고양이', 'user6c0db2d6@test.com', sysdate - 132, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (33, 'user95e4ae18', 'pwf4ea33eb', '이듭음', '야근하는강아지', 'user95e4ae18@test.com', sysdate - 355, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (34, 'user30829035', 'pwefdca9c3', '박룹순', '공부하는개발자', 'user30829035@test.com', sysdate - 326, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (35, 'useredbc4c42', 'pw9d693249', '이오참', '공부하는직장인', 'useredbc4c42@test.com', sysdate - 80, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (36, 'user3e2072fd', 'pw1e408bba', '김콩늠', '퇴근하고싶다', 'user3e2072fd@test.com', sysdate - 17, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (37, 'user00e18c32', 'pwf8f4f44f', '박운잘', '심심한고양이', 'user00e18c32@test.com', sysdate - 83, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (38, 'userff96e39e', 'pwc1a0dac6', '박므운', '버그잡는고양이', 'userff96e39e@test.com', sysdate - 155, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (39, 'user9d5ba234', 'pw2e652953', '김프몽', '공부하는직장인91', 'user9d5ba234@test.com', sysdate - 2, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (40, 'user60f7d19c', 'pwd5847a34', '이늑푹', '퇴근하는사람', 'user60f7d19c@test.com', sysdate - 260, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (41, 'usereaa6a88d', 'pwc54b1a53', '박졸붑', '화난개발자', 'usereaa6a88d@test.com', sysdate - 246, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (42, 'user5824e5aa', 'pwbb16cc44', '이쿨캉', '야근하는학생', 'user5824e5aa@test.com', sysdate - 259, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (43, 'userb2e42af4', 'pw639b0fce', '이산톱', '야근하는토끼', 'userb2e42af4@test.com', sysdate - 250, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (44, 'user05aaf02b', 'pwe45445b2', '박범굼', '코딩하는고양이0', 'user05aaf02b@test.com', sysdate - 353, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (45, 'user3a7d1f18', 'pw80e651c0', '이럴덥', '행복한학생', 'user3a7d1f18@test.com', sysdate - 236, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (46, 'user3ef5b61d', 'pw480dd83d', '이험건', '코딩하는학생16', 'user3ef5b61d@test.com', sysdate - 266, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (47, 'userf2669d2e', 'pwfe054523', '박퐁앙', '야근하는감자', 'userf2669d2e@test.com', sysdate - 334, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (48, 'user08170a05', 'pw814eba8c', '박푼단', '출근하는학생25', 'user08170a05@test.com', sysdate - 0, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (49, 'user9e1b6dfd', 'pw43635524', '이헌뭅', '출근하는강아지13', 'user9e1b6dfd@test.com', sysdate - 221, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (50, 'user8314c8da', 'pw052d3d01', '박털눌', '코딩하는감자82', 'user8314c8da@test.com', sysdate - 197, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (51, 'userd607be01', 'pw4dd24074', '김둘말', '출근하는강아지', 'userd607be01@test.com', sysdate - 323, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (52, 'userba020adf', 'pw9e9761af', '김멉톰', '코딩하는학생2', 'userba020adf@test.com', sysdate - 16, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (53, 'userf45dadd8', 'pw590e9bed', '이납날', '코딩하는토끼44', 'userf45dadd8@test.com', sysdate - 292, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (54, 'user2a913d5e', 'pwea6e154b', '박허큭', '귀찮은감자', 'user2a913d5e@test.com', sysdate - 326, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (55, 'userc8183a0f', 'pw72e6be40', '박몸둔', '야근하는고양이', 'userc8183a0f@test.com', sysdate - 69, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (56, 'userf8fe6540', 'pwfaf39afe', '이덕라', '졸린개발자', 'userf8fe6540@test.com', sysdate - 283, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (57, 'user781a7ddc', 'pw6c8e5925', '김난바', '출근하는사람', 'user781a7ddc@test.com', sysdate - 224, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (58, 'user7901fd7f', 'pw41b65c36', '박텅몽', '퇴근하는직장인', 'user7901fd7f@test.com', sysdate - 170, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (59, 'user91fba118', 'pw3f4d77f9', '박사톤', '출근하는개발자75', 'user91fba118@test.com', sysdate - 192, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (60, 'user2cb52366', 'pw72106b7c', '김돌덥', '코딩하는강아지', 'user2cb52366@test.com', sysdate - 106, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (61, 'userb08c386c', 'pw0a683c4f', '이픔킁', '놀고있는학생42', 'userb08c386c@test.com', sysdate - 204, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (62, 'userdd20ed45', 'pwbb68a86f', '이퉁름', '심심한학생', 'userdd20ed45@test.com', sysdate - 102, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (63, 'user63588c4a', 'pw01e8c5f7', '박춘콕', '귀찮은고양이', 'user63588c4a@test.com', sysdate - 186, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (64, 'userd48256cd', 'pw8f288802', '이머곰', '버그잡는강아지', 'userd48256cd@test.com', sysdate - 347, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (65, 'user56e14468', 'pwf6ca7e9c', '이늑감', '공부하는감자', 'user56e14468@test.com', sysdate - 311, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (66, 'usera85f79d6', 'pw9f64f00f', '김술맙', '출근하는학생8', 'usera85f79d6@test.com', sysdate - 249, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (67, 'user4bcaa909', 'pwdc4b370a', '김흠파', '배고픈토끼', 'user4bcaa909@test.com', sysdate - 330, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (68, 'userb84968dc', 'pwcf2d5e4d', '이븝당', '행복한감자', 'userb84968dc@test.com', sysdate - 339, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (69, 'userf11c4784', 'pwcd94b2e7', '박숭허', '퇴근하는직장인28', 'userf11c4784@test.com', sysdate - 85, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (70, 'user44502c37', 'pwcc172f15', '박음칼', '야근하는강아지2', 'user44502c37@test.com', sysdate - 161, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (71, 'user9227994c', 'pwbb69345f', '이쿤척', '놀고있는사람22', 'user9227994c@test.com', sysdate - 41, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (72, 'user0216acae', 'pwfa2fe6b1', '이허불', '퇴근하는감자', 'user0216acae@test.com', sysdate - 104, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (73, 'user13ab5fdd', 'pw2f37b26e', '박클홀', '퇴근하는강아지', 'user13ab5fdd@test.com', sysdate - 43, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (74, 'user786649de', 'pw1a9c1a68', '이반춘', '출근하는개발자', 'user786649de@test.com', sysdate - 34, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (75, 'user5cda6cff', 'pw845d2120', '김낙스', '코딩하는감자97', 'user5cda6cff@test.com', sysdate - 309, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (76, 'user61376be7', 'pwe2de6f5e', '이흔노', '화난사람', 'user61376be7@test.com', sysdate - 128, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (77, 'user8c1632af', 'pwb6cb3297', '박분돕', '퇴근하는사람73', 'user8c1632af@test.com', sysdate - 113, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (78, 'user465b122c', 'pw88d24061', '김초맙', '퇴근하는토끼25', 'user465b122c@test.com', sysdate - 199, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (79, 'user0896135f', 'pwf5812e98', '박쿱츱', '행복한고양이', 'user0896135f@test.com', sysdate - 9, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (80, 'userabb32aa2', 'pw6a617b73', '박옹흔', '졸린토끼', 'userabb32aa2@test.com', sysdate - 331, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (81, 'usera98d5e81', 'pw96f4ba57', '김찹통', '화난강아지', 'usera98d5e81@test.com', sysdate - 48, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (82, 'user19f34236', 'pw907795da', '박헙를', '코딩하는감자', 'user19f34236@test.com', sysdate - 6, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (83, 'user478dc60e', 'pw245e5625', '김픕칸', '출근하는사람45', 'user478dc60e@test.com', sysdate - 328, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (84, 'user81cf3b71', 'pwfc034b36', '김즘업', '놀고있는직장인', 'user81cf3b71@test.com', sysdate - 191, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (85, 'user2a346788', 'pwc98da4e9', '이참오', '퇴근하는고양이44', 'user2a346788@test.com', sysdate - 188, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (86, 'userdc6259b9', 'pwcd06824e', '박룩구', '야근하는고양이91', 'userdc6259b9@test.com', sysdate - 248, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (87, 'user332ec2a7', 'pw889879be', '박흡논', '출근하는개발자25', 'user332ec2a7@test.com', sysdate - 38, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (88, 'userd53fdf51', 'pwba00302e', '이론톱', '놀고있는강아지', 'userd53fdf51@test.com', sysdate - 224, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (89, 'user0cc5f310', 'pw3fd943c5', '이큰듭', '행복한개발자', 'user0cc5f310@test.com', sysdate - 138, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (90, 'user8740e8fa', 'pw05d7da51', '이텁항', '놀고있는학생79', 'user8740e8fa@test.com', sysdate - 55, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (91, 'userbe3542e7', 'pw3342ab6c', '김북뭄', '행복한사람', 'userbe3542e7@test.com', sysdate - 122, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (92, 'user7018e46c', 'pw886e179d', '박칵공', '코딩하는직장인76', 'user7018e46c@test.com', sysdate - 82, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (93, 'userba72bf49', 'pwdf059e80', '이궁칸', '심심한개발자', 'userba72bf49@test.com', sysdate - 325, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (94, 'user214db3b7', 'pw4e49de39', '박퉁톤', '출근하는토끼39', 'user214db3b7@test.com', sysdate - 304, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (95, 'user9baaad89', 'pw0c135632', '김팍훈', '퇴근하는토끼10', 'user9baaad89@test.com', sysdate - 110, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (96, 'user19ef2cf8', 'pw51f55ae9', '김믑돕', '놀고있는사람47', 'user19ef2cf8@test.com', sysdate - 187, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (97, 'user1c05b1dc', 'pw326e99ad', '박헉곡', '코딩하는학생44', 'user1c05b1dc@test.com', sysdate - 117, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (98, 'userb6abb41c', 'pw6a789604', '박점속', '공부하는감자4', 'userb6abb41c@test.com', sysdate - 131, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (99, 'user1ed25b42', 'pw4e665e19', '김픈턴', '심심한직장인', 'user1ed25b42@test.com', sysdate - 214, 0, 1);
INSERT INTO tbl_User (seq_user, id, password, name, nickname, email, regdate, status, authority) VALUES (100, 'user6ec0896a', 'pwa42c4aea', '박골남', '코딩하는직장인', 'user6ec0896a@test.com', sysdate - 75, 0, 1);

