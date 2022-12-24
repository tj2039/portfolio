package com.moon.room.model;

/* 지점 객실 정보
CREATE TABLE Room (
	roomNo NUMBER NOT NULL, 
	locName VARCHAR2(50) NOT NULL, 
	roomType VARCHAR2(50) NOT NULL, 
	roomPrice NUMBER NOT NULL, 
	roomImage VARCHER2(100) NOT NULL, 
	roomCount NUMBER NOT NULL 
);

create sequence Room_seq
increment by 1
start with 1
nocache;

insert into locInfo(roomNo, locName, roomType, roomPrice, roomImage, roomCount)
values(locInfo_seq.nextval, 'Full Moon', '디럭스', 240000, 'dex.png', 10); 
insert into locInfo(roomNo, locName, roomType, roomPrice roomImage, roomCount)
values(locInfo_seq.nextval, 'Full Moon', '슈페리어', 280000, 'spr.png', 8); 
insert into locInfo(roomNo, locName, roomType, roomPrice roomImage, roomCount)
values(locInfo_seq.nextval, 'Full Moon', '스위트', 400000, 'room-suite.png', 5); 
insert into locInfo(roomNo, locName, roomType, roomPrice roomImage, roomCount)
values(locInfo_seq.nextval, 'Full Moon', '모노그램스위트', 550000, 'monogram.png', 2);  
*/ 



public class RoomVO {
	private int roomNo; //객실정보번호
	private String locName; //지점명
	private String roomType; //객실 타입
	private int roomPrice; //객실 가격
	private String roomImage; //객실 이미지
	private int roomCount; //객실 수
	
	public RoomVO() {
		super();
	}

	public RoomVO(int roomNo, String locName, String roomType, int roomPrice, String roomImage, int roomCount) {
		super();
		this.roomNo = roomNo;
		this.locName = locName;
		this.roomType = roomType;
		this.roomPrice = roomPrice;
		this.roomImage = roomImage;
		this.roomCount = roomCount;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getLocName() {
		return locName;
	}

	public void setLocName(String locName) {
		this.locName = locName;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public int getRoomPrice() {
		return roomPrice;
	}

	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}

	public String getRoomImage() {
		return roomImage;
	}

	public void setRoomImage(String roomImage) {
		this.roomImage = roomImage;
	}

	public int getRoomCount() {
		return roomCount;
	}

	public void setRoomCount(int roomCount) {
		this.roomCount = roomCount;
	}

	@Override
	public String toString() {
		return "RoomVO [roomNo=" + roomNo + ", locName=" + locName + ", roomType=" + roomType + ", roomPrice="
				+ roomPrice + ", roomImage=" + roomImage + ", roomCount=" + roomCount + "]";
	}
	
}
