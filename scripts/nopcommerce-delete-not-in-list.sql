
SELECT sku,name,[ProductCost],[CreatedOnUtc] into from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product
except
SELECT [BookID],[BookName],[BookPrice],isnull(createddate,'01/01/2010') createddate from Books b where b.status=1 and bookname is not null --and (b.BookID like 'rm%'  or b.BookID like 'ch%' or b.BookID like 'th%' or b.BookID like 'tm%' or b.BookID like 'in%')

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product where sku in (select sku from #inserttemp)

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityname='Product' and entityid not in
(select id from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product)

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Manufacturer_Mapping] where productid not in
(select id from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product)

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Category_Mapping] where productid not in
(select id from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product)