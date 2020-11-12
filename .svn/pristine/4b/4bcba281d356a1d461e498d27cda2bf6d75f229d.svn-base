drop table tb_machine
drop table tb_member;
drop table tb_notice;
drop table tb_file;
drop table tb_contents;

create table tb_member (
	id							varchar2(20)		primary key,
	pw						varchar2(20)		not null,
	name					varchar2(20)		not null,
	department		varchar2(100),
	phone					varchar2(20),
	office_phone		varchar2(20),
	office_address	varchar2(200),
	division				varchar2(10),						-- 구분 : 광고주 : 02, 매체(광고대행) : 01, admin : 00
	isDel					char(1)				default 'N'
);

create table tb_advertiser (
	advertiser_num		number(11)				primary key,
	advertiser_name	varchar2(50)		not null,
	advertiser_info		varchar2(2000)	not null,
	member_id				varchar2(20)	not null,
	isDel					char(1)				default 'N',
	constraint fk_advertiser foreign key(member_id) references tb_member(id)	
);

create table tb_file (
	file_num					number				primary key,
	file_name				varchar2(100)		not null,
	real_file_name		varchar2(100)		not null,
	file_content			varchar2(2000),
	add_date				date						not null,
	member_id				varchar2(20)		not null,
	isDel						char(1)				default 'N',
	constraint fk_file foreign key(member_id) references tb_member(id)
);

create table tb_contents (
	contents_num			number					primary key,
	contents_title			varchar2(100)		not null,
	contents_content	varchar2(2000)	not null,
	add_date					date						not null,
	member_id				varchar2(20)		not null,
	advertiser_num		number(11)			not null,
	isDel							char(1)					default 'N',
	constraint fk_contents foreign key(member_id) references tb_member(id)
);

create table tb_layer (
	layer_num				number				primary key,
	layer_id					varchar2(100)		not null,
	layer_width			number				not null,
	layer_height			number				not null,
	layer_x					number				not null,
	layer_y					number				not null,
	layer_background	varchar2(100)		not null,
	layer_priority			number				not null,
	contents_num		number				not null,
	layer_file_num			number,
	layer_text				varchar2(1000),
	constraint fk_layer_content foreign key(contents_num) references tb_contents(contents_num),
	constraint fk_layer_img foreign key(layer_file_num) references tb_file(file_num)
);

create table tb_schedule (
	num									number				primary key,
	schedule_date				date						not null,
	schedule_start_time		number				not null,  
	machine_num				varchar2(25)		not null,
	contents_num				number					not null,
	member_id					varchar2(20)		not null,
	isDel								char(1)				default 'N',
	constraint fk_schedule_contents foreign key(contents_num) references tb_contents(contents_num),
	constraint fk_schedule_machine foreign key(machine_num) references tb_machine(machine_num)
);

drop table tb_schedule;

create table tb_machine (
	machine_num				varchar2(25)		primary key,  
	install_date						date						not null,
	machine_type				varchar2(25)		not null,
	installed_place				varchar2(100)		not null,
	isDel								char(1)				default 'N'
	location_x 					varchar2(20),
	location_y					varchar2(20),
	location_type				varchar(100),
);

create table tb_notice (
	notice_num									number				primary key,
	notice_title						varchar2(100)		not null,
	notice_content				varchar2(2000)	not null,
	add_date						date						not null,
	member_id						varchar2(20)		not null,
	hit									number				default 0,
	isDel								char(1)				default 'N',
	constraint fk_notice foreign key(member_id) references tb_member(id)
);

create sequence notice_seq
increment by 1
start with 1;

create sequence file_seq
increment by 1
start with 1;

create sequence contents_seq
increment by 1
start with 1;

create sequence layer_seq
increment by 1
start with 1;

create sequence schedule_seq
increment by 1
start with 1;


select *
from 		tb_schedule s
where		machine_num = '2020-01-13-002'
and			schedule_date = '2020-02-12'
and			schedule_start_time = (select 		min(schedule_start_time)
														from 		tb_schedule s
														where		machine_num = '2020-01-13-002'
														and			schedule_date = '2020-02-12'
														and			schedule_start_time > '28');
														
delete from tb_schedule;										
update tb_machine
set		isDel = 'N';

select * from tb_schedule;
select * from tb_contents;
select * from tb_layer;
select * from tb_file;



 /*
	 1. 컨텐츠번호			--FK
	 2. 머신번호	  	    --FK
	 3. 월(month) 
	 4. 일자 (day)
	 5. hour 
	 6. 광고횟수
	 7. 스페셜 스케줄여부 
	-- 8. 멤버 id 		--FK 
	-- 9.   
 */
CREATE TABLE tb_statistics(  
	 ST_NUM INT(11) NOT NULL
	,ST_CONT_NUM INT(11) NOT NULL    
	,ST_MAC_NUM VARCHAR(25) NOT NULL COLLATE 'utf8_general_ci' 
	,ST_MONTH VARCHAR(04) COLLATE 'utf8_general_ci'
    ,ST_DAY  DATE
    ,ST_HOUR VARCHAR(04) COLLATE 'utf8_general_ci'
    ,ST_NUM_OF_ADS INT(11) DEFAULT 0 
    ,ST_SP_YN CHAR(1) DEFAULT 'N' COLLATE 'utf8_general_ci' 
    ,PRIMARY KEY(ST_NUM) USING BTREE
 )
 COLLATE='utf8_general_ci'
 ;

/*
 * Machine 내 분사 옵션 추가
 * */
ALTER TABLE tb_machine ADD detail_place varchar(20);  		   -- 상세주소
ALTER TABLE tb_machine ADD injectionTime_BT INT(3) DEFAULT 0;  -- 부팅시 분사시간
ALTER TABLE tb_machine ADD unusedTime INT(3) DEFAULT 0;		   -- 미사용 설정시간  
ALTER TABLE tb_machine ADD injectionTime_UUT INT(3) DEFAULT 0; -- 미사용 분사시간
ALTER TABLE tb_machine ADD usedTimes INT(3) DEFAULT 0; 		   -- 사용시 세척 사용횟수 
ALTER TABLE tb_machine ADD injectionTime_UT INT(3) DEFAULT 0;  -- 사용시 분사시간 


