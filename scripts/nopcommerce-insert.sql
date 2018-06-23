BEGIN TRAN;
--drop table #insertable;
--drop table #prodtemp;
SELECT [BookID],[BookName],[BookPrice],isnull(createddate,'01/01/2010') createddate into #insertable from Books b where b.status=1 and (b.BookID like 'rm%'  or b.BookID like 'ch%' or b.BookID like 'th%' or b.BookID like 'tm%' or b.BookID like 'in%')  and bookname is not null
except
SELECT sku,name,[ProductCost],[CreatedOnUtc] from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product --where [Published]=1
COMMIT TRAN;
---delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product where updatedonutc='2018-03-16 10:29:31.633'
--BEGIN TRAN;
delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product where sku in (select bookid from #insertable)
--select * from books where bookid='AD0002'

INSERT INTO [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product
           ([ProductTypeId]
           ,[ParentGroupedProductId]
           ,[VisibleIndividually]
           ,[Name]
           ,[ShortDescription]
           ,[FullDescription]
           ,[AdminComment]
           ,[ProductTemplateId]
           ,[VendorId]
           ,[ShowOnHomePage]
           ,[MetaKeywords]
           ,[MetaDescription]
           ,[MetaTitle]
           ,[AllowCustomerReviews]
           ,[ApprovedRatingSum]
           ,[NotApprovedRatingSum]
           ,[ApprovedTotalReviews]
           ,[NotApprovedTotalReviews]
           ,[SubjectToAcl]
           ,[LimitedToStores]
           ,[Sku]
           ,[ManufacturerPartNumber]
           ,[Gtin]
           ,[IsGiftCard]
           ,[GiftCardTypeId]
           ,[OverriddenGiftCardAmount]
           ,[RequireOtherProducts]
           ,[RequiredProductIds]
           ,[AutomaticallyAddRequiredProducts]
           ,[IsDownload]
           ,[DownloadId]
           ,[UnlimitedDownloads]
           ,[MaxNumberOfDownloads]
           ,[DownloadExpirationDays]
           ,[DownloadActivationTypeId]
           ,[HasSampleDownload]
           ,[SampleDownloadId]
           ,[HasUserAgreement]
           ,[UserAgreementText]
           ,[IsRecurring]
           ,[RecurringCycleLength]
           ,[RecurringCyclePeriodId]
           ,[RecurringTotalCycles]
           ,[IsRental]
           ,[RentalPriceLength]
           ,[RentalPricePeriodId]
           ,[IsShipEnabled]
           ,[IsFreeShipping]
           ,[ShipSeparately]
           ,[AdditionalShippingCharge]
           ,[DeliveryDateId]
           ,[IsTaxExempt]
           ,[TaxCategoryId]
           ,[IsTelecommunicationsOrBroadcastingOrElectronicServices]
           ,[ManageInventoryMethodId]
           ,[ProductAvailabilityRangeId]
           ,[UseMultipleWarehouses]
           ,[WarehouseId]
           ,[StockQuantity]
           ,[DisplayStockAvailability]
           ,[DisplayStockQuantity]
           ,[MinStockQuantity]
           ,[LowStockActivityId]
           ,[NotifyAdminForQuantityBelow]
           ,[BackorderModeId]
           ,[AllowBackInStockSubscriptions]
           ,[OrderMinimumQuantity]
           ,[OrderMaximumQuantity]
           ,[AllowedQuantities]
           ,[AllowAddingOnlyExistingAttributeCombinations]
           ,[NotReturnable]
           ,[DisableBuyButton]
           ,[DisableWishlistButton]
           ,[AvailableForPreOrder]
           ,[PreOrderAvailabilityStartDateTimeUtc]
           ,[CallForPrice]
           ,[Price]
           ,[OldPrice]
           ,[ProductCost]
           ,[CustomerEntersPrice]
           ,[MinimumCustomerEnteredPrice]
           ,[MaximumCustomerEnteredPrice]
           ,[BasepriceEnabled]
           ,[BasepriceAmount]
           ,[BasepriceUnitId]
           ,[BasepriceBaseAmount]
           ,[BasepriceBaseUnitId]
           ,[MarkAsNew]
           ,[MarkAsNewStartDateTimeUtc]
           ,[MarkAsNewEndDateTimeUtc]
           ,[HasTierPrices]
           ,[HasDiscountsApplied]
           ,[Weight]
           ,[Length]
           ,[Width]
           ,[Height]
           ,[AvailableStartDateTimeUtc]
           ,[AvailableEndDateTimeUtc]
           ,[DisplayOrder]
           ,[Published]
           ,[Deleted]
           ,[CreatedOnUtc]
           ,[UpdatedOnUtc])
     --VALUES
           select 5,0,1,BookName,'Short desc','<p>full description</p>',NULL,1,0,0,NULL,NULL,NULL,1,0,0,0,0,0,0,Bookid,NULL,NULL,0,0,NULL,0,NULL,0,0,0,1,10,NULL,0,0,0,0,NULL,0,100,0,10,1,15,0,0,1,0,0.0000,0,0,0,0,0,0,0,0,10000,0,0,0,0,1,0,0,1,10000,NULL,0,0,0,0,0,NULL,0,round(bookprice*12/100,0),0.0000,BookPrice,0,0.0000,1000.0000,0,0.0000,1,0.0000,1,0,NULL,NULL,0,0,0.0000,0.0000,0.0000,0.0000,NULL,NULL,0,1,0,isnull(createddate,'01/01/2010'),GETDATE()
		   from #insertable
GO
select  id,name,sku into #prodtemp from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product inner join  #insertable on sku=bookid

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityid in (select id from #prodtemp)

Insert into [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] 
([EntityId]
           ,[EntityName]
           ,[Slug]
           ,[IsActive]
           ,[LanguageId])

SELECT Id,'Product',replace(replace(replace(Name,' ','-'),'.','-'),'&','And')+'-'+sku,1,0 from #prodtemp


delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Manufacturer_Mapping] where [ProductId] in (select id from #prodtemp)

INSERT INTO [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Manufacturer_Mapping]
           ([ProductId]
           ,[ManufacturerId]
           ,[IsFeaturedProduct]
           ,[DisplayOrder])
     Select p.id,m.id,0,1 from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Product p inner join  #insertable i on p.sku=i.bookid inner join books b on b.BookID=i.BookID inner join [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Manufacturer m on b.authorid=m.offauthorid
GO

delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Category_Mapping] where [ProductId] in (select distinct id from #prodtemp)
INSERT INTO [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Category_Mapping]
           ([ProductId]
           ,[CategoryId]
           ,[IsFeaturedProduct]
           ,[DisplayOrder])
     select p.id,c.id,0,1 from #prodtemp p inner join [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Category c on c.metakeywords=SUBSTRING(p.sku,0,3)

--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Manufacturer_Mapping] where [ProductId]=21987
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[Product_Category_Mapping] where [ProductId]=21987
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].Manufacturer where id=1303
--select SUBSTRING(bookid,0,3) from books where bookid like 'H%'
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].category 
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].product where name like '%faraway%' 
--select * from #insertable
--delete from drop table #insertable
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityname like '%product%' and slug like '%faraway%'
--select * from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityname like '%manu%' and slug like '%rowling%'
--delete from  [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where entityname like '%product%' and (slug not like '%bloodline%' and not slug like '%stone-bull%')
--COMMIT TRAN;

--select min(entityid) id into #prodid from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] group by slug having count(slug)>1
--update [120.138.8.94, 14433].[ecrbookl_nop].[dbo].UrlRecord set isactive=0 where entityid in 
--(select distinct id from #prodid)
--delete from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].UrlRecord where isactive=0 and entityid in 
--(select distinct id from #prodid)
--select entityid,slug from [120.138.8.94, 14433].[ecrbookl_nop].[dbo].[UrlRecord] where slug like '%yummy%'

