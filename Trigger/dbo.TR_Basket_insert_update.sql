-- Создание триггера
create trigger dbo.TR_Basket_insert_update on dbo.Basket 
after insert, update 
as 
begin
    set nocount on;

    -- Обновление DiscountValue для всех записей в Basket на основании вставленных данных
    update b
    set b.DiscountValue = 
        case 
            when cnt.[count] > 1 then b.Value * 0.05
            else 0
        end
    from dbo.Basket as b
        inner join (
        select ID_SKU, count(*) as [count]
        from inserted
        group by ID_SKU
    ) as cnt on b.ID_SKU = cnt.ID_SKU
        inner join inserted i on b.ID = i.ID;
end;

