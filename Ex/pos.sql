show databases;

drop table category;
drop table menu;

create table category(
	category_id			int				primary key			auto_increment,
    category_name		varchar(100) 	not null,
    emoji				varchar(50)
);

create table menu(
	menu_id			int				primary key,
    menu_name		varchar(100)	not null,
    menu_price		int				not null,
    category_id		int,
    CONSTRAINT menu_fk FOREIGN KEY (category_id)
	REFERENCES category(category_id)
);


create table orders(  -- order는 예약어라서 안됨
	order_id		int			primary key		auto_increment,
	table_number	int			not null,
    order_time		datetime	default	 	now()
);

create table order_food(
	food_id 		int				primary key		auto_increment,
    order_id		int,
    menu_id			int,
    quantity		int				not null,
    payment_status	varchar(20)		default		'미결제',
    CONSTRAINT order_food_fk_order FOREIGN KEY (order_id)
	REFERENCES orders(order_id),
    CONSTRAINT order_food_fk_menu FOREIGN KEY (menu_id)
	REFERENCES menu(menu_id)
);

