
CREATE DATABASE WebShopDB
GO


/****** Object:  User [AlmightyUser]    Script Date: 17-Dec-19 8:52:41 AM ******/
USE master;
CREATE LOGIN DBAdmin WITH PASSWORD = 'StrongPassword123';
CREATE LOGIN DBReaderFull WITH PASSWORD = 'StrongPassword123';
USE WebShopDB;
CREATE USER ReaderUser FOR LOGIN DBReaderFull;
CREATE USER AlmightyUser FOR LOGIN DBAdmin;
EXEC sp_addrolemember 'db_datareader', 'ReaderUser';
EXEC sp_addrolemember 'db_owner', 'AlmightyUser';
GO


/****** Object:  Table [dbo].[TRating]    Script Date: 17-Dec-19 8:52:42 AM ******/
USE WebShopDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProductHistory](
	[nProductId] [int] NOT NULL,
	[cName] [varchar](50) NOT NULL,
	[cDescription] [varchar](160) NOT NULL,
	[nUnitPrice] [decimal](5, 2) NOT NULL,
	[nStock] [int] NOT NULL,
	[nAvgRating] [decimal](2, 1) NULL,
	[SysStartTime] [datetime2](7) NOT NULL,
	[SysEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_TProductHistory]    Script Date: 16-Dec-19 1:39:20 PM ******/
CREATE CLUSTERED INDEX [ix_TProductHistory] ON [dbo].[TProductHistory]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TProduct]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TProduct](
	[nProductId] [int] IDENTITY(1,1) NOT NULL,
	[cName] [varchar](50) NOT NULL,
	[cDescription] [varchar](160) NOT NULL,
	[nUnitPrice] [decimal](5, 2) NOT NULL,
	[nStock] [int] NOT NULL,
	[nAvgRating] [decimal](2, 1) NULL,
	[SysStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nProductId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[TProductHistory] )
)
GO
/****** Object:  Table [dbo].[TRatingHistory]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRatingHistory](
	[nRatingId] [int] NOT NULL,
	[nProductId] [int] NOT NULL,
	[nUserId] [int] NOT NULL,
	[nRating] [int] NULL,
	[cComment] [text] NULL,
	[SysStartTime] [datetime2](7) NOT NULL,
	[SysEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [ix_TRatingHistory]    Script Date: 16-Dec-19 1:39:20 PM ******/
CREATE CLUSTERED INDEX [ix_TRatingHistory] ON [dbo].[TRatingHistory]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRating]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRating](
	[nRatingId] [int] IDENTITY(1,1) NOT NULL,
	[nProductId] [int] NOT NULL,
	[nUserId] [int] NOT NULL,
	[nRating] [int] NULL,
	[cComment] [text] NULL,
	[SysStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK__TRating__224FE26B0CBB8A30] PRIMARY KEY CLUSTERED 
(
	[nRatingId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[TRatingHistory] )
)
GO
/****** Object:  Table [dbo].[TAuditCreditCard]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAuditCreditCard](
	[nTAuditCreditCardId] [int] IDENTITY(1,1) NOT NULL,
	[before_nCreditCardId] [int] NULL,
	[before_nUserId] [int] NULL,
	[before_cIBANCode] [varchar](16) NULL,
	[before_dExpDate] [varchar](4) NULL,
	[before_nCcv] [varchar](3) NULL,
	[before_cCardholderName] [varchar](40) NULL,
	[before_nAmountSpent] [decimal](6, 2) NULL,
	[after_nCreditCardId] [int] NULL,
	[after_nUserId] [int] NULL,
	[after_cIBANCode] [varchar](34) NULL,
	[after_dExpDate] [varchar](4) NULL,
	[after_nCcv] [varchar](3) NULL,
	[after_cCardholderName] [varchar](40) NULL,
	[after_nAmountSpent] [decimal](6, 2) NULL,
	[cStatementType] [varchar](10) NULL,
	[dtExecutedAt] [datetime] NULL,
	[nDBMSId] [int] NULL,
	[cDBMSName] [nvarchar](128) NULL,
	[cHostId] [char](8) NULL,
	[cHostName] [nvarchar](128) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TAuditUser]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAuditUser](
	[nTAuditUserId] [int] IDENTITY(1,1) NOT NULL,
	[before_nUserId] [int] NULL,
	[before_cFirstName] [varchar](20) NULL,
	[before_cSurname] [varchar](20) NULL,
	[before_cAddress] [varchar](60) NULL,
	[before_cPhoneNo] [varchar](8) NULL,
	[before_nCityId] [int] NULL,
	[before_cEmail] [varchar](60) NULL,
	[before_nTotalAmount] [decimal](10, 2) NULL,
	[after_nUserId] [int] NULL,
	[after_cFirstName] [varchar](20) NULL,
	[after_cSurname] [varchar](20) NULL,
	[after_cAddress] [varchar](60) NULL,
	[after_cPhoneNo] [varchar](8) NULL,
	[after_nCityId] [int] NULL,
	[after_cEmail] [varchar](60) NULL,
	[after_nTotalAmount] [decimal](10, 2) NULL,
	[cStatementType] [varchar](10) NULL,
	[dtExecutedAt] [datetime] NULL,
	[nDBMSId] [int] NULL,
	[cDBMSName] [nvarchar](128) NULL,
	[cHostId] [char](8) NULL,
	[cHostName] [nvarchar](128) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCity]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCity](
	[nCityId] [int] IDENTITY(1,1) NOT NULL,
	[cCityName] [varchar](25) NULL,
	[cZipCode] [varchar](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[nCityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TCreditCard]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCreditCard](
	[nCreditCardId] [int] IDENTITY(1,1) NOT NULL,
	[nUserId] [int] NULL,
	[nIBANCode] [varchar](16) NOT NULL,
	[dExpDate] [varchar](4) NOT NULL,
	[nCcv] [varchar](3) NULL,
	[cCardholderName] [varchar](40) NOT NULL,
	[nAmountSpent] [decimal](6, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nCreditCardId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TInvoice]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TInvoice](
	[nInvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[nUserId] [int] NULL,
	[nCreditCardId] [int] NULL,
	[nTax] [decimal](4, 2) NOT NULL,
	[nTotalAmount] [decimal](10, 2) NULL,
	[nDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nInvoiceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TInvoiceLine]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TInvoiceLine](
	[nInvoiceLineId] [int] IDENTITY(1,1) NOT NULL,
	[nInvoiceId] [int] NULL,
	[nProductId] [int] NULL,
	[nQuantity] [int] NOT NULL,
	[nUnitPrice] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[nInvoiceLineId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TUser]    Script Date: 16-Dec-19 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUser](
	[nUserId] [int] IDENTITY(1,1) NOT NULL,
	[cFirstName] [varchar](20) NOT NULL,
	[cSurname] [varchar](20) NOT NULL,
	[cAddress] [varchar](60) NOT NULL,
	[cPhoneNo] [varchar](8) NOT NULL,
	[cEmail] [varchar](60) NOT NULL,
	[nTotalAmount] [decimal](10, 2) NULL,
	[nCityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[nUserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[TCity] ON 
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (1, N'Copenhagen', N'2150')
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (2, N'Aarhus', N'8000')
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (3, N'Roskilde', N'4000')
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (4, N'Helsingør', N'3000')
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (5, N'Hvalsø', N'4330')
INSERT [dbo].[TCity] ([nCityId], [cCityName], [cZipCode]) VALUES (6, N'Odense', N'5000')
SET IDENTITY_INSERT [dbo].[TCity] OFF

SET IDENTITY_INSERT [dbo].[TProduct] ON 
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (1, N'testProduct', N'SOme Description', CAST(15.20 AS Decimal(5, 2)), 10, CAST(3.3 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (2, N'Sweatpants with Side Stripes', N'In sagittis dui vel nisl.', CAST(67.97 AS Decimal(5, 2)), 15, CAST(2 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (3, N'Skinny Regular Ankle Jeans', N'In tempor, turpis nec euismod scelerisque.', CAST(15.50 AS Decimal(5, 2)), 10, CAST(0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (4, N'Sweatshirt', N'Integer non velit.', CAST(61.04 AS Decimal(5, 2)), 15, CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (5, N'Wool-blend Coat', N'Nullam varius.', CAST(66.66 AS Decimal(5, 2)), 18, CAST(2.6 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (6, N'Pajamas', N'Vivamus metus arcu, adipiscing molestie, hendrerit atnisl.', CAST(26.62 AS Decimal(5, 2)), 7, CAST(4.6 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (7, N'Cashmere Scarf', N'Morbi vel lectus in quam fringilla rhoncus.', CAST(55.19 AS Decimal(5, 2)), 6, CAST(5 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (8, N'Hooded Sweatshirt', N'Fusce posuere felis sed lacus.', CAST(55.07 AS Decimal(5, 2)), 18, CAST(2.3 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (9, N'T-Shirt', N'Ut tellus.', CAST(36.95 AS Decimal(5, 2)), 8, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (10, N'Woolen Jacket', N'Proin eu mi.', CAST(11.87 AS Decimal(5, 2)), 6, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (11, N'Soft Slippers', N'Fusce consequat.', CAST(3.74 AS Decimal(5, 2)), 9, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (12, N'Loafers', N'Integer a nibh.', CAST(17.01 AS Decimal(5, 2)), 6, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (13, N'Sneakers', N'Duis bibendum.', CAST(78.13 AS Decimal(5, 2)), 17, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (14, N'Long-sleeved Blouse', N'Donec ut dolor.', CAST(75.15 AS Decimal(5, 2)), 17, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (15, N'Satin Skirt', N'Nullam porttitor lacus at turpis.', CAST(84.93 AS Decimal(5, 2)), 10, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (16, N'Leather Jacket', N'Duis bibendum, felis sed interdum venenatis.', CAST(85.89 AS Decimal(5, 2)), 12, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (17, N'Denim Joggers', N'Suspendisse potenti.', CAST(66.54 AS Decimal(5, 2)), 16, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (18, N'Collar Sweater', N'Vivamus tortor.', CAST(61.31 AS Decimal(5, 2)), 9, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (19, N'Cargo Shorts', N'Donec dapibus.', CAST(48.23 AS Decimal(5, 2)), 16, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (20, N'Coat', N'Praesent lectus.', CAST(42.75 AS Decimal(5, 2)), 3, CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[TProduct] ([nProductId], [cName], [cDescription], [nUnitPrice], [nStock], [nAvgRating]) VALUES (21, N'3-pack Gloves', N'Aliquam erat volutpat.', CAST(50.06 AS Decimal(5, 2)), 9, CAST(0 AS Decimal(2, 1)))
SET IDENTITY_INSERT [dbo].[TProduct] OFF
SET IDENTITY_INSERT [dbo].[TUser] ON 

INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', N'ultrices@maurissit.com', CAST(98.67 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', N'ultrices@maurissit.com', CAST(564.37 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', N'sociis@hendrerit.edu', CAST(196.98 AS Decimal(10, 2)), 2)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', N'ac@Nullamsuscipitest.org', CAST(122.13 AS Decimal(10, 2)), 3)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', N'gravida.mauris@fringillaestMauris.org', CAST(357.91 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', N'at@CuraeDonectincidunt.edu', CAST(294.22 AS Decimal(10, 2)), 4)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', N'nibh.vulputate@porttitortellus.edu', CAST(460.15 AS Decimal(10, 2)), 5)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', N'ut.nulla@auctorquis.ca', CAST(371.85 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', N'in@iaculisaliquet.net', CAST(133.12 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (11, N'Phelan', N'Paul', N'1896 In Road', N'26849901', N'id@nequevitae.net', CAST(0.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (12, N'Noble', N'Cohen', N'Ap 220-9572 Duis St.', N'65553998', N'dictum.eleifend.nunc@purus.com', CAST(0.00 AS Decimal(10, 2)), 6)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (13, N'Andrew', N'Ashley', N'4543 Egestas Street', N'09542959', N'sem@nonleo.org', CAST(0.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (14, N'Judah', N'Ramirez', N'766-8543 Ullamcorper, St.', N'58069541', N'sed.turpis.nec@ultrices.edu', CAST(0.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (15, N'Theodore', N'Bird', N'457-7885 Ut Ave', N'64879626', N'Cum.sociis@sedlibero.org', CAST(0.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (16, N'Chancellor', N'Callahan', N'Ap 369-2607 Orci Rd.', N'28393616', N'dignissim@vitaeposuereat.co.uk', CAST(0.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (17, N'Addison', N'Wilson', N'P.O. Box 968, 1708 Egestas Rd.', N'61017529', N'justo@diam.ca', CAST(0.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (18, N'Xenos', N'Fulton', N'6621 Arcu. Street', N'71097123', N'In@scelerisquesed.org', CAST(0.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (19, N'Tanek', N'Schultz', N'Ap 314-8363 Arcu Avenue', N'79231804', N'cursus.diam@ridiculusmus.org', CAST(0.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (20, N'Valentine', N'Castillo', N'P.O. Box 551, 146 In Rd.', N'71667682', N'mi@sedpede.ca', CAST(0.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (21, N'Martin', N'Gonzalez', N'Ap 135-6696 Montes, St.', N'72917160', N'purus@non.com', CAST(0.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[TUser] ([nUserId], [cFirstName], [cSurname], [cAddress], [cPhoneNo], [cEmail], [nTotalAmount], [nCityId]) VALUES (22, N'Gil', N'Gross', N'4908 Nisi Avenue', N'59150514', N'Integer.vitae@luctus.ca', CAST(0.00 AS Decimal(10, 2)), 1)
SET IDENTITY_INSERT [dbo].[TUser] OFF
SET IDENTITY_INSERT [dbo].[TCreditCard] ON 

INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(98.67 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(176.45 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(192.26 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(195.66 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (47, 4, N'5677455430979214', N'2025', N'226', N'Brandon Jackson', CAST(67.97 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (48, 4, N'7361018324010638', N'2019', N'551', N'Brandon Jackson', CAST(129.01 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(122.13 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(108.48 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(249.43 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(147.11 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(147.11 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (54, 8, N'5640082369347787', N'2021', N'615', N'Darius Robbins', CAST(271.88 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (55, 8, N'2807317977932442', N'2023', N'289', N'Darius Robbins', CAST(188.27 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (56, 9, N'4446726041703621', N'2023', N'613', N'Paul Valentine', CAST(143.12 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (57, 9, N'4897251060401570', N'2025', N'499', N'Paul Valentine', CAST(85.61 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (58, 9, N'6606890371073660', N'2021', N'696', N'Paul Valentine', CAST(143.12 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(133.12 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (60, 11, N'4358474712888274', N'2018', N'378', N'Phelan Paul', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (61, 11, N'8670627435396022', N'2025', N'268', N'Phelan Paul', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (62, 11, N'8887591700502633', N'2019', N'795', N'Phelan Paul', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (63, 11, N'7281561639043160', N'2019', N'233', N'Phelan Paul', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (64, 12, N'6505992546419080', N'2018', N'849', N'Noble Cohen', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (65, 13, N'2936695021547713', N'2018', N'468', N'Andrew Ashley', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (66, 14, N'2552717286756565', N'2023', N'929', N'Judah Ramirez', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (67, 14, N'3376273982749686', N'2023', N'862', N'Judah Ramirez', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (68, 15, N'8928706761470049', N'2018', N'362', N'Theodore Bird', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (69, 15, N'8878259765900241', N'2020', N'806', N'Theodore Bird', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (70, 16, N'9906891719156994', N'2024', N'479', N'Chancellor Callahan', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (71, 16, N'8331139730800966', N'2025', N'318', N'Chancellor Callahan', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (72, 16, N'5336792534930402', N'2019', N'492', N'Chancellor Callahan', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (73, 17, N'7626122947651477', N'2021', N'846', N'Addison Wilson', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (74, 17, N'4519114978996269', N'2019', N'275', N'Addison Wilson', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (75, 18, N'8389928923172299', N'2018', N'494', N'Xenos Fulton', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (76, 18, N'4992055761676479', N'2021', N'412', N'Xenos Fulton', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (77, 19, N'8677099679826232', N'2025', N'842', N'Tanek Schultz', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (78, 19, N'1873004467757944', N'2023', N'277', N'Tanek Schultz', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (79, 19, N'2676885033806471', N'2019', N'622', N'Tanek Schultz', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (80, 20, N'5900878047385945', N'2021', N'959', N'Valentine Castillo', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (81, 21, N'2520793213174051', N'2024', N'604', N'Xenos Gonzalez', CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[TCreditCard] ([nCreditCardId], [nUserId], [nIBANCode], [dExpDate], [nCcv], [cCardholderName], [nAmountSpent]) VALUES (82, 22, N'8573381212945901', N'2024', N'208', N'Gil Gross', CAST(0.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[TCreditCard] OFF
SET IDENTITY_INSERT [dbo].[TInvoice] ON 

INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (1, 2, 2, CAST(25.00 AS Decimal(4, 2)), CAST(98.67 AS Decimal(10, 2)), CAST(N'2019-12-17T13:31:08.747' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (2, 3, 44, CAST(25.00 AS Decimal(4, 2)), CAST(176.45 AS Decimal(10, 2)), CAST(N'2019-12-17T13:31:26.187' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (3, 3, 45, CAST(25.00 AS Decimal(4, 2)), CAST(91.74 AS Decimal(10, 2)), CAST(N'2019-12-17T13:31:41.867' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (4, 3, 45, CAST(25.00 AS Decimal(4, 2)), CAST(100.52 AS Decimal(10, 2)), CAST(N'2019-12-17T13:31:59.460' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (5, 3, 46, CAST(25.00 AS Decimal(4, 2)), CAST(195.66 AS Decimal(10, 2)), CAST(N'2019-12-17T13:32:13.253' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (6, 4, 47, CAST(25.00 AS Decimal(4, 2)), CAST(67.97 AS Decimal(10, 2)), CAST(N'2019-12-17T13:32:35.130' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (7, 4, 48, CAST(25.00 AS Decimal(4, 2)), CAST(129.01 AS Decimal(10, 2)), CAST(N'2019-12-17T13:32:44.743' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (8, 5, 49, CAST(25.00 AS Decimal(4, 2)), CAST(122.13 AS Decimal(10, 2)), CAST(N'2019-12-17T13:33:02.500' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (9, 6, 50, CAST(25.00 AS Decimal(4, 2)), CAST(108.48 AS Decimal(10, 2)), CAST(N'2019-12-17T13:34:08.493' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (10, 6, 51, CAST(25.00 AS Decimal(4, 2)), CAST(249.43 AS Decimal(10, 2)), CAST(N'2019-12-17T13:34:31.240' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (11, 7, 52, CAST(25.00 AS Decimal(4, 2)), CAST(147.11 AS Decimal(10, 2)), CAST(N'2019-12-17T13:35:02.587' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (12, 7, 53, CAST(25.00 AS Decimal(4, 2)), CAST(147.11 AS Decimal(10, 2)), CAST(N'2019-12-17T13:35:12.423' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (13, 8, 54, CAST(25.00 AS Decimal(4, 2)), CAST(271.88 AS Decimal(10, 2)), CAST(N'2019-12-17T13:35:41.803' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (14, 8, 55, CAST(25.00 AS Decimal(4, 2)), CAST(188.27 AS Decimal(10, 2)), CAST(N'2019-12-17T13:35:58.363' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (15, 9, 57, CAST(25.00 AS Decimal(4, 2)), CAST(85.61 AS Decimal(10, 2)), CAST(N'2019-12-17T13:36:20.817' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (16, 9, 56, CAST(25.00 AS Decimal(4, 2)), CAST(143.12 AS Decimal(10, 2)), CAST(N'2019-12-17T13:36:57.887' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (17, 9, 58, CAST(25.00 AS Decimal(4, 2)), CAST(143.12 AS Decimal(10, 2)), CAST(N'2019-12-17T13:37:00.400' AS DateTime))
INSERT [dbo].[TInvoice] ([nInvoiceId], [nUserId], [nCreditCardId], [nTax], [nTotalAmount], [nDate]) VALUES (18, 10, 59, CAST(25.00 AS Decimal(4, 2)), CAST(133.12 AS Decimal(10, 2)), CAST(N'2019-12-17T13:37:27.610' AS DateTime))
SET IDENTITY_INSERT [dbo].[TInvoice] OFF
SET IDENTITY_INSERT [dbo].[TInvoiceLine] ON 

INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (1, 1, 1, 1, CAST(15.20 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (2, 1, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (3, 1, 3, 1, CAST(15.50 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (4, 2, 1, 1, CAST(15.20 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (5, 2, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (6, 2, 6, 1, CAST(26.62 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (7, 2, 5, 1, CAST(66.66 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (8, 3, 3, 1, CAST(15.50 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (9, 3, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (10, 3, 1, 1, CAST(15.20 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (11, 4, 6, 1, CAST(26.62 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (12, 4, 9, 2, CAST(36.95 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (13, 5, 6, 1, CAST(26.62 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (14, 5, 9, 2, CAST(36.95 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (15, 5, 13, 1, CAST(78.13 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (16, 5, 12, 1, CAST(17.01 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (17, 6, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (18, 7, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (19, 7, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (20, 8, 8, 1, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (21, 8, 10, 1, CAST(11.87 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (22, 8, 7, 1, CAST(55.19 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (23, 9, 5, 1, CAST(66.66 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (24, 9, 6, 1, CAST(26.62 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (25, 9, 1, 1, CAST(15.20 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (26, 10, 5, 2, CAST(66.66 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (27, 10, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (28, 10, 8, 1, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (29, 11, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (30, 11, 8, 1, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (31, 11, 3, 2, CAST(15.50 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (32, 12, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (33, 12, 8, 1, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (34, 12, 3, 2, CAST(15.50 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (35, 13, 2, 4, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (36, 14, 8, 2, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (37, 14, 13, 1, CAST(78.13 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (38, 15, 11, 2, CAST(3.74 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (39, 15, 13, 1, CAST(78.13 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (40, 16, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (41, 16, 14, 1, CAST(75.15 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (42, 17, 2, 1, CAST(67.97 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (43, 17, 14, 1, CAST(75.15 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (44, 18, 4, 1, CAST(61.04 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (45, 18, 8, 1, CAST(55.07 AS Decimal(5, 2)))
INSERT [dbo].[TInvoiceLine] ([nInvoiceLineId], [nInvoiceId], [nProductId], [nQuantity], [nUnitPrice]) VALUES (46, 18, 12, 1, CAST(17.01 AS Decimal(5, 2)))
SET IDENTITY_INSERT [dbo].[TInvoiceLine] OFF

SET IDENTITY_INSERT [dbo].[TRating] ON 
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (31, 1, 3, 3, N'Good to run in, I can feel the breeze.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (32, 1, 4, 4, N'Comfy to wear, ideal for Netflix and Chill time.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (33, 2, 3, 5, N'Can totally recommend to my friends.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (34, 2, 4, 1, N'Not satisfied with the quality of the product at all.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (35, 2, 2, 0, N'Not great, not terrible.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (36, 3, 4, 0, N'Wasnt something I was quite hoping for, but at least the delivery was fast.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (37, 3, 5, 0, N'Very unpleasant to wear.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (38, 3, 6, 0, N'Help me...')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (39, 4, 5, 0, N'Bought it for my wife, she loved it.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (40, 4, 7, 4, N'This was recommended to me by a friend, it OK I guess.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (41, 4, 2, 1, N'This product is gr8, I r8 8/8, cant h8 only apprecia8.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (30, 1, 2, 3, N'I will not buy anything from you ever again. You lost a customer.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (42, 5, 6, 2, N'Reclamation took very long, the product was low quality.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (43, 5, 7, 3, N'Overall very satisfied with it.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating], [cComment]) VALUES (44, 5, 8, 3, N'Its a good gift for your family memebers. Quite cheap as well.')
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (45, 6, 7, 4 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (46, 6, 7, 5 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (47, 6, 8, 5 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (48, 7, 8, 5 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (49, 7, 2, 5 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (50, 7, 2, 5 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (51, 8, 9, 3 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (52, 8, 8, 1 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (53, 8, 5, 3 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (54, 9, 9, 0 )
INSERT [dbo].[TRating] ([nRatingId], [nProductId], [nUserId], [nRating]) VALUES (55, 9, 7, 0 )
SET IDENTITY_INSERT [dbo].[TRating] OFF

SET IDENTITY_INSERT [dbo].[TAuditCreditCard] ON 

INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (1, 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(0.00 AS Decimal(6, 2)), 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(15.20 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.777' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (2, 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(15.20 AS Decimal(6, 2)), 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(83.17 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.780' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (3, 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(83.17 AS Decimal(6, 2)), 2, 2, N'8933265491581043', N'2000', N'234', N'Kevin Bauer', CAST(98.67 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.780' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (4, 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(0.00 AS Decimal(6, 2)), 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(15.20 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.190' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (5, 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(15.20 AS Decimal(6, 2)), 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(83.17 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.190' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (6, 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(83.17 AS Decimal(6, 2)), 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(109.79 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.200' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (7, 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(109.79 AS Decimal(6, 2)), 44, 3, N'4933274911010455', N'2021', N'974', N'John Bauer', CAST(176.45 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.200' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (8, 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(0.00 AS Decimal(6, 2)), 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(15.50 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.870' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (9, 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(15.50 AS Decimal(6, 2)), 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(76.54 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.870' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (10, 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(76.54 AS Decimal(6, 2)), 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(91.74 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.873' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (11, 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(91.74 AS Decimal(6, 2)), 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(118.36 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:59.460' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (12, 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(118.36 AS Decimal(6, 2)), 45, 3, N'5884778520038366', N'2020', N'796', N'John Bauer', CAST(192.26 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:59.460' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (13, 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(0.00 AS Decimal(6, 2)), 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(26.62 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.270' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (14, 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(26.62 AS Decimal(6, 2)), 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(100.52 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.277' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (15, 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(100.52 AS Decimal(6, 2)), 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(178.65 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.277' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (16, 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(178.65 AS Decimal(6, 2)), 46, 3, N'2631687517614698', N'2021', N'901', N'John Bauer', CAST(195.66 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.280' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (17, 47, 4, N'5677455430979214', N'2025', N'226', N'Brandon Jackson', CAST(0.00 AS Decimal(6, 2)), 47, 4, N'5677455430979214', N'2025', N'226', N'Brandon Jackson', CAST(67.97 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:35.133' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (18, 48, 4, N'7361018324010638', N'2019', N'551', N'Brandon Jackson', CAST(0.00 AS Decimal(6, 2)), 48, 4, N'7361018324010638', N'2019', N'551', N'Brandon Jackson', CAST(67.97 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:44.743' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (19, 48, 4, N'7361018324010638', N'2019', N'551', N'Brandon Jackson', CAST(67.97 AS Decimal(6, 2)), 48, 4, N'7361018324010638', N'2019', N'551', N'Brandon Jackson', CAST(129.01 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:44.747' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (20, 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(0.00 AS Decimal(6, 2)), 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(55.07 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.500' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (21, 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(55.07 AS Decimal(6, 2)), 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(66.94 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.503' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (22, 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(66.94 AS Decimal(6, 2)), 49, 5, N'2134296089644501', N'2021', N'996', N'Jermaine Holt', CAST(122.13 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.503' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (23, 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(0.00 AS Decimal(6, 2)), 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(66.66 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.517' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (24, 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(66.66 AS Decimal(6, 2)), 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(93.28 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.523' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (25, 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(93.28 AS Decimal(6, 2)), 50, 6, N'9433877572389365', N'2022', N'458', N'Seth Wynn', CAST(108.48 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.527' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (26, 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(0.00 AS Decimal(6, 2)), 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(133.32 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.257' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (27, 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(133.32 AS Decimal(6, 2)), 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(194.36 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.260' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (28, 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(194.36 AS Decimal(6, 2)), 51, 6, N'5765482473713271', N'2022', N'652', N'Seth Wynn', CAST(249.43 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.263' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (29, 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(0.00 AS Decimal(6, 2)), 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(61.04 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.590' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (30, 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(61.04 AS Decimal(6, 2)), 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(116.11 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.593' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (31, 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(116.11 AS Decimal(6, 2)), 52, 7, N'2059316865044247', N'2025', N'301', N'Honorato Clements', CAST(147.11 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.593' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (32, 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(0.00 AS Decimal(6, 2)), 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(61.04 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.423' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (33, 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(61.04 AS Decimal(6, 2)), 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(116.11 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.423' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (34, 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(116.11 AS Decimal(6, 2)), 53, 7, N'3201866064663640', N'2020', N'786', N'Honorato Clements', CAST(147.11 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.423' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (35, 54, 8, N'5640082369347787', N'2021', N'615', N'Darius Robbins', CAST(0.00 AS Decimal(6, 2)), 54, 8, N'5640082369347787', N'2021', N'615', N'Darius Robbins', CAST(271.88 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:41.820' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (36, 55, 8, N'2807317977932442', N'2023', N'289', N'Darius Robbins', CAST(0.00 AS Decimal(6, 2)), 55, 8, N'2807317977932442', N'2023', N'289', N'Darius Robbins', CAST(110.14 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:58.363' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (37, 55, 8, N'2807317977932442', N'2023', N'289', N'Darius Robbins', CAST(110.14 AS Decimal(6, 2)), 55, 8, N'2807317977932442', N'2023', N'289', N'Darius Robbins', CAST(188.27 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:58.363' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (38, 57, 9, N'4897251060401570', N'2025', N'499', N'Paul Valentine', CAST(0.00 AS Decimal(6, 2)), 57, 9, N'4897251060401570', N'2025', N'499', N'Paul Valentine', CAST(7.48 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:20.820' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (39, 57, 9, N'4897251060401570', N'2025', N'499', N'Paul Valentine', CAST(7.48 AS Decimal(6, 2)), 57, 9, N'4897251060401570', N'2025', N'499', N'Paul Valentine', CAST(85.61 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:20.827' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (40, 56, 9, N'4446726041703621', N'2023', N'613', N'Paul Valentine', CAST(0.00 AS Decimal(6, 2)), 56, 9, N'4446726041703621', N'2023', N'613', N'Paul Valentine', CAST(67.97 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:57.907' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (41, 56, 9, N'4446726041703621', N'2023', N'613', N'Paul Valentine', CAST(67.97 AS Decimal(6, 2)), 56, 9, N'4446726041703621', N'2023', N'613', N'Paul Valentine', CAST(143.12 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:57.910' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (42, 58, 9, N'6606890371073660', N'2021', N'696', N'Paul Valentine', CAST(0.00 AS Decimal(6, 2)), 58, 9, N'6606890371073660', N'2021', N'696', N'Paul Valentine', CAST(67.97 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:00.400' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (43, 58, 9, N'6606890371073660', N'2021', N'696', N'Paul Valentine', CAST(67.97 AS Decimal(6, 2)), 58, 9, N'6606890371073660', N'2021', N'696', N'Paul Valentine', CAST(143.12 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:00.400' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (44, 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(0.00 AS Decimal(6, 2)), 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(61.04 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.610' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (45, 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(61.04 AS Decimal(6, 2)), 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(116.11 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.613' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditCreditCard] ([nTAuditCreditCardId], [before_nCreditCardId], [before_nUserId], [before_cIBANCode], [before_dExpDate], [before_nCcv], [before_cCardholderName], [before_nAmountSpent], [after_nCreditCardId], [after_nUserId], [after_cIBANCode], [after_dExpDate], [after_nCcv], [after_cCardholderName], [after_nAmountSpent], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (46, 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(116.11 AS Decimal(6, 2)), 59, 10, N'2953089361654912', N'2024', N'554', N'Jack Mcdowell', CAST(133.12 AS Decimal(6, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.613' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
SET IDENTITY_INSERT [dbo].[TAuditCreditCard] OFF
SET IDENTITY_INSERT [dbo].[TAuditUser] ON 

INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (1, 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(0.00 AS Decimal(10, 2)), 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(15.20 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.770' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (2, 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(15.20 AS Decimal(10, 2)), 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(83.17 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.780' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (3, 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(83.17 AS Decimal(10, 2)), 2, N'Kevin', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(98.67 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:08.780' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (4, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(0.00 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(15.20 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.187' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (5, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(15.20 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(83.17 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.190' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (6, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(83.17 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(109.79 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.197' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (7, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(109.79 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(176.45 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:26.200' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (8, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(176.45 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(191.95 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.867' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (9, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(191.95 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(252.99 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.870' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (10, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(252.99 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(268.19 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:41.873' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (11, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(268.19 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(294.81 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:59.460' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (12, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(294.81 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(368.71 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:31:59.460' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (13, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(368.71 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(395.33 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.267' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (14, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(395.33 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(469.23 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.273' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (15, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(469.23 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(547.36 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.277' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (16, 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(547.36 AS Decimal(10, 2)), 3, N'John', N'Bauer', N'4707 Consectetuer Avenue', N'18244240', 1, N'ultrices@maurissit.com', CAST(564.37 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:13.280' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (17, 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(0.00 AS Decimal(10, 2)), 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(67.97 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:35.133' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (18, 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(67.97 AS Decimal(10, 2)), 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(135.94 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:44.743' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (19, 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(135.94 AS Decimal(10, 2)), 4, N'Brandon', N'Jackson', N'Ap 926-5802 Non Street', N'41508021', 2, N'sociis@hendrerit.edu', CAST(196.98 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:32:44.747' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (20, 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(0.00 AS Decimal(10, 2)), 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(55.07 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.500' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (21, 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(55.07 AS Decimal(10, 2)), 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(66.94 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.500' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (22, 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(66.94 AS Decimal(10, 2)), 5, N'Jermaine', N'Holt', N'441-3110 Gravida Ave', N'55014571', 3, N'ac@Nullamsuscipitest.org', CAST(122.13 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:33:02.503' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (23, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(0.00 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(66.66 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.510' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (24, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(66.66 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(93.28 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.523' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (25, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(93.28 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(108.48 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:08.527' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (26, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(108.48 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(241.80 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.253' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (27, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(241.80 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(302.84 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.260' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (28, 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(302.84 AS Decimal(10, 2)), 6, N'Seth', N'Wynn', N'276-8008 Aliquam St.', N'24272119', 1, N'gravida.mauris@fringillaestMauris.org', CAST(357.91 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:34:31.260' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (29, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(0.00 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(61.04 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.590' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (30, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(61.04 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(116.11 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.590' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (31, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(116.11 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(147.11 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:02.593' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (32, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(147.11 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(208.15 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.420' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (33, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(208.15 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(263.22 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.423' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (34, 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(263.22 AS Decimal(10, 2)), 7, N'Honorato', N'Clements', N'P.O. Box 310, 6925 Sagittis Rd.', N'65547304', 4, N'at@CuraeDonectincidunt.edu', CAST(294.22 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:12.423' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (35, 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(0.00 AS Decimal(10, 2)), 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(271.88 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:41.813' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (36, 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(271.88 AS Decimal(10, 2)), 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(382.02 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:58.363' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (37, 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(382.02 AS Decimal(10, 2)), 8, N'Darius', N'Robbins', N'102-3486 Et Rd.', N'50861101', 5, N'nibh.vulputate@porttitortellus.edu', CAST(460.15 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:35:58.363' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (38, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(0.00 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(7.48 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:20.820' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (39, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(7.48 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(85.61 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:20.823' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (40, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(85.61 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(153.58 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:57.900' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (41, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(153.58 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(228.73 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:36:57.907' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (42, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(228.73 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(296.70 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:00.400' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (43, 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(296.70 AS Decimal(10, 2)), 9, N'Paul', N'Valentine', N'798-2467 Facilisis Avenue', N'36625242', 1, N'ut.nulla@auctorquis.ca', CAST(371.85 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:00.400' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (44, 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(0.00 AS Decimal(10, 2)), 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(61.04 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.610' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (45, 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(61.04 AS Decimal(10, 2)), 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(116.11 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.610' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
INSERT [dbo].[TAuditUser] ([nTAuditUserId], [before_nUserId], [before_cFirstName], [before_cSurname], [before_cAddress], [before_cPhoneNo], [before_nCityId], [before_cEmail], [before_nTotalAmount], [after_nUserId], [after_cFirstName], [after_cSurname], [after_cAddress], [after_cPhoneNo], [after_nCityId], [after_cEmail], [after_nTotalAmount], [cStatementType], [dtExecutedAt], [nDBMSId], [cDBMSName], [cHostId], [cHostName]) VALUES (46, 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(116.11 AS Decimal(10, 2)), 10, N'Jack', N'Mcdowell', N'P.O. Box 500 9515 Egestas St.', N'59448484', 1, N'in@iaculisaliquet.net', CAST(133.12 AS Decimal(10, 2)), N'UPDATE', CAST(N'2019-12-17T13:37:27.613' AS DateTime), 5, N'AlmightyUser', N'46205596', N'DESKTOP-G7J11FP')
SET IDENTITY_INSERT [dbo].[TAuditUser] OFF





/****** Object:  Index [Index_cardid_userid_amount]    Script Date: 16-Dec-19 1:39:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Index_cardid_userid_amount] ON [dbo].[TCreditCard]
(
	[nCreditCardId] ASC,
	[nUserId] ASC,
	[nAmountSpent] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Index_cardid_userid_totalamount]    Script Date: 16-Dec-19 1:39:23 PM ******/
CREATE NONCLUSTERED INDEX [Index_cardid_userid_totalamount] ON [dbo].[TInvoice]
(
	[nCreditCardId] ASC,
	[nUserId] ASC,
	[nTotalAmount] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Index_FirstNameamount]    Script Date: 16-Dec-19 1:39:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Index_FirstNameamount] ON [dbo].[TUser]
(
	[cFirstName] ASC,
	[nTotalAmount] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TProduct] ADD  CONSTRAINT [DF_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[TProduct] ADD  CONSTRAINT [DF_SysEnd]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.99999999')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[TRating] ADD  CONSTRAINT [DF_SysStart2]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[TRating] ADD  CONSTRAINT [DF_SysEnd2]  DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.99999999')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[TCreditCard]  WITH CHECK ADD  CONSTRAINT [FK_nUserId] FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TCreditCard] CHECK CONSTRAINT [FK_nUserId]
GO
ALTER TABLE [dbo].[TInvoice]  WITH CHECK ADD  CONSTRAINT [FK_nCreditCardId] FOREIGN KEY([nCreditCardId])
REFERENCES [dbo].[TCreditCard] ([nCreditCardId])
GO
ALTER TABLE [dbo].[TInvoice] CHECK CONSTRAINT [FK_nCreditCardId]
GO
ALTER TABLE [dbo].[TInvoice]  WITH CHECK ADD  CONSTRAINT [FK_UserId] FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TInvoice] CHECK CONSTRAINT [FK_UserId]
GO
ALTER TABLE [dbo].[TInvoiceLine]  WITH CHECK ADD  CONSTRAINT [FK_nInvoiceId] FOREIGN KEY([nInvoiceId])
REFERENCES [dbo].[TInvoice] ([nInvoiceId])
GO
ALTER TABLE [dbo].[TInvoiceLine] CHECK CONSTRAINT [FK_nInvoiceId]
GO
ALTER TABLE [dbo].[TInvoiceLine]  WITH CHECK ADD  CONSTRAINT [FK_nProductId] FOREIGN KEY([nProductId])
REFERENCES [dbo].[TProduct] ([nProductId])
GO
ALTER TABLE [dbo].[TInvoiceLine] CHECK CONSTRAINT [FK_nProductId]
GO
ALTER TABLE [dbo].[TRating]  WITH CHECK ADD  CONSTRAINT [FK__TRating__nProduc__6754599E] FOREIGN KEY([nProductId])
REFERENCES [dbo].[TProduct] ([nProductId])
GO
ALTER TABLE [dbo].[TRating] CHECK CONSTRAINT [FK__TRating__nProduc__6754599E]
GO
ALTER TABLE [dbo].[TRating]  WITH CHECK ADD  CONSTRAINT [FK__TRating__nUserId__68487DD7] FOREIGN KEY([nUserId])
REFERENCES [dbo].[TUser] ([nUserId])
GO
ALTER TABLE [dbo].[TRating] CHECK CONSTRAINT [FK__TRating__nUserId__68487DD7]
GO
ALTER TABLE [dbo].[TUser]  WITH CHECK ADD  CONSTRAINT [FK_nCityId] FOREIGN KEY([nCityId])
REFERENCES [dbo].[TCity] ([nCityId])
GO
ALTER TABLE [dbo].[TUser] CHECK CONSTRAINT [FK_nCityId]
GO
/****** Object:  StoredProcedure [dbo].[pro_CreateInvoice]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[pro_CreateInvoice]

    @nUserId INT,
    @nCardId INT,
    @dTax DECIMAL(4,2),
    @nTotalAmount DECIMAL(6,2),
    @dDate DATETIME

AS
BEGIN

    INSERT INTO TInvoice
        ([nUserId]
        ,[nCreditCardId]
        ,[nTax]
        ,[nTotalAmount]
        ,[nDate])
    VALUES
        (@nUserId, @nCardId, @dTax, @nTotalAmount, @dDate)
    RETURN @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[pro_CreateInvoiceLine]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[pro_CreateInvoiceLine]

    @nInvoiceId INT,
    @nProductId INT,
    @nQuantity INT,
	@nUnitPrice DECIMAL(4,2)
    
AS
BEGIN

    INSERT INTO TInvoiceLine
        ([nInvoiceId]
        ,[nProductId]
        ,[nQuantity]
		,[nUnitPrice])
    VALUES
        (@nInvoiceId, @nProductId,@nQuantity,@nUnitPrice)
 
END
GO
/****** Object:  StoredProcedure [dbo].[pro_InsertIntoAuditCreditCard]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         pro_InsertIntoAuditCreditCard.sql
-- 
-- Purpose:      Creates a Stored Procedure on the TAuditCreditCard table
--               that can be used to insert into the TAuditCreditCard table
--               
-- Type:         Stored Procedure
-- 
-- Artifacts:    None
--                 
-- Author:       Casper Sørensen
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE   PROCEDURE [dbo].[pro_InsertIntoAuditCreditCard]
    -- SET BEFORE VALUES
    @before_nCreditCardId INT,
    @before_nUserId INT,
    @before_cIBANCode VARCHAR(16),
    @before_dExpDate VARCHAR(4),
    @before_nCcv VARCHAR(3),
    @before_cCardholderName VARCHAR(40),
    @before_nAmountSpent DECIMAL(6,2),
    -- SET NEW VALUES
    @after_nCreditCardId INT,
    @after_nUserId INT,
    @after_cIBANCode VARCHAR(16),
    @after_dExpDate VARCHAR(4),
    @after_nCcv VARCHAR(3),
    @after_cCardholderName VARCHAR(40),
    @after_nAmountSpent DECIMAL(6,2),
    -- SET SYSTEM VALUES
    @cStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @cDBMSName NVARCHAR(128),
    @cHostId CHAR(8),
    @cHostName NVARCHAR(128)
AS
BEGIN
    INSERT INTO
    TAuditCreditCard
        (
        before_nCreditCardId,
        before_nUserId,
        before_cIBANCode,
        before_dExpDate,
        before_nCcv,
        before_cCardholderName,
        before_nAmountSpent,
        after_nCreditCardId,
        after_nUserId,
        after_cIBANCode,
        after_dExpDate,
        after_nCcv,
        after_cCardholderName,
        after_nAmountSpent,
        cStatementType,
        dtExecutedAt,
        nDBMSId,
        cDBMSName,
        cHostId,
        cHostName
        )
    VALUES
        (
            @before_nCreditCardId,
            @before_nUserId,
            @before_cIBANCode,
            @before_dExpDate,
            @before_nCcv,
            @before_cCardholderName,
            @before_nAmountSpent,
            @after_nCreditCardId,
            @after_nUserId,
            @after_cIBANCode,
            @after_dExpDate,
            @after_nCcv,
            @after_cCardholderName,
            @after_nAmountSpent,
            @cStatementType,
            @dtExecutedAt,
            @nDBMSId,
            @cDBMSName,
            @cHostId,
            @cHostName
    );

    RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[pro_InsertIntoAuditUsers]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         pro_InsertIntoAuditUsers.sql
-- 
-- Purpose:      Creates a Stored Procedure on the TAuditUser table
--               that can be used to insert into the TAuditUser table
--               
-- Type:         Stored Procedure
-- 
-- Artifacts:    None
--                 
-- Author:       Casper Sørensen
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


CREATE   PROCEDURE [dbo].[pro_InsertIntoAuditUsers]

    -- SET BEFORE VALUES
    @before_nUserId INT,
    @before_cFirstName VARCHAR(20),
    @before_cSurname VARCHAR(20),
    @before_cAddress VARCHAR(60),
    @before_cPhoneNo VARCHAR(8),
    @before_nCityId INT,
    @before_cEmail VARCHAR(60),
    @before_nTotalAmount DECIMAL(10,2),

    -- SET NEW VALUES
    @after_nUserId INT,
    @after_cFirstName VARCHAR(20),
    @after_cSurname VARCHAR(20),
    @after_cAddress VARCHAR(60),
    @after_cPhoneNo VARCHAR(8),
    @after_nCityId INT,
    @after_cEmail VARCHAR (60),
    @after_nTotalAmount DECIMAL(10,2),

    -- SET SYSTEM DATE
    @cStatementType VARCHAR(10),
    @dtExecutedAt DATETIME,
    @nDBMSId INT,
    @cDBMSName NVARCHAR(128),
    @cHostId CHAR(8),
    @cHostName NVARCHAR(128)
AS
BEGIN
    INSERT INTO TAuditUser
        (before_nUserId,
        before_cFirstName,
        before_cSurname,
        before_cAddress,
        before_cPhoneNo,
        before_nCityId,
        before_cEmail,
        before_nTotalAmount,
        after_nUserId,
        after_cFirstName,
        after_cSurname,
        after_cAddress,
        after_cPhoneNo,
        after_nCityId,
        after_cEmail,
        after_nTotalAmount,
        cStatementType,
        dtExecutedAt,
        nDBMSId,
        cDBMSName,
        cHostId,
        cHostName
        )
    VALUES
        (@before_nUserId,
            @before_cFirstName,
            @before_cSurname,
            @before_cAddress,
            @before_cPhoneNo,
            @before_nCityId,
            @before_cEmail,
            @before_nTotalAmount,
            @after_nUserId,
            @after_cFirstName,
            @after_cSurname,
            @after_cAddress,
            @after_cPhoneNo,
            @after_nCityId,
            @after_cEmail,
            @after_nTotalAmount,
            @cStatementType,
            @dtExecutedAt,
            @nDBMSId,
            @cDBMSName,
            @cHostId,
            @cHostName
    );
END

GO
/****** Object:  Trigger [dbo].[trg_OnCreditCardDelete]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardDelete.sql
-- 
-- Purpose:      Creates a AFTER DELETE trigger on the TCreditCard table
--               It adds the TCreditCard old and the new values FROM the row
--               it then calls the pro_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER DELETE
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE   TRIGGER [dbo].[trg_OnCreditCardDelete]
ON [dbo].[TCreditCard]
AFTER DELETE
AS
BEGIN

    -- DECLARE ALL VARIABLES
    DECLARE @before_nCreditCardId INT
    DECLARE @before_nUserId INT
    DECLARE @before_cIBANCode VARCHAR(16)
    DECLARE @before_dExpDate VARCHAR(4)
    DECLARE @before_nCcv VARCHAR(3)
    DECLARE @before_cCardholderName VARCHAR(40)
    DECLARE @before_nAmountSpent DECIMAL(6,2)
    -- SET NEW VALUES
    DECLARE @after_nCreditCardId INT
    DECLARE @after_nUserId INT
    DECLARE @after_cIBANCode VARCHAR(16)
    DECLARE @after_dExpDate VARCHAR(4)
    DECLARE @after_nCcv VARCHAR(3)
    DECLARE @after_cCardholderName VARCHAR(40)
    DECLARE @after_nAmountSpent DECIMAL(6,2)
    
    -- SET SYSTEM DATE
    DECLARE @cStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128)
    DECLARE @cHostId CHAR(8)
    DECLARE @cHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_nCreditCardId = nCreditCardId,
    @before_nUserId = nUserId, 
    @before_cIBANCode = nIBANCode, 
    @before_dExpDate = dExpDate,
    @before_nCcv = nCcv, 
    @before_cCardholderName = cCardholderName,
    @before_nAmountSpent = nAmountSpent
    from deleted 

    SELECT @cStatementType = 'DELETE'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @cDBMSName = USER_NAME()
    SET @cHostId = HOST_ID()
    SET @cHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditCreditCard
        @before_nCreditCardId,
    @before_nUserId,
        @before_cIBANCode,
        @before_dExpDate,
        @before_nCcv,
        @before_cCardholderName,
        @before_nAmountSpent,
        @after_nCreditCardId,
        @after_nUserId,
        @after_cIBANCode,
        @after_dExpDate,
        @after_nCcv,
        @after_cCardholderName,
        @after_nAmountSpent,
        @cStatementType,
        @dtExecutedAt,
        @nDBMSId,
        @cDBMSName,
        @cHostId,
        @cHostName
END;
GO
ALTER TABLE [dbo].[TCreditCard] ENABLE TRIGGER [trg_OnCreditCardDelete]
GO
/****** Object:  Trigger [dbo].[trg_OnCreditCardInsert]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardInsert.sql
-- 
-- Purpose:      Creates a AFTER INSERT trigger on the TCreditCard table
--               It adds the TCreditCard old and the new values FROM the row
--               it then calls the pro_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER INSERT
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE   TRIGGER [dbo].[trg_OnCreditCardInsert]
ON [dbo].[TCreditCard]
AFTER INSERT
AS
BEGIN

    -- DECLARE ALL VARIABLES
    DECLARE @before_nCreditCardId INT
    DECLARE @before_nUserId INT
    DECLARE @before_cIBANCode VARCHAR(16)
    DECLARE @before_dExpDate VARCHAR(4)
    DECLARE @before_nCcv VARCHAR(3)
    DECLARE @before_cCardholderName VARCHAR(40)
    DECLARE @before_nAmountSpent DECIMAL(6,2)
    -- SET NEW VALUES
    DECLARE @after_nCreditCardId INT
    DECLARE @after_nUserId INT
    DECLARE @after_cIBANCode VARCHAR(16)
    DECLARE @after_dExpDate VARCHAR(4)
    DECLARE @after_nCcv VARCHAR(3)
    DECLARE @after_cCardholderName VARCHAR(40)
    DECLARE @after_nAmountSpent DECIMAL(6,2)
    -- SET SYSTEM DATE
    DECLARE @cStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128)
    DECLARE @cHostId CHAR(8)
    DECLARE @cHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_nCreditCardId = NULL
    SELECT @before_nUserId = NULL
    SELECT @before_cIBANCode = NULL
    SELECT @before_dExpDate = NULL
    SELECT @before_nCcv = NULL
    SELECT @before_cCardholderName = NULL
    SELECT @before_nAmountSpent = NULL

    -- SET AFTER VARIABLES
    SELECT @after_nCreditCardId = nCreditCardId
    FROM inserted
    SELECT @after_nUserId = nUserId
    FROM inserted
    SELECT @after_cIBANCode = nIBANCode
    FROM inserted
    SELECT @after_dExpDate = dExpDate
    FROM inserted
    SELECT @after_nCcv = nCcv
    FROM inserted
    SELECT @after_cCardholderName = cCardHolderName
    FROM inserted
    SELECT @after_nAmountSpent = nAmountSpent
    FROM inserted

    SELECT @cStatementType = 'INSERT'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @cDBMSName = USER_NAME()
    SET @cHostId = HOST_ID()
    SET @cHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditCreditCard
        @before_nCreditCardId,
    @before_nUserId,
        @before_cIBANCode,
        @before_dExpDate,
        @before_nCcv,
        @before_cCardholderName,
        @before_nAmountSpent,
        @after_nCreditCardId,
        @after_nUserId,
        @after_cIBANCode,
        @after_dExpDate,
        @after_nCcv,
        @after_cCardholderName,
        @after_nAmountSpent,
        @cStatementType,
        @dtExecutedAt,
        @nDBMSId,
        @cDBMSName,
        @cHostId,
        @cHostName
END;
GO
ALTER TABLE [dbo].[TCreditCard] ENABLE TRIGGER [trg_OnCreditCardInsert]
GO
/****** Object:  Trigger [dbo].[trg_OnCreditCardUpdate]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnCreditCardUpdate.sql
-- 
-- Purpose:      Creates a AFTER INSERT trigger on the TCreditCard table
--               It adds the TCreditCard old and the new values FROM the row
--               it then calls the pro_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER UPDATE
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE   TRIGGER [dbo].[trg_OnCreditCardUpdate]
ON [dbo].[TCreditCard]
AFTER UPDATE
AS
BEGIN

    -- DECLARE ALL VARIABLES
    DECLARE @before_nCreditCardId INT
    DECLARE @before_nUserId INT
    DECLARE @before_cIBANCode VARCHAR(16)
    DECLARE @before_dExpDate VARCHAR(4)
    DECLARE @before_nCcv VARCHAR(3)
    DECLARE @before_cCardholderName VARCHAR(40)
    DECLARE @before_nAmountSpent DECIMAL(6,2)
    -- SET NEW VALUES
    DECLARE @after_nCreditCardId INT
    DECLARE @after_nUserId INT
    DECLARE @after_cIBANCode VARCHAR(16)
    DECLARE @after_dExpDate VARCHAR(4)
    DECLARE @after_nCcv VARCHAR(3)
    DECLARE @after_cCardholderName VARCHAR(40)
    DECLARE @after_nAmountSpent DECIMAL(6,2)
    
    -- SET SYSTEM DATE
    DECLARE @cStatementType VARCHAR(10)
    DECLARE @dtExecutedAt DATETIME
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128)
    DECLARE @cHostId CHAR(8)
    DECLARE @cHostName NVARCHAR(128)

    -- SET BEFORE VARIABLES
    SELECT @before_nCreditCardId = nCreditCardId,
    @before_nUserId = nUserId, 
    @before_cIBANCode = nIBANCode, 
    @before_dExpDate = dExpDate,
    @before_nCcv = nCcv, 
    @before_cCardholderName = cCardholderName,
    @before_nAmountSpent = nAmountSpent
    from deleted 

    -- SET AFTER VARIABLES
    SELECT @after_nCreditCardId = nCreditCardId,
    @after_nUserId = nUserId,
    @after_cIBANCode = nIBANCode,
    @after_dExpDate = dExpDate,
    @after_nCcv = nCcv,
    @after_cCardholderName = cCardholderName,
    @after_nAmountSpent = nAmountSpent
    FROM inserted

    SELECT @cStatementType = 'UPDATE'

    -- SET THE SYSTEM VARIABLES
    SET @dtExecutedAt = GETDATE()
    SET @nDBMSId = USER_ID()
    SET @cDBMSName = USER_NAME()
    SET @cHostId = HOST_ID()
    SET @cHostName = HOST_NAME()

    -- CALL THE INSERT INTO TAUDITUSERS STORED PROCEDURE
    EXEC pro_InsertIntoAuditCreditCard
        @before_nCreditCardId,
    @before_nUserId,
        @before_cIBANCode,
        @before_dExpDate,
        @before_nCcv,
        @before_cCardholderName,
        @before_nAmountSpent,
        @after_nCreditCardId,
        @after_nUserId,
        @after_cIBANCode,
        @after_dExpDate,
        @after_nCcv,
        @after_cCardholderName,
        @after_nAmountSpent,
        @cStatementType,
        @dtExecutedAt,
        @nDBMSId,
        @cDBMSName,
        @cHostId,
        @cHostName
END;
GO
ALTER TABLE [dbo].[TCreditCard] ENABLE TRIGGER [trg_OnCreditCardUpdate]
GO
/****** Object:  Trigger [dbo].[trg_OnUserDelete]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserDelete.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values FROM the row
--               it then calls the sp_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER UPDATE
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE
  TRIGGER [dbo].[trg_OnUserDelete]
ON [dbo].[TUser]
AFTER DELETE
    AS BEGIN
    -- DECLARE ALL VARIABLES
    DECLARE @before_nUserId INT
    DECLARE @before_cFirstName VARCHAR(20)
    DECLARE @before_cSurname VARCHAR(20)
    DECLARE @before_cAddress VARCHAR(60) 
    DECLARE @before_cPhoneNo VARCHAR(8) 
    DECLARE @before_nCityId INT 
    DECLARE @before_cEmail VARCHAR(60)    
    DECLARE @before_nTotalAmount DECIMAL(10,2) 
    DECLARE @after_nUserId INT      
    DECLARE @after_cFirstName VARCHAR(20) 
    DECLARE @after_cSurname VARCHAR(20) 
    DECLARE @after_cAddress VARCHAR(60) 
    DECLARE @after_cPhoneNo VARCHAR(8)  
    DECLARE @after_nCityId INT 
    DECLARE @after_cEmail VARCHAR (60)
    DECLARE @after_nTotalAmount DECIMAL(10,2)      
    DECLARE @cStatementType VARCHAR(10) 
    DECLARE @dtExecutedAt DATETIME 
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128) 
    DECLARE @cHostId CHAR(8) 
    DECLARE @cHostName NVARCHAR(128)
    
    SELECT @before_nUserId = nUserId from deleted
    SELECT @before_cFirstName = cFirstName from deleted 
    SELECT @before_cSurname = cSurname from deleted 
    SELECT @before_cAddress = cAddress from deleted 
    SELECT @before_cPhoneNo = cPhoneNo from deleted  
    SELECT @before_nCityId = nCityId from deleted 
    SELECT @before_cEmail = cEmail from deleted 
    SELECT @before_nTotalAmount = nTotalAmount from deleted

    SELECT @after_nUserId = null
    SELECT @after_cFirstName = null 
    SELECT @after_cSurname = null 
    SELECT @after_cAddress = null 
    SELECT @after_cPhoneNo = null  
    SELECT @after_nCityId = null 
    SELECT @after_cEmail = null 
    SELECT @after_nTotalAmount = null 
    SELECT @cStatementType = 'DELETE' 
    
    SET @dtExecutedAt = GETDATE() 
    SET @nDBMSId = USER_ID() 
    SET @cDBMSName = USER_NAME() 
    SET @cHostId = HOST_ID() 
    SET @cHostName = HOST_NAME() 

EXEC pro_InsertIntoAuditUsers 
    @before_nUserId,
    @before_cFirstName,
    @before_cSurname,
    @before_cAddress, 
    @before_cPhoneNo, 
    @before_nCityId, 
    @before_cEmail,     
    @before_nTotalAmount, 
    @after_nUserId,     
    @after_cFirstName, 
    @after_cSurname, 
    @after_cAddress, 
    @after_cPhoneNo, 
    @after_nCityId, 
    @after_cEmail,
    @after_nTotalAmount,      
    @cStatementType, 
    @dtExecutedAt, 
    @nDBMSId,
    @cDBMSName, 
    @cHostId, 
    @cHostName

END;
GO
ALTER TABLE [dbo].[TUser] ENABLE TRIGGER [trg_OnUserDelete]
GO
/****** Object:  Trigger [dbo].[trg_OnUserInsert]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserInsert.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values FROM the row
--               it then calls the sp_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER INSERT
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE
  TRIGGER [dbo].[trg_OnUserInsert]
ON [dbo].[TUser]
AFTER
INSERT
    AS BEGIN
    -- DECLARE ALL VARIABLES
    DECLARE @before_nUserId INT
    DECLARE @before_cFirstName VARCHAR(20)
    DECLARE @before_cSurname VARCHAR(20)
    DECLARE @before_cAddress VARCHAR(60) 
    DECLARE @before_cPhoneNo VARCHAR(8) 
    DECLARE @before_nCityId INT 
    DECLARE @before_cEmail VARCHAR(60)    
    DECLARE @before_nTotalAmount DECIMAL(10,2) 
    DECLARE @after_nUserId INT      
    DECLARE @after_cFirstName VARCHAR(20) 
    DECLARE @after_cSurname VARCHAR(20) 
    DECLARE @after_cAddress VARCHAR(60) 
    DECLARE @after_cPhoneNo VARCHAR(8) 
    DECLARE @after_nCityId INT 
    DECLARE @after_cEmail VARCHAR (60)
    DECLARE @after_nTotalAmount DECIMAL(10,2)      
    DECLARE @cStatementType VARCHAR(10) 
    DECLARE @dtExecutedAt DATETIME 
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128) 
    DECLARE @cHostId CHAR(8) 
    DECLARE @cHostName NVARCHAR(128)
    
    SELECT @before_nUserId = NULL 
    SELECT @before_cFirstName = NULL 
    SELECT @before_cSurname = NULL 
    SELECT @before_cAddress = NULL 
    SELECT @before_cPhoneNo = NULL 
    SELECT @before_nCityId = NULL 
    SELECT @before_cEmail = NULL 
    SELECT @before_nTotalAmount = NULL 
    
    SELECT @after_nUserId = nUserId from inserted
    SELECT @after_cFirstName = cFirstName from inserted 
    SELECT @after_cSurname = cSurname from inserted 
    SELECT @after_cAddress = cAddress from inserted 
    SELECT @after_cPhoneNo = cPhoneNo from inserted 
    SELECT @after_nCityId = nCityId from inserted 
    SELECT @after_cEmail = cEmail from inserted 
    SELECT @after_nTotalAmount = nTotalAmount from inserted 
    SELECT @cStatementType = 'INSERT' 
    
    SET @dtExecutedAt = GETDATE() 
    SET @nDBMSId = USER_ID() 
    SET @cDBMSName = USER_NAME() 
    SET @cHostId = HOST_ID() 
    SET @cHostName = HOST_NAME() 

EXEC pro_InsertIntoAuditUsers 
    @before_nUserId,
    @before_cFirstName,
    @before_cSurname,
    @before_cAddress, 
    @before_cPhoneNo, 
    @before_nCityId, 
    @before_cEmail,     
    @before_nTotalAmount, 
    @after_nUserId,     
    @after_cFirstName, 
    @after_cSurname, 
    @after_cAddress, 
    @after_cPhoneNo, 
    @after_nCityId, 
    @after_cEmail,
    @after_nTotalAmount,      
    @cStatementType, 
    @dtExecutedAt, 
    @nDBMSId,
    @cDBMSName, 
    @cHostId, 
    @cHostName

END;
GO
ALTER TABLE [dbo].[TUser] ENABLE TRIGGER [trg_OnUserInsert]
GO
/****** Object:  Trigger [dbo].[trg_OnUserUpdate]    Script Date: 16-Dec-19 1:39:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Name:         tri_OnUserUpdate.sql
-- 
-- Purpose:      Creates a ON DELETE trigger on the TCreditCard table
--               It adds the Tsuers old and the new values FROM the row
--               it then calls the sp_InsertIntoAuditCreditCards 
--               that inserts them into to the TAuditCreditCard table.
--
-- At:           AFTER UPDATE
--               
-- Type:         Trigger
-- 
-- Artifacts:    None
--                 
-- Authors:      Casper Sørensen, 
--               Martin Belák, 
--               Norbert Krausz, 
--               Bastian Normann Garding
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
CREATE
  TRIGGER [dbo].[trg_OnUserUpdate]
ON [dbo].[TUser]
AFTER UPDATE
    AS BEGIN
    -- DECLARE ALL VARIABLES
    DECLARE @before_nUserId INT
    DECLARE @before_cFirstName VARCHAR(20)
    DECLARE @before_cSurname VARCHAR(20)
    DECLARE @before_cAddress VARCHAR(60) 
    DECLARE @before_cPhoneNo VARCHAR(8) 
    DECLARE @before_nCityId INT 
    DECLARE @before_cEmail VARCHAR(60)    
    DECLARE @before_nTotalAmount DECIMAL(10,2) 
    DECLARE @after_nUserId INT      
    DECLARE @after_cFirstName VARCHAR(20) 
    DECLARE @after_cSurname VARCHAR(20) 
    DECLARE @after_cAddress VARCHAR(60) 
    DECLARE @after_cPhoneNo VARCHAR(8) 
    DECLARE @after_nCityId INT 
    DECLARE @after_cEmail VARCHAR (60)
    DECLARE @after_nTotalAmount DECIMAL(10,2)      
    DECLARE @cStatementType VARCHAR(10) 
    DECLARE @dtExecutedAt DATETIME 
    DECLARE @nDBMSId INT
    DECLARE @cDBMSName NVARCHAR(128) 
    DECLARE @cHostId CHAR(8) 
    DECLARE @cHostName NVARCHAR(128)
    
    SELECT @before_nUserId = nUserId from deleted
    SELECT @before_cFirstName = cFirstName from deleted 
    SELECT @before_cSurname = cSurname from deleted 
    SELECT @before_cAddress = cAddress from deleted 
    SELECT @before_cPhoneNo = cPhoneNo from deleted  
    SELECT @before_nCityId = nCityId from deleted 
    SELECT @before_cEmail = cEmail from deleted 
    SELECT @before_nTotalAmount = nTotalAmount from deleted
    SELECT @after_nUserId = nUserId from inserted
    SELECT @after_cFirstName = cFirstName from inserted 
    SELECT @after_cSurname = cSurname from inserted 
    SELECT @after_cAddress = cAddress from inserted 
    SELECT @after_cPhoneNo = cPhoneNo from inserted 
    SELECT @after_nCityId = nCityId from inserted 
    SELECT @after_cEmail = cEmail from inserted 
    SELECT @after_nTotalAmount = nTotalAmount from inserted 
    SELECT @cStatementType = 'UPDATE' 
    
    SET @dtExecutedAt = GETDATE() 
    SET @nDBMSId = USER_ID() 
    SET @cDBMSName = USER_NAME() 
    SET @cHostId = HOST_ID() 
    SET @cHostName = HOST_NAME() 

EXEC pro_InsertIntoAuditUsers 
    @before_nUserId,
    @before_cFirstName,
    @before_cSurname,
    @before_cAddress, 
    @before_cPhoneNo,  
    @before_nCityId, 
    @before_cEmail,     
    @before_nTotalAmount, 
    @after_nUserId,     
    @after_cFirstName, 
    @after_cSurname, 
    @after_cAddress, 
    @after_cPhoneNo,  
    @after_nCityId, 
    @after_cEmail,
    @after_nTotalAmount,      
    @cStatementType, 
    @dtExecutedAt, 
    @nDBMSId,
    @cDBMSName, 
    @cHostId, 
    @cHostName

END;
GO
ALTER TABLE [dbo].[TUser] ENABLE TRIGGER [trg_OnUserUpdate]
GO
ALTER DATABASE [WebShopDB] SET  READ_WRITE 
GO

--Product ID = 2
UPDATE TProduct
SET nStock = 20
WHERE nProductId = 2

GO

UPDATE TProduct
SET nUnitPrice = 58
WHERE nProductId = 2

GO

UPDATE TProduct
SET cDescription = 'Updated Description'
WHERE nProductId = 2

GO

--Product ID = 7
UPDATE TProduct
SET nStock = 20
WHERE nProductId = 7

GO

UPDATE TProduct
SET nStock = 25
WHERE nProductId = 7

GO

UPDATE TProduct
SET nStock = 10
WHERE nProductId = 7

GO

--Product ID = 12
UPDATE TProduct
SET cDescription = 'We changed our mind on description.'
WHERE nProductId = 12

GO

UPDATE TProduct
SET cDescription = 'The last one was better.'
WHERE nProductId = 12

GO

UPDATE TProduct
SET cDescription = 'Actually...'
WHERE nProductId = 12

GO

--Product ID = 18
UPDATE TProduct
SET nUnitPrice = 25.80
WHERE nProductId = 18

GO

UPDATE TProduct
SET nStock = 7
WHERE nProductId = 18

GO

UPDATE TProduct
SET cDescription = 'Something you really need in your life.'
WHERE nProductId = 18

GO

--Product ID = 20
UPDATE TProduct
SET nStock = 2
WHERE nProductId = 20

GO

UPDATE TProduct
SET nStock = 15
WHERE nProductId = 20

GO

UPDATE TProduct
SET nUnitPrice = 13.37 
WHERE nProductId = 20

GO
