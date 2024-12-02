-- Создание таблицы SKU
create table dbo.SKU
(
    ID int not null identity(1,1),
    Code as ('s' + CAST(ID as varchar(100))),
    Name varchar(50) not null,
    constraint PK_SKU primary key (ID),
    constraint UK_SKU unique (Code)
);

go

-- Создание таблицы Family
create table dbo.Family
(
    ID int not null identity(1,1),
    SurName varchar(50) not null,
    BudgetValue decimal(18, 2) not null
    constraint PK_Family primary key (ID)
);

go

-- Создание таблицы Basket
create table dbo.Basket
(
    ID int not null identity(1,1),
    ID_SKU int not null,
    ID_Family int not null,
    Quantity int not null,
    Value decimal(18, 2) not null,
    PurchaseDate datetime not null,
    DiscountValue decimal(18, 2) not null,
    constraint PK_Basket primary key (ID)
);

go

-- Добавление огранечений для таблицы Basket
alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID);
alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID);
alter table dbo.Basket add constraint CK_Basket_Quantity check (Quantity >= 0);
alter table dbo.Basket add constraint CK_Basket_Value check (Value >= 0);
alter table dbo.Basket add constraint DF_Basket_PurchaseDate default getdate() for PurchaseDate;
alter table dbo.Basket add constraint DF_Basket_DiscountValue default (0.00) for DiscountValue;

