-- Создание представления
create view dbo.vw_SKUPrice
as
    select
        s.ID,
        s.Code,
        s.Name,
        dbo.udf_GetSKUPrice(s.ID) as SKU_Price
    from dbo.SKU as s;
