

    create table tb_business (
       id int8 generated by default as identity,
        address varchar(255),
        name varchar(255),
        points float8 not null,
        tribute float8 not null,
        website varchar(255),
        user_id int8,
        primary key (id)
    );

    create table tb_business_product (
       id_business int8 not null,
        id_product int8 not null,
        primary key (id_business, id_product)
    );

    create table tb_doacao (
       id int8 generated by default as identity,
        momento timestamp,
        pontos float8 not null,
        business_id int8,
        order_id int8,
        primary key (id)
    );

    create table tb_ong (
       id int8 generated by default as identity,
        address varchar(255),
        cnpj varchar(255),
        name varchar(255),
        user_id int8,
        primary key (id)
    );

    create table tb_order_item (
       id int8 generated by default as identity,
        moment timestamp,
        ong_id int8,
        primary key (id)
    );

    create table tb_order_product (
       order_id int8 not null,
        product_id int8 not null,
        primary key (order_id, product_id)
    );

    create table tb_permission (
       id int8 generated by default as identity,
        description varchar(255),
        primary key (id)
    );

    create table tb_product (
       id int8 generated by default as identity,
        description varchar(255),
        due_date timestamp not null,
        image_uri varchar(255),
        name varchar(255),
        status varchar(255),
        primary key (id)
    );

    create table tb_userman (
       id int8 generated by default as identity,
        password varchar(255),
        username varchar(255),
        primary key (id)
    );

    create table user_permission (
       id_user int8 not null,
        id_permission int8 not null
    );

    alter table if exists tb_userman 
       add constraint UK_klxfntb6c2gomskcwrgq3bav1 unique (username);

    alter table if exists tb_business 
       add constraint FKpu6yu2ggmw99wsq9bahu01qrx 
       foreign key (user_id) 
       references tb_userman;

    alter table if exists tb_business_product 
       add constraint FKqtxr8ptcpbjau2yn68bpcioa4 
       foreign key (id_product) 
       references tb_product;

    alter table if exists tb_business_product 
       add constraint FKpcabquvaf9pp12i5kjcvt4g4a 
       foreign key (id_business) 
       references tb_business;

    alter table if exists tb_doacao 
       add constraint FKhynq70f6p8mfmusbcgfcyx5e 
       foreign key (business_id) 
       references tb_business;

    alter table if exists tb_doacao 
       add constraint FKfcuasgmorhcwb37j798lnpmek 
       foreign key (order_id) 
       references tb_order_item;

    alter table if exists tb_ong 
       add constraint FKk7n6m6vh7kw5r5u0c5pq5u14u 
       foreign key (user_id) 
       references tb_userman;

    alter table if exists tb_order_item 
       add constraint FKj72bm0wi2sugbmeh4y3eueb40 
       foreign key (ong_id) 
       references tb_ong;

    alter table if exists tb_order_product 
       add constraint FKsu03ywlcvyqg5y78qey2q25lc 
       foreign key (product_id) 
       references tb_product;

    alter table if exists tb_order_product 
       add constraint FKdpiyh88kg4tgc9is1cea3p0lr 
       foreign key (order_id) 
       references tb_order_item;

    alter table if exists user_permission 
       add constraint FK97s1m4j6o9m778dt672ipraq6 
       foreign key (id_permission) 
       references tb_permission;

    alter table if exists user_permission 
       add constraint FKeb2moc9q5y0kb77r5jn4djcqe 
       foreign key (id_user) 
       references tb_userman;
