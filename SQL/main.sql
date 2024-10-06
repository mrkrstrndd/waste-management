IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'WasteManagement')
BEGIN
	CREATE DATABASE WasteManagement;	
END

USE WasteManagement;

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'User'))
BEGIN
	CREATE TABLE [dbo].[User](
		[UserId] [int] IDENTITY(1,1) NOT NULL,
		[Username] [nvarchar](15) NOT NULL,
		[Password] [varchar](20) NOT NULL,
		[Email] [varchar](50),
		[PhoneNumber] [varchar](15),
		[RoleId] int
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_User]'))
BEGIN5
	ALTER TABLE [User] ADD CONSTRAINT PK_User PRIMARY KEY(UserId)
END
GO


IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'Customer'))
BEGIN
	CREATE TABLE [dbo].[Customer](
		[CustomerId] [int] IDENTITY(1,1) NOT NULL,
		[Firstname] [nvarchar](15) NOT NULL,
		[Lastname] [varchar](15) NOT NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_Customer]'))
BEGIN
	ALTER TABLE [Customer] ADD CONSTRAINT PK_Customer PRIMARY KEY(CustomerId)
END
GO


IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'Address'))
BEGIN
	CREATE TABLE [dbo].[Address](
		[AddressId] [int] IDENTITY(1,1) NOT NULL,
		[Address] [varchar](100) NOT NULL,
		[Barangay] [varchar](20) NOT NULL,
		[City] [varchar] (20) NOT NULL,
		[PostalCode] [varchar](5) NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_Address]'))
BEGIN
	ALTER TABLE [Address] ADD CONSTRAINT PK_Address PRIMARY KEY(AddressId)
END
GO

IF NOT EXISTS(select 1 from sys.columns  where Name = N'CustomerId' and Object_ID = Object_ID(N'[Address]'))
BEGIN
	ALTER TABLE [Address] ADD CustomerId INT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_Customer_Address]'))
BEGIN
	ALTER TABLE [Address] ADD CONSTRAINT FK_Customer_Address FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
END
GO




IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'WasteType'))
BEGIN
	CREATE TABLE [dbo].[WasteType](
		[WasteTypeId] [int] IDENTITY(1,1) NOT NULL,
		[WasteTypename] [varchar](20) NOT NULL,
		[Description] [varchar](100) NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_WasteType]'))
BEGIN
	ALTER TABLE [WasteType] ADD CONSTRAINT PK_WasteType PRIMARY KEY(WasteTypeId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'CollectionRequest'))
BEGIN
	CREATE TABLE [dbo].[CollectionRequest](
		[RequestId] [int] IDENTITY(1,1) NOT NULL,
		[CustomerId] [int] NOT NULL,
		[WasteTypeId] [int] NOT NULL,
		[RequestDate] [datetime] NOT NULL,
		[PickupDate] [datetime] NOT NULL,
		[Status] [varchar](15) NOT NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_CollectionRequest]'))
BEGIN
	ALTER TABLE [CollectionRequest] ADD CONSTRAINT PK_CollectionRequest PRIMARY KEY(RequestId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionRequest_Customer]'))
BEGIN
	ALTER TABLE [CollectionRequest] ADD CONSTRAINT FK_CollectionRequest_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionRequest_WasteType]'))
BEGIN
	ALTER TABLE [CollectionRequest] ADD CONSTRAINT FK_CollectionRequest_WasteType FOREIGN KEY (WasteTypeId) REFERENCES WasteType(WasteTypeId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'WasteCollector'))
BEGIN
	CREATE TABLE [dbo].[WasteCollector](
		[CollectorId] [int] IDENTITY(1,1) NOT NULL,
		[UserId] [int] NOT NULL,
		[FirstName] [varchar](20) NOT NULL,
		[LastName] [varchar](20) NOT NULL,
		[PhoneNumber] [varchar](15) NOT NULL,
		[AssignedArea] [varchar](25) NOT NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_WasteCollector]'))
BEGIN
	ALTER TABLE [WasteCollector] ADD CONSTRAINT PK_WasteCollector PRIMARY KEY(CollectorId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_WasteCollector_User]'))
BEGIN
	ALTER TABLE [WasteCollector] ADD CONSTRAINT FK_WasteCollector_User FOREIGN KEY (UserId) REFERENCES [User](UserId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'Truck'))
BEGIN
	CREATE TABLE [dbo].[Truck](
		[TruckId] [int] IDENTITY(1,1) NOT NULL,
		[Trucknumber] [varchar](15) NOT NULL,
		[TruckCapacity] [varchar](10) NULL,
		[TruckStatus] [varchar](20) NOT NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_Truck]'))
BEGIN
	ALTER TABLE [Truck] ADD CONSTRAINT PK_Truck PRIMARY KEY(TruckId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'Route'))
BEGIN
	CREATE TABLE [dbo].[Route](
		[RouteId] [int] IDENTITY(1,1) NOT NULL,
		[Routename] [nvarchar](20) NOT NULL,
		[StartLocation] [varchar](20) NOT NULL,
		[EndLocation] [varchar](20) NOT NULL,
		[Distance] [varchar](20),
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_Route]'))
BEGIN
	ALTER TABLE [Route] ADD CONSTRAINT PK_Route PRIMARY KEY(RouteId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'CollectionAssignment'))
BEGIN
	CREATE TABLE [dbo].[CollectionAssignment](
		[AssignmentId] [int] IDENTITY(1,1) NOT NULL,
		[RequestId] [int] NOT NULL,
		[CollectorId] [int] NOT NULL,
		[TruckId] [int] NOT NULL,
		[RouteId] [int] NOT NULL,
		[AssignedDate] [datetime] NOT NULL,
		[PickupDate] [datetime] NOT NULL,
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_CollectionAssignment]'))
BEGIN
	ALTER TABLE [CollectionAssignment] ADD CONSTRAINT PK_CollectionAssignment PRIMARY KEY(AssignmentId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionAssignment_Request]'))
BEGIN
	ALTER TABLE [CollectionAssignment] ADD CONSTRAINT FK_CollectionAssignment_request FOREIGN KEY (RequestId) REFERENCES CollectionRequest(RequestrId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionRequest_Collector]'))
BEGIN
	ALTER TABLE [CollectionAssignment] ADD CONSTRAINT FK_CollectionAssignment_Collector FOREIGN KEY (CollectorId) REFERENCES WasteCollector(CollectorId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionRequest_Truck]'))
BEGIN
	ALTER TABLE [CollectionAssignment] ADD CONSTRAINT FK_CollectionAssignment_Truck FOREIGN KEY (TruckId) REFERENCES Truck(TruckId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionRequest_Route]'))
BEGIN
	ALTER TABLE [CollectionAssignment] ADD CONSTRAINT FK_CollectionAssignment_Route FOREIGN KEY (RouteId) REFERENCES [Route](RouteId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'WasteDisposalFacility'))
BEGIN
	CREATE TABLE [dbo].[WasteDisposalFacility](
		[FacilityId] [int] IDENTITY(1,1) NOT NULL,
		[Facilityname] [nvarchar](25) NOT NULL,
		[Location] [varchar](20) NOT NULL,
		[Capacity] [varchar](50),
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_WasteDisposalFacility]'))
BEGIN
	ALTER TABLE [WasteDisposalFacility] ADD CONSTRAINT PK_WasteDisposalFacility PRIMARY KEY(FacilityId)
END
GO

IF NOT EXISTS(select 1 from sys.all_objects  where  name = (N'DisposalRecord'))
BEGIN
	CREATE TABLE [dbo].[DisposalRecord](
		[RecordId] [int] IDENTITY(1,1) NOT NULL,
		[TruckId] [int] NOT NULL,
		[FacilityId] [int] NOT NULL,
		[WasteTypeId] [int] NOT NULL,
		[Amount] [varchar] (10) NOT NULL,
		[DisposalDate] [datetime],
	 )
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[PK_DisposalRecord]'))
BEGIN
	ALTER TABLE [DisposalRecord] ADD CONSTRAINT PK_DisposalRecord PRIMARY KEY(RecordId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposalRecord_Truck]'))
BEGIN
	ALTER TABLE [DisposalRecord] ADD CONSTRAINT FK_DisposalRecord_Truck FOREIGN KEY (TruckId) REFERENCES Truck(TruckId)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys  WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposalRecord_Facility]'))
BEGIN
	ALTER TABLE [DisposalRecord] ADD CONSTRAINT FK_DisposalRecord_Facility FOREIGN KEY (FacilityId) REFERENCES WasteDisposalFacility(FacilityId)
END
GO