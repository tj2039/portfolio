--commit;

/* 예약 */
CREATE TABLE reservation (
	reservNo NUMBER NOT NULL, /* 예약번호 */
	guestNo NUMBER NOT NULL, /* 회원번호 */
	RoomNo NUMBER NOT NULL, /* 객실정보번호 */
	adult NUMBER DEFAULT 2 NOT NULL, /* 성인수 */
	kids NUMBER DEFAULT 0 NOT NULL, /* 아동수 */
	ci_date VARCHAR2(50) NOT NULL, /* 체크인날짜 */
	co_date VARCHAR2(50) NOT NULL, /* 체크아웃날짜 */
	totalPrice NUMBER NOT NULL /* 총금액 */
);

create sequence reservation_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX reservation
	ON reservation (
		reservNo ASC
	);

ALTER TABLE reservation
	ADD
		CONSTRAINT reservation
		PRIMARY KEY (
			reservNo
		);

/* 회원 */
CREATE TABLE guest (
	guestNo NUMBER NOT NULL, /* 회원번호 */
	name VARCHAR2(50) NOT NULL, /* 이름 */
	userId VARCHAR2(50) NOT NULL, /* 아이디 */
	pwd VARCHAR2(50) NOT NULL, /* 비밀번호 */
	email VARCHAR2(50), /* 이메일 */
	tel VARCHAR2(50) NOT NULL, /* 전화번호 */
	joindate DATE DEFAULT sysdate NOT NULL, /* 가입날짜 */
	outdate DATE, /* 탈퇴날짜 */
	sys NUMBER DEFAULT 1 NOT NULL /* 관리자여부 */
);

create sequence guest_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX guest
	ON guest (
		guestNo ASC
	);

ALTER TABLE guest
	ADD
		CONSTRAINT guest
		PRIMARY KEY (
			guestNo
		);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '관리자', 'admin', '1234', 'admin@naver.com', '010-1000-2000', sysdate, 2);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '홍길동', 'honghong', '1234', 'hong@naver.com', '010-1234-1234', sysdate, 1);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '박권수', 'park', '1234', 'park@naver.com', '010-9478-6140', sysdate, 1);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '김봉중', 'honghong', '1234', 'hong@naver.com', '010-1111-1111', sysdate, 1);


/* 후기게시판 */
CREATE TABLE reviewBoard (
	reviewNo NUMBER NOT NULL, /* 후기번호 */
	guestNo NUMBER NOT NULL, /* 회원번호 */
	r_title VARCHAR2(50) NOT NULL, /* 제목 */
	r_content CLOB, /* 내용 */
	r_regdate DATE DEFAULT sysdate NOT NULL /* 작성일 */
);

create sequence reviewBoard_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX reviewBoard
	ON reviewBoard (
		reviewNo ASC
	);

ALTER TABLE reviewBoard
	ADD
		CONSTRAINT reviewBoard
		PRIMARY KEY (
			reviewNo
		);

/* 문의게시판 */
CREATE TABLE askBoard (
	askNo NUMBER NOT NULL, /* 문의번호 */
	guestNo NUMBER NOT NULL, /* 회원번호 */
	a_title VARCHAR2(50) NOT NULL, /* 제목 */
	a_content CLOB NOT NULL, /* 문의내용 */
	a_regdate DATE DEFAULT sysdate NOT NULL /* 작성일 */
);

create sequence askBoard_seq
increment by 1
start with 1
nocache;


CREATE UNIQUE INDEX askBoard
	ON askBoard (
		askNo ASC
	);

ALTER TABLE askBoard
	ADD
		CONSTRAINT askBoard
		PRIMARY KEY (
			askNo
		);

/* 공지사항 */
CREATE TABLE noticeBoard (
	noticeNo NUMBER NOT NULL, /* 공지사항번호 */
	guestNo NUMBER NOT NULL, /* 회원번호 */
	n_title VARCHAR2(50) NOT NULL, /* 제목 */
	n_content CLOB NOT NULL, /* 내용 */
	n_regdate DATE DEFAULT sysdate NOT NULL /* 작성일 */
);

create sequence noticeBoard_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX noticeBoard
	ON noticeBoard (
		noticeNo ASC
	);

ALTER TABLE noticeBoard
	ADD
		CONSTRAINT noticeBoard
		PRIMARY KEY (
			noticeNo
		);

/* 부대시설 */
CREATE TABLE facility (
	facNo NUMBER NOT NULL, /* 부대시설예약번호 */
	reservNo NUMBER, /* 예약번호 */
	facInfoNo NUMBER, /* 부대시설정보번호 */
	adultNo NUMBER, /* 성인수 */
	kidsNo NUMBER /* 아동수 */
);

create sequence facility_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX facility
	ON facility (
		facNo ASC
	);

ALTER TABLE facility
	ADD
		CONSTRAINT facility
		PRIMARY KEY (
			facNo
		);

/* 지점 위치 */
CREATE TABLE location (
	locName VARCHAR2(50) NOT NULL, /* 지점명 */
	Address VARCHAR2(100) NOT NULL /* 위치 */
);

CREATE UNIQUE INDEX location
	ON location (
		locName ASC
	);

ALTER TABLE location
	ADD
		CONSTRAINT location
		PRIMARY KEY (
			locName
		);

insert into location (locName, Address)
values('Full Moon', '서울특별시 중구 동호로 249');  
insert into location (locName, Address)
values('Half Moon', '서울특별시 마포구 마포대로 83');  
insert into location (locName, Address)
values('Crescent Moon', '서울특별시 서초구 효령로 427');  

/* 부대시설정보 */
CREATE TABLE facilityInfo (
	facInfoNo NUMBER NOT NULL, /* 부대시설정보번호 */
	facName VARCHAR2(50) NOT NULL, /* 부대시설이름 */
	adultPrice NUMBER DEFAULT 0 NOT NULL, /* 성인가격 */
	kidsPrice NUMBER DEFAULT 0 NOT NULL /* 어린이가격 */
);

CREATE UNIQUE INDEX PK_facilityInfo
	ON facilityInfo (
		facInfoNo ASC
	);

ALTER TABLE facilityInfo
	ADD
		CONSTRAINT PK_facilityInfo
		PRIMARY KEY (
			facInfoNo
		);

insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(1, '조식', 40000, 17000);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(2, '수영장', 45000, 28000);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(3, '사우나', 35000, 0);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(4, '헬스장', 20000, 0);


/* 객실 */
CREATE TABLE Room (
	RoomNo NUMBER NOT NULL, /* 객실정보번호 */
	locName VARCHAR2(50) NOT NULL, /* 지점명 */
	roomType VARCHAR2(50) NOT NULL, /* 객실타입 */
	roomPrice NUMBER NOT NULL, /* 객실가격 */
	roomImage VARCHAR2(100), /* 객실이미지 */
	roomCount NUMBER /* 객실수 */
);

create sequence Room_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX PK_Room
	ON Room (
		RoomNo ASC
	);

ALTER TABLE Room
	ADD
		CONSTRAINT PK_Room
		PRIMARY KEY (
			RoomNo
		);

insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '디럭스', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '슈페리어', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '스위트', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '모노그램스위트', 550000, 'monogram.png', 2); 

insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '디럭스', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '슈페리어', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '스위트', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '모노그램스위트', 550000, 'monogram.png', 2); 

insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '디럭스', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '슈페리어', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '스위트', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '모노그램스위트', 550000, 'monogram.png', 2); 


/* 문의게시판 댓글 */
CREATE TABLE comments (
	no NUMBER NOT NULL, /* 댓글번호 */
	askNo NUMBER NOT NULL, /* 문의번호 */
	name VARCHAR2(20) NOT NULL, /* 이름 */
	content VARCHAR2(2000), /* 내용 */
	regdate DATE DEFAULT sysdate NOT NULL /* 작성일 */
);

create sequence comments_seq
increment by 1
start with 1
nocache;

CREATE UNIQUE INDEX PK_comments
	ON comments (
		no ASC
	);

ALTER TABLE comments
	ADD
		CONSTRAINT PK_comments
		PRIMARY KEY (
			no
		);

ALTER TABLE reservation
	ADD
		CONSTRAINT FK_guest_TO_reservation
		FOREIGN KEY (
			guestNo
		)
		REFERENCES guest (
			guestNo
		);

ALTER TABLE reservation
	ADD
		CONSTRAINT FK_Room_TO_reservation
		FOREIGN KEY (
			RoomNo
		)
		REFERENCES Room (
			RoomNo
		);

ALTER TABLE reviewBoard
	ADD
		CONSTRAINT FK_guest_TO_reviewBoard
		FOREIGN KEY (
			guestNo
		)
		REFERENCES guest (
			guestNo
		);

ALTER TABLE askBoard
	ADD
		CONSTRAINT FK_guest_TO_askBoard
		FOREIGN KEY (
			guestNo
		)
		REFERENCES guest (
			guestNo
		);

ALTER TABLE noticeBoard
	ADD
		CONSTRAINT FK_guest_TO_noticeBoard
		FOREIGN KEY (
			guestNo
		)
		REFERENCES guest (
			guestNo
		);

ALTER TABLE facility
	ADD
		CONSTRAINT FK_reservation_TO_facility
		FOREIGN KEY (
			reservNo
		)
		REFERENCES reservation (
			reservNo
		);

ALTER TABLE facility
   ADD
      CONSTRAINT FK_facilityInfo_TO_facility
      FOREIGN KEY (
         facInfoNo
      )
      REFERENCES facilityInfo (
         facInfoNo
      )
on delete cascade;

ALTER TABLE Room
	ADD
		CONSTRAINT FK_location_TO_Room
		FOREIGN KEY (
			locName
		)
		REFERENCES location (
			locName
		);

ALTER TABLE comments
	ADD
		CONSTRAINT FK_askBoard_TO_comments
		FOREIGN KEY (
			askNo
		)
		REFERENCES askBoard (
			askNo
		);


//부대시설 판매 조회 

create or replace view v_fac_sales
as
    select m.locname, i.facname, i.adultprice, i.kidsprice, r.ci_date , f.kidsno, f.adultno
    from facility f, reservation r, facilityinfo i, room m
    where f.reservno = r.reservno 
        and f.facinfono = i.facinfono
         and r.roomno = m.roomno;
         
  

//객실 판매조회 

create or replace view v_room_sales
as
    select m.locname, m.roomtype, m.roomprice, r.ci_date 
    from reservation r,
        room m
    where r.roomno = m.roomno;
    