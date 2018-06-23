--drop table #insauth
select authorid,replace(authorname,' ','-') authorname into #insauth from authors
except
SELECT offauthorid,replace(Name,' ','-') from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].manufacturer 

INSERT INTO [120.138.8.94, 14433].[ecrbookl_nop].[dbo].manufacturer 
           ([Name]
           ,[Description]
           ,[ManufacturerTemplateId]
           ,[MetaKeywords]
           ,[MetaDescription]
           ,[MetaTitle]
           ,[PictureId]
           ,[PageSize]
           ,[AllowCustomersToSelectPageSize]
           ,[PageSizeOptions]
           ,[PriceRanges]
           ,[SubjectToAcl]
           ,[LimitedToStores]
           ,[Published]
           ,[Deleted]
           ,[DisplayOrder]
           ,[CreatedOnUtc]
           ,[UpdatedOnUtc]
           ,[offauthorid])
		 select authorname,'',1,NULL,NULL,NULL,0,6,1,'6,3,9',NULL,0,0,1,0,1,getdate(),getdate(),authorid from #insauth



select id into #insent from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].manufacturer
except
SELECT [EntityId] from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityname='Manufacturer'

INSERT INTO [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord]
           ([EntityId]
           ,[EntityName]
           ,[Slug]
           ,[IsActive]
           ,[LanguageId])
     
select id,'Manufacturer',replace(replace(replace(Name,' ','-'),'.','-'),'&','And'),1,0 from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].manufacturer
where id in (select id from #insent)

select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].manufacturer where id in (select id from #insent)

