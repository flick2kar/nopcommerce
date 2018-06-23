select * from country
select * from currency
select * from topic
select * from Category
select * from product where id=18169
select * from picture
select * from MessageTemplate
select * from store
select * from Manufacturer
select * from MessageTemplate where body like '%manufa%'
select * from LocaleStringResource where resourcevalue like '%manufa%'
select * from ecrbookl_nop_log 

--DBCC SHRINKFILE(N'ecrbookl_nop_log ', 4096); 
--update country set allowsbilling=0,allowsshipping=0,published=0 where id!=42

--update country set displayorder=1 where id=42

--update currency set published=0 where id!=12
--update currency set published=1 where id=12
--update topic set published=1 where id not in (3,11)
--update topic set published=0 where id in (3,11)
--update topic set IncludeInTopMenu=0 where id not in (1)
--UPDATE LocaleStringResource
--SET resourcevalue = REPLACE(resourcevalue, 'manufacturer', 'author')
--WHERE resourcevalue like '%manufacturer%'
--delete from category where id not in (14)
--delete from giftcard
--delete from RelatedProduct
--delete from ProductAttribute
--delete from Picture
--delete from Product_Category_Mapping
--delete from Product
--delete from PredefinedProductAttributeValue
--delete from Product_Picture_Mapping
--delete from Product_ProductAttribute_Mapping
--delete from PredefinedProductAttributeValue
--delete from Product_ProductTag_Mapping
--delete from Product_SpecificationAttribute_Mapping
--delete from ProductReview
--delete from ProductReviewHelpfulness


----Schema Changes
--alter table [dbo].[Manufacturer] add offauthorid int
--ALTER TABLE product ALTER COLUMN sku nvarchar(800) COLLATE SQL_Latin1_General_CP1_CI_AS
--ALTER TABLE product ALTER COLUMN name nvarchar(800) COLLATE SQL_Latin1_General_CP1_CI_AS

--update urlrecord set Slug=replace(replace(replace(Slug,' ','-'),'.','-'),'&','And') where slug like '%.%' or slug like '%&%' or slug like '% %'
--update product set name=replace(name,' ','-') where id=10426 name like '%sivakami%'
--drop table #prodid
--delete from urlrecord where entityid in (select id from #prodid)
--delete from Product_Category_Mapping where ProductId in (select id from #prodid)
--delete from Product_Manufacturer_Mapping where ProductId in (select id from #prodid)
--delete from Product where Id in (select id from #prodid)
select id into #prodid from product where name is NULL
select * from urlrecord where entityid in (select id from #prodid)
select * from Product_Category_Mapping where ProductId in (select id from #prodid)
select * from Product_Manufacturer_Mapping where ProductId in (select id from #prodid)

drop table #entity
select max(entityid) entityid,slug,count(slug) cnt into #entity from urlrecord group by slug having count(slug)>1
delete from urlrecord where entityid in (
select entityid from #entity)

select * from #entity

select max(entityid),slug,count(slug) from urlrecord group by slug having count(slug)>1
slug like '%.%' or slug like '%&%' or slug like '% %'

select * from product where name like '%alice%'
select * from urlrecord where entityid in (
select max(entityid) from urlrecord group by slug having count(slug)>1) order by slug desc
select max(id),name,count(name) from product group by name having count(name)>1 order by name desc
select max(entityid) from urlrecord group by slug having count(slug)>1
select * from urlrecord where slug like '%alice%'

select id,name,sku into #prodtemp from product where id in
(select id from product
except
select entityid from urlrecord)

Insert into [ecrbookl_nop].[dbo].[UrlRecord] 
([EntityId]
           ,[EntityName]
           ,[Slug]
           ,[IsActive]
           ,[LanguageId])

SELECT Id,'Product',replace(replace(replace(Name,' ','-'),'.','-'),'&','And')+'-'+sku,1,0 from #prodtemp
select * from #prodtemp

select * from urlrecord where entityname='Product' and entityid not in (select id from product)