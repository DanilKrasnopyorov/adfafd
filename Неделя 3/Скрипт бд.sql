USE [SalesCompany]
GO
/****** Object:  Table [dbo].[type_agents]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[type_agents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_type_agents] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[TypeProduct] [nvarchar](255) NULL,
	[idTypeProduct] [int] NULL,
	[VendorCode] [bigint] NULL,
	[NumberOfPeopleForProduction] [float] NULL,
	[MinimumPriceforanAgent] [money] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productsale]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productsale](
	[id] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[NameAgent] [nvarchar](255) NULL,
	[idАгента] [int] NULL,
	[DateProduct] [datetime] NULL,
	[CountProductSale] [float] NULL,
	[idProduct] [int] NULL,
 CONSTRAINT [PK_productsale] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[agents]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idTypeAgent] [int] NULL,
	[NameAgent] [nvarchar](255) NULL,
	[Mail] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[LogoAgent] [nvarchar](255) NULL,
	[LegalAddress] [nvarchar](255) NULL,
	[Prioritet] [float] NULL,
	[Director] [nvarchar](255) NULL,
	[INN] [bigint] NULL,
	[KPP] [bigint] NULL,
 CONSTRAINT [PK_agents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_AgentDetails]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_AgentDetails]
WITH SCHEMABINDING 
AS
SELECT        TOP (1000) dbo.type_agents.Name AS [Тип агента], dbo.agents.NameAgent AS [Наименование агента], dbo.agents.Phone AS [Номер телефона], dbo.agents.Prioritet AS Приоритет, 
                         CASE WHEN A.[Сумма продаж] < 10000 THEN 0 WHEN 10000 <= A.[Сумма продаж] AND A.[Сумма продаж] < 50000 THEN 5 WHEN 50000 <= A.[Сумма продаж] AND 
                         A.[Сумма продаж] < 150000 THEN 10 WHEN 150000 <= A.[Сумма продаж] AND A.[Сумма продаж] < 500000 THEN 20 WHEN 500000 <= A.[Сумма продаж] THEN 25 END AS [Скидка агента], B.[Количество продаж за год], 
                         A.idАгента, dbo.agents.LogoAgent
FROM            (SELECT        TOP (1000) dbo.productsale.idАгента, SUM(dbo.productsale.CountProductSale * dbo.products.MinimumPriceforanAgent) AS [Сумма продаж]
                          FROM            dbo.products INNER JOIN
                                                    dbo.productsale ON dbo.products.id = dbo.productsale.idProduct
                          GROUP BY dbo.productsale.idАгента) AS A LEFT OUTER JOIN
                             (SELECT        TOP (1000) productsale_1.idАгента, SUM(productsale_1.CountProductSale * products_1.MinimumPriceforanAgent) AS [Количество продаж за год]
                               FROM            dbo.products AS products_1 INNER JOIN
                                                         dbo.productsale AS productsale_1 ON products_1.id = productsale_1.idProduct
                               WHERE        (YEAR(productsale_1.DateProduct) = YEAR(GETDATE()))
                               GROUP BY productsale_1.idАгента) AS B ON A.idАгента = B.idАгента INNER JOIN
                         dbo.agents ON dbo.agents.Id = A.idАгента INNER JOIN
                         dbo.type_agents ON dbo.agents.idTypeAgent = dbo.type_agents.id
GO
/****** Object:  View [dbo].[View_1]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        TOP (1000) dbo.agents.Id, dbo.type_agents.Name AS [Тип агента], dbo.agents.NameAgent AS [Наименование агента], dbo.agents.Phone AS [Номер телефона], dbo.agents.Prioritet AS Приоритет, 
                         CASE WHEN A.[Сумма продаж] < 10000 THEN 0 WHEN 10000 <= A.[Сумма продаж] AND A.[Сумма продаж] < 50000 THEN 5 WHEN 50000 <= A.[Сумма продаж] AND 
                         A.[Сумма продаж] < 150000 THEN 10 WHEN 150000 <= A.[Сумма продаж] AND A.[Сумма продаж] < 500000 THEN 20 WHEN 500000 <= A.[Сумма продаж] THEN 25 END AS [Скидка агента], B.[Количество продаж за год], 
                         dbo.agents.LogoAgent
FROM            (SELECT        TOP (1000) dbo.productsale.idАгента, SUM(dbo.productsale.CountProductSale * dbo.products.MinimumPriceforanAgent) AS [Сумма продаж]
                          FROM            dbo.products INNER JOIN
                                                    dbo.productsale ON dbo.products.id = dbo.productsale.idProduct
                          GROUP BY dbo.productsale.idАгента) AS A LEFT OUTER JOIN
                             (SELECT        TOP (1000) productsale_1.idАгента, SUM(productsale_1.CountProductSale * products_1.MinimumPriceforanAgent) AS [Количество продаж за год]
                               FROM            dbo.products AS products_1 INNER JOIN
                                                         dbo.productsale AS productsale_1 ON products_1.id = productsale_1.idProduct
                               WHERE        (YEAR(productsale_1.DateProduct) = YEAR(GETDATE()))
                               GROUP BY productsale_1.idАгента) AS B ON A.idАгента = B.idАгента INNER JOIN
                         dbo.agents ON dbo.agents.Id = A.idАгента INNER JOIN
                         dbo.type_agents ON dbo.agents.idTypeAgent = dbo.type_agents.id
GO
/****** Object:  Table [dbo].[HistotyAgent]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistotyAgent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NameAgent] [varchar](50) NULL,
	[PrioritetOld] [varchar](50) NULL,
	[PrioritetNew] [varchar](50) NULL,
 CONSTRAINT [PK_HistotyAgent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[type_product]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[type_product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
 CONSTRAINT [PK_type_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[agents] ON 

INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (1, 2, N'CибБашкирТекстиль', N'vzimina@zdanova.com', N' (35222) 92-28-68', N'/agents/agent_94.png', N'429540, Мурманская область, город Воскресенск, пл. Славы, 36', 218, N'Григорий Владимирович Елисеева', 7392007090, 576103661)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (2, 1, N'CибПивОмскСнаб', N'evorontova@potapova.ru', N' (812) 743-49-87', NULL, N'816260, Ивановская область, город Москва, ул. Гагарина, 31', 477, N'Людмила Александровна Сафонова', 5676173945, 256512286)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (3, 2, N'АвтоТомскЦементЦентр', N'kabanov.valentina@subbotina.ru', N'(35222) 24-98-18', NULL, N'282009, Вологодская область, город Красногорск, пл. Домодедовская, 14', 71, N'Леонид Иванович Афанасьева', 8317739640, 940326934)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (4, 5, N'Асбоцемент', N' antonin19@panfilov.ru', N' (812) 152-28-78', N'\agents\agent_59.png', N'030119, Курганская область, город Дмитров, пер. Славы, 47', 25, N'Никитинаа Антонина Андреевна', 1261407459, 745921890)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (5, 3, N'Башкир', N'iskra.sergeev@zykov.com', N'8-800-656-63-99', N'\agents\agent_33.png', N'513065, Рязанская область, город Одинцово, шоссе Славы, 93', 35, N'Одинцова Розалина Дмитриевна', 3105334340, 117513650)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (6, 5, N'БашкирИнжКрепСбыт', N' vlad.molcanov@fomicev.ru', N'+7 (922) 495-46-18', N'\agents\agent_24.png', N'191420, Новосибирская область, город Ногинск, пер. Будапештсткая, 28', 475, N'Алиса Фёдоровна Архипова', 6771467761, 977595370)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (7, 2, N'БашкирФлотМотор-H', N'morozova.nika@kazakova.ru', N'(812) 737-79-77', N'\agents\agent_61.png', N'008081, Тюменская область, город Ногинск, въезд Гагарина, 94', NULL, N'Марат Алексеевич Фролов', 1657476072, 934931159)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (8, 1, N'БашкирЮпитерТомск', N' dyckov.veniamin@kotova.ru', N' (812) 395-91-75', N'\agents\agent_84.png', N'035268, Сахалинская область, город Волоколамск, проезд Ладыгина, 51', 139, N'Фадеева Раиса Александровна', 1606315697, 217799345)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (9, 3, N'Бум', N' belova.vikentii@konstantinova.net', N' +7 (922) 282-82-91', N'\agents\agent_103.png', N'409600, Новгородская область, город Ногинск, пл. Гагарина, 68', 82, N'Татьяна Сергеевна Королёваа', 1953785418, 122905583)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (10, 1, N'БухТеле', N'vasilev.svetlana@saskov.org', N' (35222) 89-78-68', N'\agents\agent_18.png', N'481781, Астраханская область, город Орехово-Зуево, спуск Ломоносова, 67', NULL, N'Клавдия Романовна Савина', 3547826061, 581933218)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (11, 4, N'ВодГараж', N'pmaslov@fomiceva.com', N' (35222) 11-75-66', N'\agents\agent_92.png', N'988899, Саратовская область, город Раменское, пр. Славы, 40', NULL, N'Лаврентий Фёдорович Логинова', 5575072431, 684290320)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (12, 1, N'ВодТверьХозМашина', N'tkrylov@baranova.net', N' (495) 756-36-72', N'\agents\agent_81.png', N'145030, Сахалинская область, город Шатура, въезд Гоголя, 79', 8, N'Александра Дмитриевна Ждановаа', 4174253174, 522227145)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (13, 3, N'Восток', N'nsitnikova@tikonova.org', N'(495) 227-66-48', NULL, N'284236, Воронежская область, город Павловский Посад, бульвар Ленина, 28', NULL, N'Савинаа Нина Александровна', 8929775900, 788028687)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (14, 5, N'ВостокГлав', N'gordei95@kirillov.ru', N'+7 (922) 329-34-28', N'\agents\agent_88.png', N'217022, Ростовская область, город Озёры, ул. Домодедовская, 19', 107, N'Инга Фёдоровна Дмитриева', 3580946305, 405017349)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (15, 3, N'Газ', N'ulyna.antonov@noskov.ru', N'8-800-278-78-32', N'\agents\agent_101.png', N'252821, Тамбовская область, город Пушкино, ул. Чехова, 40', NULL, N'Терентьев Илларион Максимович', 8876413796, 955381891)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (16, 2, N'ГазДизайнЖелДор', N' elizaveta.komarov@rybakov.net', N' (35222) 39-88-91', N'\agents\agent_74.png', N'695230, Курская область, город Красногорск, пр. Гоголя, 64', NULL, N'Лев Иванович Третьяков', 2396029740, 458924890)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (17, 3, N'ГлавITФлотПроф', N' savva.rybov@kolobov.ru', N'(35222) 33-48-16', N'\agents\agent_89.png', N'447811, Мурманская область, город Егорьевск, ул. Ленина, 24', 62, N'Зыкова Стефан Максимович', 2561361494, 525678825)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (18, 5, N'Гор', N'rostislav.savelev@dmitrieva.ru', N'(812) 327-52-23', N'\agents\agent_46.png', N'245009, Белгородская область, город Коломна, шоссе Домодедовская, 93', NULL, N'Адриан Александрович Одинцов', 6196739969, 784512010)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (19, 2, N'ГорДор', N'maiy12@koklov.net', N'(812) 364-46-64', N'\agents\agent_77.png', N'376483, Калужская область, город Сергиев Посад, ул. Славы, 09', 175, N'Нонна Львовна Одинцоваа', 7088187045, 440309946)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (20, 2, N'ДизайнВосток', N'efimova.timofei@tretykova.ru', N'+7 (922) 767-84-15', N'\agents\agent_17.png', N'680394, Оренбургская область, город Павловский Посад, спуск Косиора, 50', 188, N'Добрыня Сергеевич Кабанов', 6222265808, 245694799)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (21, 4, N'ДизайнФинансМикро', N' varvara15@belousov.ru', N'(495) 223-67-97', NULL, N'775051, Иркутская область, город Серебряные Пруды, спуск Домодедовская, 41', 462, N'Кузьма Борисович Королёва', 2700182907, 141912770)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (22, 1, N'ЖелДор', N' karitonova.fedosy@vasileva.net', N'(35222) 26-55-64', N'\agents\agent_51.png', N'860124, Иркутская область, город Егорьевск, пер. Гагарина, 67', NULL, N'Симоноваа Лариса Борисовна', 9392505809, 911026119)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (23, 5, N'ЖелДорДизайнМетизТраст', N'lnikitina@kulikova.com', N'8-800-692-72-18', NULL, N'170549, Сахалинская область, город Видное, проезд Космонавтов, 89', 290, N'Игорь Львович Агафонова', 7669116841, 906390137)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (24, 3, N'ИнжITЖелДор-H', N'karitonov.aleksandra@samoilov.com', N'(495) 324-18-82', N'\agents\agent_14.png', N'019291, Вологодская область, город Клин, ул. Космонавтов, 96', 129, N'Колесникова Август Владимирович', 8103088511, 604606043)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (25, 4, N'КазаньТекстиль', N'osimonova@andreeva.com', N'+7 (922) 936-37-67', N'\agents\agent_72.png', N'231891, Челябинская область, город Шатура, бульвар Ладыгина, 40', 156, N'Александров Бронислав Максимович', 4584384019, 149680499)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (26, 4, N'КазХоз', N'istrelkova@fomin.ru', N'8-800-955-44-52', NULL, N'384162, Астраханская область, город Одинцово, бульвар Гагарина, 57', 213, N'Степанова Роман Иванович', 6503377671, 232279972)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (27, 4, N'КазЮпитерТомск', N'tgavrilov@frolov.ru', N' (35222) 24-85-54', N'\agents\agent_85.png', N'393450, Тульская область, город Кашира, пр. 1905 года, 47', 244, N'Рафаил Андреевич Копылов', 9201745524, 510248846)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (28, 5, N'Компания Гараж', N' asiryeva@andreeva.com', N' (35222) 22-47-12', N'\agents\agent_91.png', N'395101, Белгородская область, город Балашиха, бульвар 1905 года, 00', NULL, N'Владлена Фёдоровна Ларионоваа', 6190244524, 399106161)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (29, 5, N'Компания КазАлмаз', N'irina.gusina@vlasova.ru', N' +7 (922) 692-21-57', N'\agents\agent_105.png', N'848810, Кемеровская область, город Лотошино, пер. Ломоносова, 90', NULL, N'Марк Фёдорович Муравьёва', 3084797352, 123190924)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (30, 5, N'Компания КрепГаз', N'iturova@isakova.ru', N' 8-800-971-62-32', N'\agents\agent_48.png', N'415525, Воронежская область, город Орехово-Зуево, спуск Ленина, 14', NULL, N'Эмилия Фёдоровна Шилова', 2910821636, 169856199)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (31, 5, N'Компания КрепЦемент', N' rusakov.efim@nikiforov.ru', N'8-800-628-79-67', N'\agents\agent_75.png', N'423477, Мурманская область, город Кашира, бульвар Домодедовская, 61', 426, N'Екатерина Львовна Суворова', 3025099903, 606083992)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (32, 5, N'Компания Метал', N'vasileva.tatyna@lebedeva.net', N' (35222) 99-39-28', N'\agents\agent_16.png', N'908229, Иркутская область, город Истра, бульвар Бухарестская, 97', NULL, N'Валентина Ивановна Громова', 9933367989, 856443865)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (33, 5, N'Компания Монтаж', N'afanasev.anastasiy@muravev.ru', N'(495) 626-86-13', N'\agents\agent_100.png', N'036381, Брянская область, город Кашира, бульвар Гагарина, 76', 124, N'Силин Даниил Иванович', 6206428565, 118570048)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (34, 5, N'Компания МясДизайнДизайн', N'gleb.gulyev@belyeva.com', N'(495) 752-21-98', N'\agents\agent_78.png', N'557264, Брянская область, город Серпухов, въезд Гоголя, 34', 491, N'Клементина Сергеевна Стрелкова', 8004989990, 908629456)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (35, 5, N'Компания ОрионСтройЛифт', N'artemii.abramova@arkipov.ru', N'8-800-381-59-97', NULL, N'819305, Воронежская область, город Талдом, шоссе Ломоносова, 36', NULL, N'Щукина Искра Максимовна', 8834229587, 958311664)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (36, 5, N'Компания Рос', N' odenisov@knyzeva.ru', N' (35222) 32-99-94', NULL, N'479740, Оренбургская область, город Наро-Фоминск, наб. Будапештсткая, 36', 252, N'Алёна Ивановна Тимофеева', 5502989807, 518320454)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (37, 5, N'Компания СервисРадиоГор', N'nika.nekrasova@kovalev.ru', N'(812) 871-21-15', N'\agents\agent_65.png', N'547196, Ульяновская область, город Серебряные Пруды, въезд Балканская, 81', NULL, N'Попов Вадим Александрович', 8880473721, 729975116)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (38, 5, N'Компания ТверьДизайн', N' ypotapov@kolesnikova.ru', N' 8-800-234-93-22', N'\agents\agent_37.png', N'672492, Калининградская область, город Москва, проезд Сталина, 64', 271, N'Доминика Александровна Никитинаа', 3567301661, 623881311)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (39, 5, N'Компания ТелекомХмельГаражПром', N'qkolesnikova@kalinina.ru', N' 8-800-617-13-37', N'\agents\agent_96.png', N'126668, Ростовская область, город Зарайск, наб. Гагарина, 69', 457, N'Костина Татьяна Борисовна', 1614623826, 824882264)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (40, 5, N'Компания ТехТеле', N'anfisa63@sobolev.ru', N'8-800-943-36-45', N'\agents\agent_42.png', N'285256, Магаданская область, город Дмитров, шоссе Ладыгина, 20', NULL, N'Тихонова Валериан Владимирович', 1553744119, 713327632)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (41, 5, N'Компания ФинансСервис', N' robert.serbakov@safonova.ru', N' 8-800-358-54-99', N'\agents\agent_63.png', N'841700, Брянская область, город Серпухов, спуск Домодедовская, 35', 395, N'Клавдия Сергеевна Виноградова', 7491491391, 673621812)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (42, 5, N'Компания Хмель', N' ermakov.mark@isakova.ru', N'(35222) 27-19-66', N'\agents\agent_67.png', N'889757, Новосибирская область, город Раменское, бульвар 1905 года, 93', 2, N'Владимир Борисович Суворова', 9004087602, 297273898)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (43, 5, N'Компания Электро', N'blokin.sofiy@terentev.ru', N'(35222) 63-92-83', N'\agents\agent_41.png', N'183744, Рязанская область, город Клин, въезд Косиора, 29', NULL, N'Кабанов Кирилл Максимович', 4335399269, 780051451)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (44, 1, N'Креп', N'savina.dominika@belousova.com', N'(495) 315-25-86', N'\agents\agent_64.png', N'336489, Калининградская область, город Можайск, наб. Славы, 35', 371, N'Назар Алексеевич Григорьева', 4880732317, 258673591)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (45, 5, N'КрепГаражСантехМаш', N'vladlen84@ersova.net', N'(495) 172-31-91', N'\agents\agent_10.png', N'207204, Пензенская область, город Одинцово, пер. Гагарина, 80', NULL, N'Аркадий Романович Тихонов', 7574946061, 146206755)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (46, 3, N'КрепТелекомТекстильМашина', N'ignatov.adam@kononova.org', N'+7 (922) 278-54-95', N'\agents\agent_39.png', N'754514, Тверская область, город Люберцы, пл. Домодедовская, 84', NULL, N'Богданов Денис Максимович', 7626613684, 187506967)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (47, 3, N'ЛенБухМикро-H', N' rybov.tatyna@merkuseva.com', N'(812) 421-59-75', N'\agents\agent_30.png', N'078797, Мурманская область, город Коломна, пр. Гоголя, 94', 242, N'Субботин Герасим Владимирович', 5943902570, 103426359)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (48, 3, N'ЛенМобайлМикро', N'frolov.artem@zuravlev.ru', N' (35222) 96-34-97', N'\agents\agent_52.png', N'737175, Ростовская область, город Одинцово, ул. Космонавтов, 99', NULL, N'Изабелла Евгеньевна Дьячкова', 6729041572, 828657559)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (49, 2, N'ЛенХозМясБанк', N' bobrov.viktor@kazakova.ru', N'(35222) 26-15-93', N'\agents\agent_31.png', N'702413, Саратовская область, город Люберцы, въезд Чехова, 15', 17, N'Арсений Алексеевич Виноградова', 9266199692, 335770867)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (50, 5, N'Метиз', N' mersova@rodionova.ru', N' (35222) 81-78-92', N'\agents\agent_54.png', N'455463, Ярославская область, город Серпухов, пер. Бухарестская, 01', 168, N'Ян Иванович Егоров', 4433116074, 949226221)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (51, 5, N'МетизТехАвтоПроф', N'anastasiy.gromov@samsonova.com', N'8-800-192-74-77', N'\agents\agent_58.png', N'713016, Брянская область, город Подольск, пл. Домодедовская, 93', NULL, N'Егор Фёдорович Третьякова', 2988890076, 215491048)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (52, 5, N'Мобайл', N' rafail22@orlov.ru', N' (495) 532-54-42', N'\agents\agent_53.png', N'273144, Калужская область, город Наро-Фоминск, бульвар Чехова, 70', NULL, N'Горшков Кузьма Фёдорович', 3655195522, 395816585)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (53, 3, N'Монтаж', N'zakar.sazonova@gavrilov.ru', N'(495) 783-36-97', N'\agents\agent_66.png', N'066594, Магаданская область, город Шаховская, спуск Сталина, 59', 300, N'Блохина Сергей Максимович', 6142194281, 154457435)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (54, 1, N'МонтажВекторМобайлЦентр', N'pavel.davydova@tretykov.net', N'(495) 566-98-62', N'\agents\agent_32.png', N'094869, Ленинградская область, город Ступино, наб. Ленина, 80', 372, N'Захар Александрович Панова', 4433392652, 757806909)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (55, 4, N'МорВостокТомскПром', N'lev.efremov@frolov.ru', N' +7 (922) 258-96-16', N'\agents\agent_20.png', N'034623, Белгородская область, город Павловский Посад, проезд Ломоносова, 72', 198, N'Гавриил Евгеньевич Селиверстов', 4082127026, 544686044)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (56, 4, N'МорГлавМонтажЭкспедиция', N'flukin@moiseeva.com', N' (812) 161-96-49', N'\agents\agent_34.png', N'313619, Читинская область, город Чехов, ул. Ленина, 38', NULL, N'Анастасия Львовна Субботинаа', 8619846965, 796144573)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (57, 4, N'МясИнфоМясТраст', N'dgulyev@krasilnikov.ru', N' (812) 375-59-29', N'\agents\agent_43.png', N'873144, Курская область, город Талдом, проезд Домодедовская, 46', NULL, N'Лихачёваа Оксана Романовна', 6387079446, 113956342)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (58, 3, N'Мясо', N' ulyna.antonov@noskov.ru', N' +7 (922) 315-51-42', N'\agents\agent_107.png', N'252821, Тамбовская область, город Пушкино, ул. Чехова, 40', 170, N'Терентьев Илларион Максимович', 1876413796, 955381891)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (59, 1, N'МясРеч', N'bkozlov@volkov.ru', N' (812) 256-74-95', N'\agents\agent_83.png', N'903648, Калужская область, город Воскресенск, пр. Будапештсткая, 91', NULL, N'Белоусоваа Ирина Максимовна', 9254261217, 656363498)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (60, 4, N'МясТрансМоторЛизинг', N' vlad.sokolov@andreev.org', N' (495) 489-75-57', N'\agents\agent_87.png', N'765320, Ивановская область, город Шатура, спуск Гоголя, 88', NULL, N'Тамара Дмитриевна Семёноваа', 6148685143, 196332656)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (61, 5, N'Орион', N'aleksei63@kiselev.ru', N'(35222) 58-77-96', N'\agents\agent_102.png', N'951035, Ивановская область, город Ступино, шоссе Космонавтов, 73', NULL, N'Мартынов Михаил Борисович', 2670166502, 716874456)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (62, 1, N'ОрионВектор', N' subbotin.rostislav@zueva.org', N'+7 (922) 456-59-29', N'\agents\agent_22.png', N'138159, Свердловская область, город Подольск, спуск Балканская, 72', NULL, N'Алексей Борисович Семёнова', 5687675108, 816451597)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (63, 5, N'ПивГлав', N' sofiy.bolsakov@isakova.ru', N' 8-800-153-74-46', N'\agents\agent_27.png', N'244290, Астраханская область, город Талдом, проезд Космонавтов, 17', NULL, N'Клим Иванович Юдин', 3090235456, 870818930)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (64, 5, N'Радио', N'rtretykova@kozlov.ru', N'(35222) 84-44-92', N'\agents\agent_68.png', N'798718, Ленинградская область, город Пушкино, бульвар Балканская, 37', NULL, N'Эмма Андреевна Колесникова', 9077613654, 657690787)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (65, 1, N'Рем', N'zanna25@nikiforova.com', N'(35222) 46-69-69', N'\agents\agent_104.png', N'707812, Иркутская область, город Шаховская, ул. Гагарина, 17', 329, N'Шароваа Елизавета Львовна', 3203830728, 456254820)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (66, 4, N'РемГаражЛифт', N'novikova.gleb@sestakov.ru', N' (35222) 18-85-61', N'\agents\agent_90.png', N'048715, Ивановская область, город Люберцы, проезд Космонавтов, 89', NULL, N'Филатов Владимир Максимович', 1656477206, 988968838)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (67, 4, N'РемСантехОмскБанк', N' anisimov.mark@vorobev.ru', N' (35222) 76-15-56', N'\agents\agent_82.png', N'289468, Омская область, город Видное, пер. Балканская, 33', 442, N'Фокина Искра Максимовна', 6823050572, 176488617)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (68, 4, N'РечИнж', N'qloginova@antonov.com', N'(812) 971-47-98', N'\agents\agent_8.png', N'862241, Кемеровская область, город Москва, пер. Славы, 63', NULL, N'Донат Иванович Кудрявцев', 9289300952, 534867576)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (69, 3, N'Рос', N'potapov.abram@trofimova.org', N'+7 (922) 822-88-76', N'\agents\agent_36.png', N'412597, Калужская область, город Клин, пр. Гагарина, 57', 158, N'Никифороваа Рената Сергеевна', 6729448041, 935241906)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (70, 5, N'РосАвтоМонтаж', N'lapin.inessa@isaeva.com', N' 8-800-468-91-51', N'\agents\agent_80.png', N'331914, Курская область, город Ногинск, спуск Ладыгина, 66', NULL, N'Диана Алексеевна Исаковаа', 4735043946, 263682488)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (71, 4, N'РосПивТверь', N'vitalii.melnikov@kopylov.com', N' +7 (922) 692-73-72', N'\agents\agent_11.png', N'053965, Магаданская область, город Видное, наб. Балканская, 41', NULL, N'Люся Фёдоровна Горшковаа', 2857470864, 732899890)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (72, 1, N'РыбАлмазГаражСнаб', N'diana.gorbunov@gromov.ru', N' (35222) 46-54-74', N'\agents\agent_29.png', N'278792, Воронежская область, город Люберцы, ул. Космонавтов, 07', NULL, N'Власов Ян Львович', 2135119617, 916748563)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (73, 5, N'СантехСеверЛенМашина', N' pgorbacev@vasilev.net', N'(812) 214-73-94', N'\agents\agent_99.png', N'606990, Новосибирская область, город Павловский Посад, въезд Домодедовская, 38', NULL, N'Павел Максимович Рожков', 3506691089, 830713603)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (74, 5, N'СеверГаз', N'smukina@evseev.com', N'(812) 973-88-81', N'\agents\agent_15.png', N'509479, Орловская область, город Павловский Посад, спуск Бухарестская, 28', 83, N'Валериан Андреевич Кириллова', 7908427926, 249521550)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (75, 3, N'СервисПив', N' znosov@vasilev.ru', N'+7 (922) 325-12-93', NULL, N'840377, Рязанская область, город Щёлково, пл. Бухарестская, 42', 329, N'Никита Александрович Королёв', 6861024038, 218034630)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (76, 4, N'СофтИнжIT', N'yliy.efimov@zdanova.ru', N' 8-800-319-27-45', N'\agents\agent_50.png', N'146295, Тверская область, город Одинцово, въезд Бухарестская, 78', NULL, N'Виктор Львович Михайлова', 2368693812, 791368408)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (77, 4, N'СофтМонтажХозСбыт', N'zinaida90@filippov.org', N' (495) 396-23-64', N'\agents\agent_44.png', N'860932, Калужская область, город Наро-Фоминск, ул. Балканская, 78', NULL, N'Харитонов Антонин Владимирович', 5408216010, 737659265)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (78, 3, N'Строй', N' soloveva.adam@andreev.ru', N'+7 (922) 129-57-13', N'\agents\agent_57.png', N'763019, Омская область, город Шатура, пл. Сталина, 56', NULL, N'Кудрявцев Адриан Андреевич', 6678884759, 279288618)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (79, 4, N'СтройГорНефть', N' lysy.kolesnikova@molcanova.com', N'(495) 852-82-84', N'\agents\agent_62.png', N'444539, Ульяновская область, город Лотошино, спуск Будапештсткая, 95', NULL, N'Тарасова Макар Максимович', 5916775587, 398299418)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (80, 1, N'ТекстильУралАвтоОпт', N'hkononova@pavlova.ru', N'(495) 418-67-55', N'\agents\agent_97.png', N'028936, Магаданская область, город Видное, ул. Гагарина, 54', NULL, N'Алина Сергеевна Дьячковаа', 3930950057, 678529397)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (81, 5, N'ТекстильУралВод', N' obespalov@alekseev.org', N'(495) 614-67-93', N'\agents\agent_9.png', N'872673, Ярославская область, город Видное, спуск Славы, 04', 28, N'Эльвира Фёдоровна Герасимова', 8336124514, 871193263)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (82, 1, N'ТелеГлавВекторСбыт', N'nsitnikov@kovaleva.ru', N'+7 (922) 619-91-52', N'\agents\agent_56.png', N'062489, Челябинская область, город Пушкино, въезд Бухарестская, 07', 185, N'Екатерина Фёдоровна Ковалёва', 9504787157, 419758597)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (83, 2, N'ТелекомЮпитер', N'kulikov.adrian@zuravlev.org', N'(812) 798-33-53', N'\agents\agent_106.png', N'959793, Курская область, город Егорьевск, бульвар Ленина, 72', NULL, N'Калинина Татьяна Ивановна', 9383182378, 944520594)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (84, 2, N'ТелеСеверМикро', N'koseleva.ylii@potapov.ru', N' (35222) 66-26-65', N'\agents\agent_12.png', N'046300, Орловская область, город Ступино, бульвар Бухарестская, 13', 254, N'Селезнёв Василий Евгеньевич', 9534974527, 344691556)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (85, 4, N'Тех', N'vasilisa99@belyev.ru', N' +7 (922) 113-94-49', N'\agents\agent_86.png', N'731935, Калининградская область, город Павловский Посад, наб. Гагарина, 59', 278, N'Аким Романович Логинова', 9282924869, 587356429)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (86, 5, N'ТомскТранс', N'antonina.krasilnikov@nikonov.ru', N'(35222) 66-22-46', N'\agents\agent_47.png', N'271624, Свердловская область, город Озёры, ул. Косиора, 21', 427, N'Архипова Юрий Дмитриевич', 6523850838, 970092830)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (87, 2, N'ТрансТверь', N'dorofeev.milan@vorobeva.net', N'(35222) 22-74-12', N'\agents\agent_25.png', N'818676, Томская область, город Павловский Посад, ул. Ладыгина, 27', NULL, N'Алина Романовна Овчинникова', 3311036393, 590018934)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (88, 3, N'Тяж', N'rodionova.ulyna@noskov.ru', N'+7 (922) 547-77-52', N'\agents\agent_35.png', N'650482, Смоленская область, город Коломна, проезд Косиора, 95', 207, N'Белов Влад Александрович', 5484904441, 943388774)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (89, 5, N'ТяжМяж', N' bzykov@baranov.com', N' (812) 425-28-46', N'\agents\agent_55.png', N'255489, Самарская область, город Озёры, ул. Ломоносова, 09', NULL, N'Юлия Львовна Горбунова', 6391522710, 209038885)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (90, 5, N'ФинансТелеТверь', N'medvedev.klim@afanasev.com', N' (495) 839-58-56', N'\agents\agent_70.png', N'687171, Томская область, город Лотошино, пл. Славы, 59', 100, N'Зайцеваа Дарья Сергеевна', 2646091050, 971874277)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (91, 2, N'ФлотБух', N'tkuznetova@sukanova.ru', N'+7 (922) 155-75-21', N'\agents\agent_21.png', N'741647, Ульяновская область, город Наро-Фоминск, ул. 1905 года, 11', 385, N'Муравьёваа Мария Дмитриевна', 4868711532, 409331823)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (92, 5, N'Цемент', N' panova.klementina@bobrov.ru', N' +7 (922) 859-19-97', N'\agents\agent_79.png', N'084315, Амурская область, город Шаховская, наб. Чехова, 62', 340, N'Анфиса Фёдоровна Буроваа', 9662118663, 650216214)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (93, 1, N'ЦементАсбоцемент', N'polykov.veronika@artemeva.ru', N' +7 (922) 133-68-96', N'\agents\agent_76.png', N'619540, Курская область, город Раменское, пл. Балканская, 12', NULL, N'Воронова Мария Александровна', 4345774724, 352469905)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (94, 4, N'ЦементАсбоцементОрионТраст', N'igulyeva@kostina.ru', N'(495) 979-36-66', N'\agents\agent_28.png', N'221534, Орловская область, город Серебряные Пруды, проезд Гагарина, 54', NULL, N'Павлова Марк Александрович', 2972154471, 668972219)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (95, 4, N'ЦементХмельОрионНаладка', N' daniil.selezneva@safonova.com', N'+7 (922) 419-14-19', N'\agents\agent_49.png', N'014379, Кировская область, город Озёры, пр. Будапештсткая, 28', 61, N'Максим Евгеньевич Гурьева', 2118874929, 482607758)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (96, 1, N'ЭлектроITITСбыт', N' eliseeva.sofy@gorskov.net', N'(812) 326-15-27', N'\agents\agent_23.png', N'855489, Вологодская область, город Серебряные Пруды, пл. Ломоносова, 57', NULL, N'Якушеваа Варвара Романовна', 1532104861, 112607081)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (97, 4, N'ЭлектроМоторТрансСнос', N'inessa.voronov@sidorova.ru', N'(495) 951-23-53', N'\agents\agent_98.png', N'913777, Самарская область, город Красногорск, ул. Бухарестская, 49', NULL, N'Людмила Евгеньевна Новиковаа', 6608362851, 799760512)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (98, 1, N'ЭлектроРемОрионЛизинг', N' anfisa.fedotova@tvetkov.ru', N' (495) 513-93-16', N'\agents\agent_93.png', N'594365, Ярославская область, город Павловский Посад, бульвар Космонавтов, 64', 198, N'Тарасова Дан Львович', 1340072597, 500478249)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (99, 2, N'ЮпитерЛенГараж-М', N'larkipova@gorbunov.ru', N'(812) 229-34-18', N'\agents\agent_73.png', N'339507, Московская область, город Видное, ул. Космонавтов, 11', 470, N'Васильева Валерия Борисовна', 2038393690, 259672761)
GO
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (100, 4, N'ЮпитерТяжОрионЭкспедиция', N'gblokin@orlov.net', N'(812) 819-51-58', N'\agents\agent_69.png', N'960726, Томская область, город Орехово-Зуево, въезд 1905 года, 51', 446, N'Валерий Евгеньевич Виноградов', 6843174002, 935556458)
INSERT [dbo].[agents] ([Id], [idTypeAgent], [NameAgent], [Mail], [Phone], [LogoAgent], [LegalAddress], [Prioritet], [Director], [INN], [KPP]) VALUES (101, 4, N'Юпитер', N'Lo@mail.ru', N'()', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[agents] OFF
GO
SET IDENTITY_INSERT [dbo].[HistotyAgent] ON 

INSERT [dbo].[HistotyAgent] ([id], [NameAgent], [PrioritetOld], [PrioritetNew]) VALUES (1, N'Асбоцемент', NULL, N'25')
INSERT [dbo].[HistotyAgent] ([id], [NameAgent], [PrioritetOld], [PrioritetNew]) VALUES (2, N'Юпитер', NULL, NULL)
SET IDENTITY_INSERT [dbo].[HistotyAgent] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (1, N'Маска на лицо открытого типа 4556', N' С клапаном', 4, 7560408, 3, 1576.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (2, N'Очки прозрачные затемненные 2256', N' С клапаном', 4, 76452269, 3, 342.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (3, N'Маска защитная закрытого типа 1359', N' Открытого типа', 3, 75996796, 4, 198.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (4, N'Защита глаз с клапаном 2579', N' С клапаном', 4, 50785095, 3, 832.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (5, N'Маска на лицо затемненные 5068', N' С клапаном', 4, 44451659, 3, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (6, N'Очки прозрачные открытого типа 2830', N' Закрытого типа', 1, 67633308, 5, 1269.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (7, N'Маска на лицо с клапаном 3370', N' Затемненные', 2, 81175619, 1, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (8, N'Маска защитная затемненные 1396', N' Затемненные', 2, 21739873, 2, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (9, N'Защита глаз затемненные 1999', N' Закрытого типа', 1, 83267291, 1, 1105.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (10, N'Маска защитная с клапаном 2921', N' Открытого типа', 3, 42906442, 4, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (11, N'Очки красные затемненные 5288', N' Открытого типа', 3, 17973888, 5, 1383.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (12, N'Маска защитная закрытого типа 1508', N' Открытого типа', 3, 38631872, 5, 1521.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (13, N'Защита глаз от воды с клапаном 5141', N' Затемненные', 2, 48232658, 2, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (14, N'Очки прозрачные с клапаном 4732', N' С клапаном', 4, 9796980, 4, 1806.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (15, N'Маска на лицо открытого типа 3158', N' Затемненные', 2, 47415783, 5, 1285.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (16, N'Очки прозрачные с клапаном 5034', N' Затемненные', 2, 6783736, 3, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (17, N'Защита глаз затемненные 1922', N' Открытого типа', 3, 63567187, 4, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (18, N'Защита глаз от воды с клапаном 1498', N' Затемненные', 2, 73250951, 5, 1868.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (19, N'Защита глаз от пыли затемненные 6614', N' Затемненные', 2, 89589447, 1, 1370.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (20, N'Очки темные открытого типа 4067', N' Затемненные', 2, 74666994, 2, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (21, N'Защита глаз открытого типа 3465', N' Открытого типа', 3, 35778001, 2, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (22, N'Защита глаз от воды закрытого типа 6052', N' Затемненные', 2, 80684143, 2, 589.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (23, N'Очки прозрачные затемненные 5848', N' С клапаном', 4, 86254159, 4, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (24, N'Маска на лицо закрытого типа 4426', N' Затемненные', 2, 78789007, 5, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (25, N'Маска на лицо открытого типа 6456', N' С клапаном', 4, 23804393, 3, 1343.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (26, N'Защита глаз открытого типа 2381', N' С клапаном', 4, 80410937, 5, 1690.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (27, N'Очки прозрачные открытого типа 6480', N' Открытого типа', 3, 23552742, 5, 729.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (28, N'Маска на лицо затемненные 6914', N' Затемненные', 2, 16837832, 1, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (29, N'Защита глаз открытого типа 1876', N' Затемненные', 2, 18274186, 1, 1754.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (30, N'Защита глаз с клапаном 2715', N' Затемненные', 2, 65896850, 3, 1769.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (31, N'Защита глаз от воды с клапаном 2922', N' Закрытого типа', 1, 32589387, 1, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (32, N'Маска защитная затемненные 3116', N' Затемненные', 2, 16694924, 3, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (33, N'Маска защитная открытого типа 5493', N' С клапаном', 4, 28669954, 4, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (34, N'Очки темные с клапаном 4354', N' Затемненные', 2, 26078631, 2, 1627.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (35, N'Защита глаз от пыли открытого типа 5443', N' Открытого типа', 3, 87162470, 5, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (36, N'Маска на лицо с клапаном 6789', N' Закрытого типа', 1, 75277715, 2, 874.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (37, N'Защита глаз с клапаном 1456', N' С клапаном', 4, 89728004, 3, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (38, N'Очки прозрачные закрытого типа 1090', N' Закрытого типа', 1, 51936367, 2, 335.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (39, N'Защита глаз от воды закрытого типа 1351', N' Открытого типа', 3, 33766997, 4, 453.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (40, N'Защита глаз с клапаном 4657', N' Открытого типа', 3, 60888572, 3, 638.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (41, N'Очки прозрачные затемненные 2009', N' Затемненные', 2, 60643813, 2, 1070.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (42, N'Очки темные с клапаном 2774', N' Открытого типа', 3, 74007987, 5, 534.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (43, N'Очки прозрачные затемненные 4299', N' Закрытого типа', 1, 30033340, 1, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (44, N'Защита глаз от воды закрытого типа 5795', N' С клапаном', 4, 37743614, 1, 1790.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (45, N'Защита глаз от пыли с клапаном 6767', N' Затемненные', 2, 57763347, 4, 371.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (46, N'Защита глаз затемненные 1433', N' Закрытого типа', 1, 19163774, 3, 1301.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (47, N'Очки прозрачные с клапаном 2870', N' Закрытого типа', 1, 14625901, 2, 1483.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (48, N'Очки прозрачные с клапаном 2928', N' С клапаном', 4, 72314954, 1, NULL)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (49, N'Очки прозрачные закрытого типа 1153', N' Затемненные', 2, 18277077, 3, 375.0000)
INSERT [dbo].[products] ([id], [Name], [TypeProduct], [idTypeProduct], [VendorCode], [NumberOfPeopleForProduction], [MinimumPriceforanAgent]) VALUES (50, N'Маска на лицо закрытого типа 2053', N' Затемненные', 2, 48084823, 5, 1617.0000)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (1, N'Маска защитная открытого типа 5493', N'РыбАлмазГаражСнаб', 72, CAST(N'2014-06-25T00:00:00.000' AS DateTime), 8, 24)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (2, N'Очки темные с клапаном 2774', N'РосПивТверь', 71, CAST(N'2011-01-04T00:00:00.000' AS DateTime), 10, 49)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (3, N'Очки красные затемненные 5288', N'КрепТелекомТекстильМашина', 46, CAST(N'2015-07-03T00:00:00.000' AS DateTime), 3, 35)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (4, N'Защита глаз открытого типа 3465', N'МясИнфоМясТраст', 57, CAST(N'2019-06-06T00:00:00.000' AS DateTime), 16, 15)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (5, N'Маска на лицо открытого типа 4556', N'Мобайл', 52, CAST(N'2014-03-28T00:00:00.000' AS DateTime), 20, 31)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (6, N'Защита глаз от воды с клапаном 2922', N'Мобайл', 52, CAST(N'2019-02-13T00:00:00.000' AS DateTime), 18, 8)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (7, N'Очки прозрачные закрытого типа 1090', N'РечИнж', 68, CAST(N'2012-04-26T00:00:00.000' AS DateTime), 17, 36)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (8, N'Очки прозрачные затемненные 2256', N'Компания КрепГаз', 30, CAST(N'2019-01-22T00:00:00.000' AS DateTime), 5, 39)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (9, N'Маска защитная затемненные 3116', N'Компания ТверьДизайн', 38, CAST(N'2017-12-09T00:00:00.000' AS DateTime), 12, 23)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (10, N'Защита глаз от пыли открытого типа 5443', N'Компания Рос', 36, CAST(N'2013-03-18T00:00:00.000' AS DateTime), 13, 11)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (11, N'Защита глаз от воды с клапаном 1498', N'Башкир', 5, CAST(N'2016-11-06T00:00:00.000' AS DateTime), 7, 7)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (12, N'Защита глаз от воды с клапаном 1498', N'РыбАлмазГаражСнаб', 72, CAST(N'2018-08-22T00:00:00.000' AS DateTime), 1, 7)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (13, N'Очки прозрачные с клапаном 2928', N'БашкирИнжКрепСбыт', 6, CAST(N'2012-08-06T00:00:00.000' AS DateTime), 12, 45)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (14, N'Маска на лицо затемненные 6914', N'РечИнж', 68, CAST(N'2011-02-27T00:00:00.000' AS DateTime), 19, 29)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (15, N'Защита глаз с клапаном 4657', N'МясИнфоМясТраст', 57, CAST(N'2016-01-09T00:00:00.000' AS DateTime), 17, 19)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (16, N'Очки прозрачные затемненные 2009', N'АвтоТомскЦементЦентр', 3, CAST(N'2018-01-14T00:00:00.000' AS DateTime), 14, 38)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (17, N'Защита глаз затемненные 1999', N'СервисПив', 75, CAST(N'2010-07-20T00:00:00.000' AS DateTime), 16, 3)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (18, N'Очки прозрачные открытого типа 2830', N'БухТеле', 10, CAST(N'2012-11-24T00:00:00.000' AS DateTime), 7, 42)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (19, N'Защита глаз от воды закрытого типа 5795', N'Восток', 13, CAST(N'2017-12-15T00:00:00.000' AS DateTime), 16, 5)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (20, N'Очки прозрачные затемненные 5848', N'ТрансТверь', 87, CAST(N'2015-06-24T00:00:00.000' AS DateTime), 10, 41)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (21, N'Защита глаз открытого типа 1876', N'ДизайнФинансМикро', 21, CAST(N'2018-03-05T00:00:00.000' AS DateTime), 19, 13)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (22, N'Маска защитная открытого типа 5493', N'РыбАлмазГаражСнаб', 72, CAST(N'2016-12-16T00:00:00.000' AS DateTime), 12, 24)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (23, N'Защита глаз от воды с клапаном 2922', N'ЛенХозМясБанк', 49, CAST(N'2019-03-10T00:00:00.000' AS DateTime), 6, 8)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (24, N'Маска защитная открытого типа 5493', N'КрепГаражСантехМаш', 45, CAST(N'2017-10-25T00:00:00.000' AS DateTime), 8, 24)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (25, N'Защита глаз от воды с клапаном 5141', N'Компания Рос', 36, CAST(N'2013-06-16T00:00:00.000' AS DateTime), 20, 9)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (26, N'Маска защитная затемненные 1396', N'Компания ТехТеле', 40, CAST(N'2016-05-05T00:00:00.000' AS DateTime), 8, 22)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (27, N'Маска защитная закрытого типа 1359', N'ТомскТранс', 86, CAST(N'2018-05-01T00:00:00.000' AS DateTime), 1, 20)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (28, N'Очки темные с клапаном 4354', N'СервисПив', 75, CAST(N'2011-03-17T00:00:00.000' AS DateTime), 20, 50)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (29, N'Очки прозрачные закрытого типа 1153', N'Тяж', 88, CAST(N'2010-05-08T00:00:00.000' AS DateTime), 13, 37)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (30, N'Защита глаз с клапаном 1456', N'Тяж', 88, CAST(N'2014-01-16T00:00:00.000' AS DateTime), 3, 16)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (31, N'Защита глаз затемненные 1999', N'КрепГаражСантехМаш', 45, CAST(N'2010-09-13T00:00:00.000' AS DateTime), 5, 3)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (32, N'Защита глаз затемненные 1922', N'ДизайнВосток', 20, CAST(N'2017-06-15T00:00:00.000' AS DateTime), 11, 2)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (33, N'Защита глаз с клапаном 1456', N'ОрионВектор', 62, CAST(N'2011-01-06T00:00:00.000' AS DateTime), 4, 16)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (34, N'Маска защитная закрытого типа 1508', N'МясИнфоМясТраст', 57, CAST(N'2013-01-28T00:00:00.000' AS DateTime), 12, 21)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (35, N'Очки темные открытого типа 4067', N'Компания Рос', 36, CAST(N'2014-09-13T00:00:00.000' AS DateTime), 8, 48)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (36, N'Очки прозрачные с клапаном 4732', N'Восток', 13, CAST(N'2010-11-04T00:00:00.000' AS DateTime), 10, 46)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (37, N'Очки прозрачные с клапаном 5034', N'Гор', 18, CAST(N'2017-12-19T00:00:00.000' AS DateTime), 16, 47)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (38, N'Защита глаз с клапаном 1456', N'ДизайнФинансМикро', 21, CAST(N'2013-06-26T00:00:00.000' AS DateTime), 9, 16)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (39, N'Защита глаз от пыли с клапаном 6767', N'МясИнфоМясТраст', 57, CAST(N'2012-10-15T00:00:00.000' AS DateTime), 10, 12)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (40, N'Очки прозрачные с клапаном 2870', N'ЭлектроITITСбыт', 96, CAST(N'2015-09-05T00:00:00.000' AS DateTime), 17, 44)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (41, N'Маска защитная затемненные 1396', N'РечИнж', 68, CAST(N'2012-08-26T00:00:00.000' AS DateTime), 7, 22)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (42, N'Защита глаз от воды закрытого типа 5795', N'ЭлектроITITСбыт', 96, CAST(N'2012-06-04T00:00:00.000' AS DateTime), 13, 5)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (43, N'Защита глаз затемненные 1433', N'ТомскТранс', 86, CAST(N'2012-06-11T00:00:00.000' AS DateTime), 12, 1)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (44, N'Маска защитная затемненные 1396', N'ЦементАсбоцементОрионТраст', 94, CAST(N'2018-05-23T00:00:00.000' AS DateTime), 8, 22)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (45, N'Очки прозрачные с клапаном 5034', N'ТелеГлавВекторСбыт', 82, CAST(N'2013-08-24T00:00:00.000' AS DateTime), 6, 47)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (46, N'Очки прозрачные с клапаном 5034', N'АвтоТомскЦементЦентр', 3, CAST(N'2011-05-10T00:00:00.000' AS DateTime), 11, 47)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (47, N'Очки прозрачные с клапаном 4732', N'ОрионВектор', 62, CAST(N'2013-02-03T00:00:00.000' AS DateTime), 1, 46)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (48, N'Очки прозрачные затемненные 2009', N'БухТеле', 10, CAST(N'2017-06-24T00:00:00.000' AS DateTime), 10, 38)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (49, N'Защита глаз от воды с клапаном 2922', N'Компания ОрионСтройЛифт', 35, CAST(N'2010-09-13T00:00:00.000' AS DateTime), 11, 8)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (50, N'Защита глаз от воды с клапаном 1498', N'МонтажВекторМобайлЦентр', 54, CAST(N'2017-09-10T00:00:00.000' AS DateTime), 9, 7)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (51, N'Защита глаз от воды с клапаном 1498', N'Гор', 18, CAST(N'2016-09-17T00:00:00.000' AS DateTime), 13, 7)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (52, N'Очки прозрачные с клапаном 4732', N'ЛенБухМикро-H', 47, CAST(N'2013-04-18T00:00:00.000' AS DateTime), 1, 46)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (53, N'Защита глаз затемненные 1922', N'Гор', 18, CAST(N'2010-08-27T00:00:00.000' AS DateTime), 6, 2)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (54, N'Очки прозрачные с клапаном 4732', N'КрепТелекомТекстильМашина', 46, CAST(N'2017-07-06T00:00:00.000' AS DateTime), 14, 46)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (55, N'Маска защитная открытого типа 5493', N'ЦементАсбоцементОрионТраст', 94, CAST(N'2013-07-10T00:00:00.000' AS DateTime), 18, 24)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (56, N'Защита глаз открытого типа 1876', N'МорГлавМонтажЭкспедиция', 56, CAST(N'2019-12-23T00:00:00.000' AS DateTime), 13, 13)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (57, N'Защита глаз с клапаном 1456', N'МорВостокТомскПром', 55, CAST(N'2019-11-07T00:00:00.000' AS DateTime), 17, 16)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (58, N'Очки темные с клапаном 4354', N'СофтИнжIT', 76, CAST(N'2011-07-20T00:00:00.000' AS DateTime), 12, 50)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (59, N'Очки темные открытого типа 4067', N'РосПивТверь', 71, CAST(N'2011-02-05T00:00:00.000' AS DateTime), 11, 48)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (60, N'Маска защитная затемненные 1396', N'СервисПив', 75, CAST(N'2016-04-17T00:00:00.000' AS DateTime), 4, 22)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (61, N'Очки прозрачные открытого типа 2830', N'Восток', 13, CAST(N'2018-02-06T00:00:00.000' AS DateTime), 18, 42)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (62, N'Маска защитная закрытого типа 1508', N'ТяжМяж', 89, CAST(N'2012-01-04T00:00:00.000' AS DateTime), 3, 21)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (63, N'Маска защитная затемненные 3116', N'ТяжМяж', 89, CAST(N'2018-12-07T00:00:00.000' AS DateTime), 15, 23)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (64, N'Маска защитная затемненные 1396', N'СервисПив', 75, CAST(N'2019-02-12T00:00:00.000' AS DateTime), 17, 22)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (65, N'Защита глаз затемненные 1922', N'ЦементХмельОрионНаладка', 95, CAST(N'2010-11-10T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (66, N'Защита глаз затемненные 1999', N'ТекстильУралВод', 81, CAST(N'2013-03-23T00:00:00.000' AS DateTime), 10, 3)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (67, N'Очки прозрачные затемненные 4299', N'ЖелДор', 22, CAST(N'2019-09-26T00:00:00.000' AS DateTime), 17, 40)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (68, N'Очки прозрачные закрытого типа 1153', N'МясИнфоМясТраст', 57, CAST(N'2013-08-24T00:00:00.000' AS DateTime), 19, 37)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (69, N'Очки прозрачные затемненные 4299', N'Компания КрепГаз', 30, CAST(N'2015-10-18T00:00:00.000' AS DateTime), 7, 40)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (70, N'Маска на лицо затемненные 5068', N'ЛенХозМясБанк', 49, CAST(N'2012-12-28T00:00:00.000' AS DateTime), 13, 28)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (71, N'Защита глаз открытого типа 3465', N'ЛенБухМикро-H', 47, CAST(N'2019-08-09T00:00:00.000' AS DateTime), 1, 15)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (72, N'Очки прозрачные затемненные 2009', N'Башкир', 5, CAST(N'2010-03-23T00:00:00.000' AS DateTime), 15, 38)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (73, N'Защита глаз открытого типа 2381', N'ДизайнФинансМикро', 21, CAST(N'2010-12-21T00:00:00.000' AS DateTime), 5, 14)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (74, N'Защита глаз открытого типа 2381', N'ДизайнФинансМикро', 21, CAST(N'2010-02-21T00:00:00.000' AS DateTime), 19, 14)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (75, N'Защита глаз открытого типа 1876', N'ЖелДор', 22, CAST(N'2014-03-24T00:00:00.000' AS DateTime), 4, 13)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (76, N'Маска защитная закрытого типа 1508', N'Компания Электро', 43, CAST(N'2018-04-18T00:00:00.000' AS DateTime), 20, 21)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (77, N'Маска на лицо открытого типа 6456', N'Восток', 13, CAST(N'2011-11-12T00:00:00.000' AS DateTime), 6, 32)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (78, N'Защита глаз от пыли затемненные 6614', N'ИнжITЖелДор-H', 24, CAST(N'2017-12-17T00:00:00.000' AS DateTime), 8, 10)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (79, N'Защита глаз от воды закрытого типа 1351', N'АвтоТомскЦементЦентр', 3, CAST(N'2018-06-24T00:00:00.000' AS DateTime), 4, 4)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (80, N'Защита глаз от воды с клапаном 2922', N'Тяж', 88, CAST(N'2014-07-10T00:00:00.000' AS DateTime), 16, 8)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (81, N'Очки прозрачные с клапаном 2928', N'Метиз', 50, CAST(N'2019-03-05T00:00:00.000' AS DateTime), 19, 45)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (82, N'Маска на лицо закрытого типа 2053', N'РыбАлмазГаражСнаб', 72, CAST(N'2017-07-20T00:00:00.000' AS DateTime), 17, 26)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (83, N'Маска на лицо открытого типа 3158', N'ТрансТверь', 87, CAST(N'2019-01-08T00:00:00.000' AS DateTime), 10, 30)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (84, N'Защита глаз открытого типа 2381', N'Компания Электро', 43, CAST(N'2017-05-05T00:00:00.000' AS DateTime), 20, 14)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (85, N'Защита глаз от пыли открытого типа 5443', N'Компания ТверьДизайн', 38, CAST(N'2013-01-12T00:00:00.000' AS DateTime), 7, 11)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (86, N'Маска защитная закрытого типа 1359', N'ЛенХозМясБанк', 49, CAST(N'2012-10-12T00:00:00.000' AS DateTime), 15, 20)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (87, N'Маска защитная с клапаном 2921', N'ТелеСеверМикро', 84, CAST(N'2014-04-12T00:00:00.000' AS DateTime), 13, 25)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (88, N'Очки прозрачные с клапаном 2870', N'СервисПив', 75, CAST(N'2018-09-11T00:00:00.000' AS DateTime), 9, 44)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (89, N'Очки прозрачные с клапаном 2870', N'Компания Рос', 36, CAST(N'2018-01-18T00:00:00.000' AS DateTime), 10, 44)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (90, N'Маска на лицо закрытого типа 2053', N'Компания Электро', 43, CAST(N'2015-03-07T00:00:00.000' AS DateTime), 19, 26)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (91, N'Защита глаз затемненные 1999', N'Рос', 69, CAST(N'2012-10-08T00:00:00.000' AS DateTime), 19, 3)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (92, N'Защита глаз затемненные 1922', N'Компания ОрионСтройЛифт', 35, CAST(N'2014-01-08T00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (93, N'Защита глаз открытого типа 2381', N'Гор', 18, CAST(N'2011-10-27T00:00:00.000' AS DateTime), 15, 14)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (94, N'Очки прозрачные затемненные 4299', N'СеверГаз', 74, CAST(N'2012-08-18T00:00:00.000' AS DateTime), 7, 40)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (95, N'Очки прозрачные открытого типа 6480', N'СофтМонтажХозСбыт', 77, CAST(N'2011-11-01T00:00:00.000' AS DateTime), 1, 43)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (96, N'Очки прозрачные с клапаном 2928', N'ТрансТверь', 87, CAST(N'2011-12-16T00:00:00.000' AS DateTime), 12, 45)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (97, N'Защита глаз от воды закрытого типа 1351', N'ЦементАсбоцементОрионТраст', 94, CAST(N'2013-04-18T00:00:00.000' AS DateTime), 5, 4)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (98, N'Очки прозрачные закрытого типа 1153', N'КрепТелекомТекстильМашина', 46, CAST(N'2010-06-09T00:00:00.000' AS DateTime), 19, 37)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (99, N'Защита глаз от воды закрытого типа 6052', N'ЖелДор', 22, CAST(N'2015-02-12T00:00:00.000' AS DateTime), 12, 6)
INSERT [dbo].[productsale] ([id], [Name], [NameAgent], [idАгента], [DateProduct], [CountProductSale], [idProduct]) VALUES (100, N'Маска на лицо закрытого типа 4426', N'ЦементАсбоцементОрионТраст', 94, CAST(N'2012-08-01T00:00:00.000' AS DateTime), 1, 27)
GO
SET IDENTITY_INSERT [dbo].[type_agents] ON 

INSERT [dbo].[type_agents] ([id], [Name]) VALUES (1, N'ЗАО')
INSERT [dbo].[type_agents] ([id], [Name]) VALUES (2, N'МКК')
INSERT [dbo].[type_agents] ([id], [Name]) VALUES (3, N'МФО')
INSERT [dbo].[type_agents] ([id], [Name]) VALUES (4, N'ОАО')
INSERT [dbo].[type_agents] ([id], [Name]) VALUES (5, N'ООО')
INSERT [dbo].[type_agents] ([id], [Name]) VALUES (6, N'ПАО')
SET IDENTITY_INSERT [dbo].[type_agents] OFF
GO
SET IDENTITY_INSERT [dbo].[type_product] ON 

INSERT [dbo].[type_product] ([id], [name]) VALUES (1, N' Закрытого типа')
INSERT [dbo].[type_product] ([id], [name]) VALUES (2, N' Затемненные')
INSERT [dbo].[type_product] ([id], [name]) VALUES (3, N' Открытого типа')
INSERT [dbo].[type_product] ([id], [name]) VALUES (4, N' С клапаном')
SET IDENTITY_INSERT [dbo].[type_product] OFF
GO
ALTER TABLE [dbo].[agents]  WITH CHECK ADD  CONSTRAINT [FK_agents_type_agents] FOREIGN KEY([idTypeAgent])
REFERENCES [dbo].[type_agents] ([id])
GO
ALTER TABLE [dbo].[agents] CHECK CONSTRAINT [FK_agents_type_agents]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_type_product] FOREIGN KEY([idTypeProduct])
REFERENCES [dbo].[type_product] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_type_product]
GO
ALTER TABLE [dbo].[productsale]  WITH CHECK ADD  CONSTRAINT [FK_productsale_agents] FOREIGN KEY([idАгента])
REFERENCES [dbo].[agents] ([Id])
GO
ALTER TABLE [dbo].[productsale] CHECK CONSTRAINT [FK_productsale_agents]
GO
ALTER TABLE [dbo].[productsale]  WITH CHECK ADD  CONSTRAINT [FK_productsale_products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[productsale] CHECK CONSTRAINT [FK_productsale_products]
GO
/****** Object:  Trigger [dbo].[TR_Agent_InsertUpdate]    Script Date: 01.12.2021 12:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[TR_Agent_InsertUpdate] on [dbo].[agents]
after Update,Insert
as
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) and UPDATE(Prioritet)
Begin 
insert into [dbo].[HistotyAgent] ([NameAgent],[PrioritetOld],[PrioritetNew])
select d.NameAgent,d.Prioritet,i.Prioritet
From deleted d inner join inserted i on d.ID = i.ID
end;	
IF EXISTS (SELECT * FROM Inserted) AND NOT EXISTS (SELECT * FROM deleted)
BEGIN
  Insert Into  [dbo].[HistotyAgent] ([NameAgent],[PrioritetOld],[PrioritetNew])
	Select i.NameAgent,i.Prioritet,null
	From inserted i
END;
GO
ALTER TABLE [dbo].[agents] ENABLE TRIGGER [TR_Agent_InsertUpdate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 102
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "agents"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 136
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_agents"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 102
               Right = 908
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 102
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "agents"
            Begin Extent = 
               Top = 6
               Left = 522
               Bottom = 265
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_agents"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 102
               Right = 908
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2760
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
