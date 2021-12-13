/*    ==Параметры сценариев==

    Версия исходного сервера : SQL Server 2019 (15.0.2080)
    Выпуск исходного ядра СУБД : Выпуск Microsoft SQL Server Enterprise Edition
    Тип исходного ядра СУБД : Изолированный SQL Server

    Версия целевого сервера : SQL Server 2019
    Выпуск целевого ядра СУБД : Выпуск Microsoft SQL Server Enterprise Edition
    Тип целевого ядра СУБД : Изолированный SQL Server
*/
USE [SalaryСalculation]
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (1, N'Альбина ', N'Галиуллина', N'Нафисовна', N'galiulina', N' galigulina131406', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (2, N'Александр ', N'Кудряшов', N'Витальевич', N'kudryashov', N'1', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (3, N'Светлана ', N'Велижанина', N'Николаевна', N'velizhanina', N'252525dan', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (4, N'Алевтина ', N'Плотникова', N'Валентиновна', N'plotnikova', N'12345678qwerty', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (5, N'Александр ', N'Мальцев', N'Сергеевич', N'malcev', N'qwert123', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (6, N'Екатерина ', N'Морозова', N'Владимировна', N'morozova', N'123qwer', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (7, N'Анастасия ', N'Пьянкова', N'Борисовна', N'pyankova', N'qwasweks', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (11, N'Дарья ', N'Куклева', N'Владимировна', N'kukleva', N'weekendlyleague', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (12, N'Владислав ', N'Кремлев', N'Юрьевич', N'kremlev', N'petson', 0)
INSERT [dbo].[Users] ([ID], [Name], [Middlename], [Lastname], [Login], [Password], [IsDeleted]) VALUES (13, N'Андрей ', N'Лавринов', N'Борисович', N'lavrinov', N'prisonji', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Manager] ON 

INSERT [dbo].[Manager] ([ID], [AnalysisCoefficient], [DifficultyCoefficient], [InstallationCoefficient], [JuniorMinimum], [MiddleMinimum], [SeniorMinimum], [SupportCoefficient], [TimeCoefficient], [ToMoneyCoefficient], [UserID]) VALUES (11, 0.9, 2.5, 0.7, 10000, 20000, 30000, N'0.4', CAST(N'2021-09-01T00:00:00.000' AS DateTime), 200, 1)
INSERT [dbo].[Manager] ([ID], [AnalysisCoefficient], [DifficultyCoefficient], [InstallationCoefficient], [JuniorMinimum], [MiddleMinimum], [SeniorMinimum], [SupportCoefficient], [TimeCoefficient], [ToMoneyCoefficient], [UserID]) VALUES (12, 0.8, 2, 0.5, 12000, 24000, 36000, N'0.2', CAST(N'2021-05-01T00:00:00.000' AS DateTime), 195, 1)
INSERT [dbo].[Manager] ([ID], [AnalysisCoefficient], [DifficultyCoefficient], [InstallationCoefficient], [JuniorMinimum], [MiddleMinimum], [SeniorMinimum], [SupportCoefficient], [TimeCoefficient], [ToMoneyCoefficient], [UserID]) VALUES (13, 1, 2.9, 1, 5000, 15000, 30000, N'0.2', CAST(N'2021-04-03T00:00:00.000' AS DateTime), 250, 1)
SET IDENTITY_INSERT [dbo].[Manager] OFF
GO
SET IDENTITY_INSERT [dbo].[Grade] ON 

INSERT [dbo].[Grade] ([ID], [NameGrade]) VALUES (1, N'junior')
INSERT [dbo].[Grade] ([ID], [NameGrade]) VALUES (2, N'middle')
INSERT [dbo].[Grade] ([ID], [NameGrade]) VALUES (3, N'senior')
SET IDENTITY_INSERT [dbo].[Grade] OFF
GO
SET IDENTITY_INSERT [dbo].[Executers] ON 

INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (1, 11, 1, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (2, 11, 2, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (3, 12, 3, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (4, 12, 1, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (5, 12, 2, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (6, 13, 1, 1)
INSERT [dbo].[Executers] ([ID], [ManagerID], [GradeID], [UserID]) VALUES (7, 13, 1, 1)
SET IDENTITY_INSERT [dbo].[Executers] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([ID], [NameStatus]) VALUES (1, N'Запланирована')
INSERT [dbo].[Status] ([ID], [NameStatus]) VALUES (2, N'Исполняется')
INSERT [dbo].[Status] ([ID], [NameStatus]) VALUES (3, N'Выполнена')
INSERT [dbo].[Status] ([ID], [NameStatus]) VALUES (4, N'Отменена')
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
SET IDENTITY_INSERT [dbo].[WorkTypes] ON 

INSERT [dbo].[WorkTypes] ([ID], [Name]) VALUES (1, N'Анализ и проектирование')
INSERT [dbo].[WorkTypes] ([ID], [Name]) VALUES (2, N'Установка оборудования')
INSERT [dbo].[WorkTypes] ([ID], [Name]) VALUES (3, N'Техническое обсуживание и сопровождени')
SET IDENTITY_INSERT [dbo].[WorkTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 

INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (10, 2, N'Проектирование системы для "ООО Автопром-сервис"', N'NULL', N'2018-12-14 00:00:00.000', CAST(N'2018-12-22T00:00:00.000' AS DateTime), 20, 573, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (11, 1, N'Установка оборудования для "ООО Автопром-сервис"', N'NULL', N'2018-12-15 00:00:00.000', CAST(N'2018-12-23T00:00:00.000' AS DateTime), 25, 613, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (12, 2, N'Анализ поломки оборудования у "Пятерочка"', N'NULL', N'2018-12-16 00:00:00.000', CAST(N'2018-12-24T00:00:00.000' AS DateTime), 12, 667, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (13, 3, N'Подготовить коммерческое предложение для "Евросеть"', N'NULL', N'2018-12-16 00:00:00.000', CAST(N'2018-12-24T00:00:00.000' AS DateTime), 45, 132, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (14, 4, N'Подготовить коммерческое предложение для "Дикси"', N'NULL', N'2018-12-16 00:00:00.000', CAST(N'2018-12-26T00:00:00.000' AS DateTime), 35, 857, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (15, 5, N'Установка оборудования для "ООО Магнит"', N'NULL', N'2018-12-17 00:00:00.000', CAST(N'2018-12-29T00:00:00.000' AS DateTime), 32, 627, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (16, 5, N'Установка оборудования для "Бристоль"', N'NULL', N'2018-12-17 00:00:00.000', CAST(N'2018-12-29T00:00:00.000' AS DateTime), 24, 767, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (17, 6, N'Отправить пригласительные письма потенциальным клиентам', N'NULL', N'2018-12-18 00:00:00.000', CAST(N'2018-12-29T00:00:00.000' AS DateTime), 15, 805, 1, 1, N'NULL', 0)
INSERT [dbo].[Tasks] ([ID], [ExecuterID], [Title], [Description], [CreateDateTime], [Deadline], [Difficulty], [Time], [StatusID], [WorkTypeID], [CompletedDateTime], [IsDeleted]) VALUES (18, 7, N'Отработать возражения от "Пчелки"', N'NULL', N'2018-12-20 00:00:00.000', CAST(N'2018-12-30T00:00:00.000' AS DateTime), 34, 749, 1, 1, N'NULL', 0)
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
SET IDENTITY_INSERT [dbo].[HistoryTasks] ON 

INSERT [dbo].[HistoryTasks] ([ID], [IdExecuterOld], [IdExecuterNew], [Date], [Task]) VALUES (1, 1, 2, CAST(N'2021-11-23' AS Date), N'Проектирование системы для "ООО Автопром-сервис"')
SET IDENTITY_INSERT [dbo].[HistoryTasks] OFF
GO
