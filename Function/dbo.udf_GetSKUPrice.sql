
-- Создание функции
create function dbo.udf_GetSKUPrice(
		@ID_SKU int
)
returns decimal(18, 2)
as
begin
    declare @GetSKUPrice decimal(18,2)

    select @GetSKUPrice = sum(b.Value) / sum(b.Quantity)
    from dbo.Basket as b
    where @ID_SKU = ID_SKU

    return @GetSKUPrice
end;