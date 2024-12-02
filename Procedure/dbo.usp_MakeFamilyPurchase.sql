-- Создание процедуры
create procedure dbo.usp_MakeFamilyPurchase(
    @FamilySurName varchar(255)
)
as
begin
    declare @Total decimal(18, 2)

    -- Проверяем, существует ли семья с указанной фамилией
    if not exists (select 1
        from dbo.Family
        where SurName = @FamilySurName)
    begin
        raiserror('Такой семьи нет', 16, 1)
        return
    end

    -- Если семья существует, рассчитываем сумму значений из таблицы Basket
    select @Total = sum(b.Value - b.DiscountValue)
    from dbo.Basket as b
        inner join dbo.Family f on b.ID_Family = f.ID
    where f.SurName = @FamilySurName;

    -- Если сумма для нахождениe равна 0, можно обновить BudgetValue на то же значение
    if @Total is null 
    begin
        set @Total = 0;
    end

    update dbo.Family 
    set BudgetValue = BudgetValue - @Total 
    where SurName = @FamilySurName;
end;

