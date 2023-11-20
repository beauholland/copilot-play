CREATE TABLE [SalesLT].[Address] (
    [AddressID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AddressLine1]  NVARCHAR (60)    NOT NULL,
    [AddressLine2]  NVARCHAR (60)    NULL,
    [City]          NVARCHAR (30)    NOT NULL,
    [StateProvince] [dbo].[Name]     NOT NULL,
    [CountryRegion] [dbo].[Name]     NOT NULL,
    [PostalCode]    NVARCHAR (15)    NOT NULL,
    [rowguid]       UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]  DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[Customer] (
    [CustomerID]   INT               IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [NameStyle]    [dbo].[NameStyle] NOT NULL,
    [Title]        NVARCHAR (8)      NULL,
    [FirstName]    [dbo].[Name]      NOT NULL,
    [MiddleName]   [dbo].[Name]      NULL,
    [LastName]     [dbo].[Name]      NOT NULL,
    [Suffix]       NVARCHAR (10)     NULL,
    [CompanyName]  NVARCHAR (128)    NULL,
    [SalesPerson]  NVARCHAR (256)    NULL,
    [EmailAddress] NVARCHAR (50)     NULL,
    [Phone]        [dbo].[Phone]     NULL,
    [PasswordHash] VARCHAR (128)     NOT NULL,
    [PasswordSalt] VARCHAR (10)      NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER  ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME          NOT NULL
);

CREATE TABLE [SalesLT].[CustomerAddress] (
    [CustomerID]   INT              NOT NULL,
    [AddressID]    INT              NOT NULL,
    [AddressType]  [dbo].[Name]     NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[Product] (
    [ProductID]              INT              IDENTITY (1, 1) NOT NULL,
    [Name]                   [dbo].[Name]     NOT NULL,
    [ProductNumber]          NVARCHAR (25)    NOT NULL,
    [Color]                  NVARCHAR (15)    NULL,
    [StandardCost]           MONEY            NOT NULL,
    [ListPrice]              MONEY            NOT NULL,
    [Size]                   NVARCHAR (5)     NULL,
    [Weight]                 DECIMAL (8, 2)   NULL,
    [ProductCategoryID]      INT              NULL,
    [ProductModelID]         INT              NULL,
    [SellStartDate]          DATETIME         NOT NULL,
    [SellEndDate]            DATETIME         NULL,
    [DiscontinuedDate]       DATETIME         NULL,
    [ThumbNailPhoto]         VARBINARY (MAX)  NULL,
    [ThumbnailPhotoFileName] NVARCHAR (50)    NULL,
    [rowguid]                UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]           DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[ProductCategory] (
    [ProductCategoryID]       INT              IDENTITY (1, 1) NOT NULL,
    [ParentProductCategoryID] INT              NULL,
    [Name]                    [dbo].[Name]     NOT NULL,
    [rowguid]                 UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]            DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[ProductDescription] (
    [ProductDescriptionID] INT              IDENTITY (1, 1) NOT NULL,
    [Description]          NVARCHAR (400)   NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL
);


CREATE TABLE [SalesLT].[ProductModel] (
    [ProductModelID]     INT                                                         IDENTITY (1, 1) NOT NULL,
    [Name]               [dbo].[Name]                                                NOT NULL,
    [CatalogDescription] XML(CONTENT [SalesLT].[ProductDescriptionSchemaCollection]) NULL,
    [rowguid]            UNIQUEIDENTIFIER                                            ROWGUIDCOL NOT NULL,
    [ModifiedDate]       DATETIME                                                    NOT NULL
);

CREATE TABLE [SalesLT].[ProductModelProductDescription] (
    [ProductModelID]       INT              NOT NULL,
    [ProductDescriptionID] INT              NOT NULL,
    [Culture]              NCHAR (6)        NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[SalesOrderDetail] (
    [SalesOrderID]       INT              NOT NULL,
    [SalesOrderDetailID] INT              IDENTITY (1, 1) NOT NULL,
    [OrderQty]           SMALLINT         NOT NULL,
    [ProductID]          INT              NOT NULL,
    [UnitPrice]          MONEY            NOT NULL,
    [UnitPriceDiscount]  MONEY            NOT NULL,
    [LineTotal]          AS               (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
    [rowguid]            UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]       DATETIME         NOT NULL
);

CREATE TABLE [SalesLT].[SalesOrderHeader] (
    [SalesOrderID]           INT                   IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RevisionNumber]         TINYINT               NOT NULL,
    [OrderDate]              DATETIME              NOT NULL,
    [DueDate]                DATETIME              NOT NULL,
    [ShipDate]               DATETIME              NULL,
    [Status]                 TINYINT               NOT NULL,
    [OnlineOrderFlag]        [dbo].[Flag]          NOT NULL,
    [SalesOrderNumber]       AS                    (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID],0),N'*** ERROR ***')),
    [PurchaseOrderNumber]    [dbo].[OrderNumber]   NULL,
    [AccountNumber]          [dbo].[AccountNumber] NULL,
    [CustomerID]             INT                   NOT NULL,
    [ShipToAddressID]        INT                   NULL,
    [BillToAddressID]        INT                   NULL,
    [ShipMethod]             NVARCHAR (50)         NOT NULL,
    [CreditCardApprovalCode] VARCHAR (15)          NULL,
    [SubTotal]               MONEY                 NOT NULL,
    [TaxAmt]                 MONEY                 NOT NULL,
    [Freight]                MONEY                 NOT NULL,
    [TotalDue]               AS                    (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
    [Comment]                NVARCHAR (MAX)        NULL,
    [rowguid]                UNIQUEIDENTIFIER      ROWGUIDCOL NOT NULL,
    [ModifiedDate]           DATETIME              NOT NULL
);



