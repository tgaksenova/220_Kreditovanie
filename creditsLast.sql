USE [master]
GO
/****** Object:  Database [PR30]    Script Date: 22.10.2023 19:49:04 ******/
CREATE DATABASE [PR30]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PR30', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PR30.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PR30_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PR30_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PR30] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PR30].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PR30] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PR30] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PR30] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PR30] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PR30] SET ARITHABORT OFF 
GO
ALTER DATABASE [PR30] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PR30] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PR30] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PR30] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PR30] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PR30] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PR30] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PR30] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PR30] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PR30] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PR30] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PR30] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PR30] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PR30] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PR30] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PR30] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PR30] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PR30] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PR30] SET  MULTI_USER 
GO
ALTER DATABASE [PR30] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PR30] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PR30] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PR30] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PR30] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PR30] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PR30] SET QUERY_STORE = ON
GO
ALTER DATABASE [PR30] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PR30]
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 22.10.2023 19:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Debtors]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Debtors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InformationAboutLoans]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformationAboutLoans](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoansName] [nvarchar](50) NULL,
	[LoansTerm] [int] NULL,
	[InterestRate] [decimal](5, 2) NULL,
	[DownPayment] [decimal](11, 2) NULL,
	[MonthlyPayment] [decimal](11, 2) NULL,
	[LifeInsurance] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BankID] [int] NULL,
	[StartDate] [date] NULL,
	[DebtorID] [int] NULL,
	[InformationAboutLoansID] [int] NULL,
	[RealEstateObjectsID] [int] NULL,
	[AdditionalConditions] [nvarchar](max) NULL,
	[IsAccepted] [bit] NULL,
	[IsDecline] [bit] NULL,
	[IsPaid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RealEstateCategory]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RealEstateCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EstateCategory] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RealEstateObjects]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RealEstateObjects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RealEstateTypeID] [int] NULL,
	[RealEstateCategoryID] [int] NULL,
	[Price] [decimal](11, 2) NULL,
	[Address] [nvarchar](max) NULL,
	[Paid] [decimal](11, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RealEstateType]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RealEstateType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EstateType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22.10.2023 19:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Patronymic] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Banks] ON 

INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (1, N'Сбербанк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (2, N'Тинькофф Банк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (3, N'ВТБ')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (4, N'Россельхозбанк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (5, N'Совкомбанк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (6, N'Райффайзенбанк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (7, N'Газпромбанк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (8, N'Альфа-Банк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (9, N'Почта Банк')
INSERT [dbo].[Banks] ([ID], [BankName]) VALUES (10, N'Ренессанс Банк')
SET IDENTITY_INSERT [dbo].[Banks] OFF
GO
SET IDENTITY_INSERT [dbo].[Debtors] ON 

INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (1, 1)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (2, 2)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (3, 4)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (4, 8)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (5, 10)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (6, 5)
INSERT [dbo].[Debtors] ([ID], [UserID]) VALUES (7, 6)
SET IDENTITY_INSERT [dbo].[Debtors] OFF
GO
SET IDENTITY_INSERT [dbo].[InformationAboutLoans] ON 

INSERT [dbo].[InformationAboutLoans] ([ID], [LoansName], [LoansTerm], [InterestRate], [DownPayment], [MonthlyPayment], [LifeInsurance]) VALUES (20, N'Кредит', 2, CAST(12.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(127523.30 AS Decimal(11, 2)), 0)
INSERT [dbo].[InformationAboutLoans] ([ID], [LoansName], [LoansTerm], [InterestRate], [DownPayment], [MonthlyPayment], [LifeInsurance]) VALUES (21, N'Кредит', 5, CAST(54.00 AS Decimal(5, 2)), CAST(45000.00 AS Decimal(11, 2)), CAST(92600.00 AS Decimal(11, 2)), 0)
SET IDENTITY_INSERT [dbo].[InformationAboutLoans] OFF
GO
SET IDENTITY_INSERT [dbo].[Loans] ON 

INSERT [dbo].[Loans] ([ID], [BankID], [StartDate], [DebtorID], [InformationAboutLoansID], [RealEstateObjectsID], [AdditionalConditions], [IsAccepted], [IsDecline], [IsPaid]) VALUES (22, 7, CAST(N'2023-10-22' AS Date), 1, 20, 21, N'Отсутствует', 1, 0, 1)
INSERT [dbo].[Loans] ([ID], [BankID], [StartDate], [DebtorID], [InformationAboutLoansID], [RealEstateObjectsID], [AdditionalConditions], [IsAccepted], [IsDecline], [IsPaid]) VALUES (23, 10, CAST(N'2023-10-22' AS Date), 1, 21, 22, N'Отсутствует', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[Loans] OFF
GO
SET IDENTITY_INSERT [dbo].[RealEstateCategory] ON 

INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (1, N'Нежилое здание')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (2, N'Жилой дом')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (3, N'Многоквартирный дом')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (4, N'Садовый дом')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (5, N'Гараж')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (6, N'Квартира')
INSERT [dbo].[RealEstateCategory] ([ID], [EstateCategory]) VALUES (7, N'Комната (в квартире)')
SET IDENTITY_INSERT [dbo].[RealEstateCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[RealEstateObjects] ON 

INSERT [dbo].[RealEstateObjects] ([ID], [RealEstateTypeID], [RealEstateCategoryID], [Price], [Address], [Paid]) VALUES (21, 4, 7, CAST(255046.60 AS Decimal(11, 2)), N'Мимо', CAST(255046.60 AS Decimal(11, 2)))
INSERT [dbo].[RealEstateObjects] ([ID], [RealEstateTypeID], [RealEstateCategoryID], [Price], [Address], [Paid]) VALUES (22, 4, 2, CAST(508000.00 AS Decimal(11, 2)), N'Не знаю', CAST(508000.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[RealEstateObjects] OFF
GO
SET IDENTITY_INSERT [dbo].[RealEstateType] ON 

INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (1, N'Земельный участок')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (2, N'Здание')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (3, N'Сооружение')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (4, N'Помещение')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (5, N'Машино-место')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (6, N'Объект незавершенного строительства')
INSERT [dbo].[RealEstateType] ([ID], [EstateType]) VALUES (7, N'Единый недвижимый комплекс')
SET IDENTITY_INSERT [dbo].[RealEstateType] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (1, N'87Eddj', N'l9ttlO', N'Ипатий', N'Ермакович', N'Стацевич')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (2, N'xOXSjs', N'4wqcLy', N'Сидор', N'Вячеславович', N'Подорожный')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (3, N'0qYC5C', N'TT2Ff4', N'Владислава', N'Яковлевна', N'Демьянова')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (4, N'StanimirKukolevskiy361', N'PWOgrOPOr9is', N'Станимир', N'Эльдарович', N'Куколевский')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (5, N'SavvaRzhevskiy110', N'UiGDCEK5OhnW', N'Савва', N'Геннадьевич', N'Ржевский')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (6, N'DominikaLvova227', N'6zdj8g32WaFY', N'Доминика', N'Сергеевна', N'Львова')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (7, N'StanislavaSolntseva998', N'E5Gt5WA9wt6a', N'Станислава', N'Леонидовна', N'Солнцева')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (8, N'YaropolkMalyshev475', N'0977EtkZNZ0t', N'Ярополк', N'Семенович', N'Малышев')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (9, N'AmvrosiyProkofev681', N'1QaOMi7H1tHw', N'Амвросий', N'Макарович', N'Прокофьев')
INSERT [dbo].[Users] ([ID], [Login], [Password], [Name], [Patronymic], [Surname]) VALUES (10, N'PankratiyAntonov938', N'd7WXkbpVaLVA', N'Панкратий', N'Закирович', N'Антонов')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Debtors]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([BankID])
REFERENCES [dbo].[Banks] ([ID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([DebtorID])
REFERENCES [dbo].[Debtors] ([ID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([InformationAboutLoansID])
REFERENCES [dbo].[InformationAboutLoans] ([ID])
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD FOREIGN KEY([RealEstateObjectsID])
REFERENCES [dbo].[RealEstateObjects] ([ID])
GO
ALTER TABLE [dbo].[RealEstateObjects]  WITH CHECK ADD FOREIGN KEY([RealEstateTypeID])
REFERENCES [dbo].[RealEstateType] ([ID])
GO
ALTER TABLE [dbo].[RealEstateObjects]  WITH CHECK ADD FOREIGN KEY([RealEstateCategoryID])
REFERENCES [dbo].[RealEstateCategory] ([ID])
GO
USE [master]
GO
ALTER DATABASE [PR30] SET  READ_WRITE 
GO
