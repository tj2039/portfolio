--commit;

/* ���� */
CREATE TABLE reservation (
	reservNo NUMBER NOT NULL, /* �����ȣ */
	guestNo NUMBER NOT NULL, /* ȸ����ȣ */
	RoomNo NUMBER NOT NULL, /* ����������ȣ */
	adult NUMBER DEFAULT 2 NOT NULL, /* ���μ� */
	kids NUMBER DEFAULT 0 NOT NULL, /* �Ƶ��� */
	ci_date VARCHAR2(50) NOT NULL, /* üũ�γ�¥ */
	co_date VARCHAR2(50) NOT NULL, /* üũ�ƿ���¥ */
	totalPrice NUMBER NOT NULL /* �ѱݾ� */
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

/* ȸ�� */
CREATE TABLE guest (
	guestNo NUMBER NOT NULL, /* ȸ����ȣ */
	name VARCHAR2(50) NOT NULL, /* �̸� */
	userId VARCHAR2(50) NOT NULL, /* ���̵� */
	pwd VARCHAR2(50) NOT NULL, /* ��й�ȣ */
	email VARCHAR2(50), /* �̸��� */
	tel VARCHAR2(50) NOT NULL, /* ��ȭ��ȣ */
	joindate DATE DEFAULT sysdate NOT NULL, /* ���Գ�¥ */
	outdate DATE, /* Ż��¥ */
	sys NUMBER DEFAULT 1 NOT NULL /* �����ڿ��� */
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
values(guest_seq.nextval, '������', 'admin', '1234', 'admin@naver.com', '010-1000-2000', sysdate, 2);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, 'ȫ�浿', 'honghong', '1234', 'hong@naver.com', '010-1234-1234', sysdate, 1);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '�ڱǼ�', 'park', '1234', 'park@naver.com', '010-9478-6140', sysdate, 1);

insert into guest (guestno, name, userid, pwd, email, tel, joindate, sys)
values(guest_seq.nextval, '�����', 'honghong', '1234', 'hong@naver.com', '010-1111-1111', sysdate, 1);


/* �ı�Խ��� */
CREATE TABLE reviewBoard (
	reviewNo NUMBER NOT NULL, /* �ı��ȣ */
	guestNo NUMBER NOT NULL, /* ȸ����ȣ */
	r_title VARCHAR2(50) NOT NULL, /* ���� */
	r_content CLOB, /* ���� */
	r_regdate DATE DEFAULT sysdate NOT NULL /* �ۼ��� */
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

/* ���ǰԽ��� */
CREATE TABLE askBoard (
	askNo NUMBER NOT NULL, /* ���ǹ�ȣ */
	guestNo NUMBER NOT NULL, /* ȸ����ȣ */
	a_title VARCHAR2(50) NOT NULL, /* ���� */
	a_content CLOB NOT NULL, /* ���ǳ��� */
	a_regdate DATE DEFAULT sysdate NOT NULL /* �ۼ��� */
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

/* �������� */
CREATE TABLE noticeBoard (
	noticeNo NUMBER NOT NULL, /* �������׹�ȣ */
	guestNo NUMBER NOT NULL, /* ȸ����ȣ */
	n_title VARCHAR2(50) NOT NULL, /* ���� */
	n_content CLOB NOT NULL, /* ���� */
	n_regdate DATE DEFAULT sysdate NOT NULL /* �ۼ��� */
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

/* �δ�ü� */
CREATE TABLE facility (
	facNo NUMBER NOT NULL, /* �δ�ü������ȣ */
	reservNo NUMBER, /* �����ȣ */
	facInfoNo NUMBER, /* �δ�ü�������ȣ */
	adultNo NUMBER, /* ���μ� */
	kidsNo NUMBER /* �Ƶ��� */
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

/* ���� ��ġ */
CREATE TABLE location (
	locName VARCHAR2(50) NOT NULL, /* ������ */
	Address VARCHAR2(100) NOT NULL /* ��ġ */
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
values('Full Moon', '����Ư���� �߱� ��ȣ�� 249');  
insert into location (locName, Address)
values('Half Moon', '����Ư���� ������ ������� 83');  
insert into location (locName, Address)
values('Crescent Moon', '����Ư���� ���ʱ� ȿ�ɷ� 427');  

/* �δ�ü����� */
CREATE TABLE facilityInfo (
	facInfoNo NUMBER NOT NULL, /* �δ�ü�������ȣ */
	facName VARCHAR2(50) NOT NULL, /* �δ�ü��̸� */
	adultPrice NUMBER DEFAULT 0 NOT NULL, /* ���ΰ��� */
	kidsPrice NUMBER DEFAULT 0 NOT NULL /* ��̰��� */
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
values(1, '����', 40000, 17000);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(2, '������', 45000, 28000);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(3, '��쳪', 35000, 0);
insert into facilityInfo(facInfoNo, facName, adultPrice, kidsPrice)
values(4, '�ｺ��', 20000, 0);


/* ���� */
CREATE TABLE Room (
	RoomNo NUMBER NOT NULL, /* ����������ȣ */
	locName VARCHAR2(50) NOT NULL, /* ������ */
	roomType VARCHAR2(50) NOT NULL, /* ����Ÿ�� */
	roomPrice NUMBER NOT NULL, /* ���ǰ��� */
	roomImage VARCHAR2(100), /* �����̹��� */
	roomCount NUMBER /* ���Ǽ� */
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
values(room_seq.nextval, 'Full Moon', '�𷰽�', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '���丮��', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '����Ʈ', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Full Moon', '���׷�����Ʈ', 550000, 'monogram.png', 2); 

insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '�𷰽�', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '���丮��', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '����Ʈ', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Half Moon', '���׷�����Ʈ', 550000, 'monogram.png', 2); 

insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '�𷰽�', 240000, 'dex.png', 10); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '���丮��', 280000, 'spr.png', 8); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '����Ʈ', 400000, 'room-suite.png', 5); 
insert into room(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(room_seq.nextval, 'Crescent Moon', '���׷�����Ʈ', 550000, 'monogram.png', 2); 


/* ���ǰԽ��� ��� */
CREATE TABLE comments (
	no NUMBER NOT NULL, /* ��۹�ȣ */
	askNo NUMBER NOT NULL, /* ���ǹ�ȣ */
	name VARCHAR2(20) NOT NULL, /* �̸� */
	content VARCHAR2(2000), /* ���� */
	regdate DATE DEFAULT sysdate NOT NULL /* �ۼ��� */
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


//�δ�ü� �Ǹ� ��ȸ 

create or replace view v_fac_sales
as
    select m.locname, i.facname, i.adultprice, i.kidsprice, r.ci_date , f.kidsno, f.adultno
    from facility f, reservation r, facilityinfo i, room m
    where f.reservno = r.reservno 
        and f.facinfono = i.facinfono
         and r.roomno = m.roomno;
         
  

//���� �Ǹ���ȸ 

create or replace view v_room_sales
as
    select m.locname, m.roomtype, m.roomprice, r.ci_date 
    from reservation r,
        room m
    where r.roomno = m.roomno;
    