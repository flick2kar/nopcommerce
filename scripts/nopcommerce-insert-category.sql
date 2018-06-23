INSERT INTO [ecrbookl_nop].[dbo].[UrlRecord]
           ([EntityId]
           ,[EntityName]
           ,[Slug]
           ,[IsActive]
           ,[LanguageId])
     SELECT Id,'Category',replace(Name,' ','-'),1,0 from [ecrbookl_nop].[dbo].category
GO
select * from [ecrbookl_nop].[dbo].[UrlRecord]

--delete from [ecrbookl_nop].[dbo].[UrlRecord] where entityname='Category'

--update [ecrbookl_nop].[dbo].category set showonhomepage=1