-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Ноя 21 2024 г., 13:06
-- Версия сервера: 8.0.40-0ubuntu0.22.04.1
-- Версия PHP: 8.1.2-1ubuntu2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- База данных: prj
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`dmn`@`%` PROCEDURE `Developers_AllowedForProject` (IN `ProjID` INT)   begin
    select D.DeveloperID,
           D.DeveloperFullName
      from Developers D
           left join ProjDevel PD on (
               D.DeveloperID=PD.DeveloperID and
               PD.ProjectID = ProjID               
	   )
     where PD.DeveloperID is null;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Developers_L` ()   begin
    select D.DeveloperID,
           D.DeveloperFullName,
           (year(current_date)-year(D.Birthday))-(right(current_date,5)<right(D.Birthday,5)) as Age,
           count(PD.ProjectID) as ProjectsCnt
      from Developers D
           left join ProjDevel PD on (D.DeveloperID = PD.DeveloperID)
     group by 1,2,3;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Developers_ProjectsParticipatesIn` (IN `DevelID` INT)   begin
    select P.ProjectID,
           P.ProjectName
      from Projects P
           join ProjDevel PD on (P.ProjectID = PD.ProjectID)
     where PD.DeveloperID = DevelID;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Developers_S` (IN `DevelID` INT)   begin
    select D.DeveloperID,
           D.DeveloperFullName,
           D.Birthday,
           D.Post,
           D.Email,
           D.Phone
      from Developers D
     where D.DeveloperID = DevelID;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Projects_AllowedForDeveloper` (IN `DevelID` INT)   begin
    select P.ProjectID,
           P.ProjectName
      from Projects P
           left join ProjDevel PD on (
               P.ProjectID = PD.ProjectID and
               PD.DeveloperID = DevelID               
	   )
     where PD.ProjectID is null;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Projects_DevelopersWorkingOn` (IN `ProjID` INT)   begin
    select D.DeveloperID,
           D.DeveloperFullName
      from Developers D
           join ProjDevel PD on (D.DeveloperID = PD.DeveloperID)
     where PD.ProjectID = ProjID;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Projects_L` ()   BEGIN
    select P.ProjectID,
           P.ProjectName,
           count(PD.DeveloperID) as DevelopersCnt
      from Projects P
           left join ProjDevel PD on (P.ProjectID = PD.ProjectID)
     group by 1,2;	  
END$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Projects_S` (IN `ProjID` INT)   begin
    select P.ProjectID,
           P.ProjectName,
           P.Customer
      from Projects P
     where P.ProjectID = ProjID;
end$$

CREATE DEFINER=`dmn`@`%` PROCEDURE `Test` ()   BEGIN
    select P.ProjectID,
       P.ProjectName,
           count(PD.DeveloperID) as DevelopersCnt
      from Projects P
           left join ProjDevel PD on (P.ProjectID = PD.ProjectID)
      group by 1, 2;	  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы Developers
--

CREATE TABLE Developers (
  DeveloperID int NOT NULL,
  DeveloperFullName varchar(255) NOT NULL,
  Birthday date NOT NULL,
  Post varchar(45) NOT NULL,
  Email varchar(45) NOT NULL,
  Phone varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы Developers
--

INSERT INTO Developers (DeveloperID, DeveloperFullName, Birthday, Post, Email, Phone) VALUES
(1, 'Иван Голосов', '1987-12-05', 'Спец. по ИТ', 'golosov@gmail.com', '+79222222222'),
(2, 'Сергей Инюткин', '1992-05-17', 'Разраюотчик', 'brandasmig@yandex.ru', '+79122868757'),
(3, 'Игорь Налобин', '1995-10-03', 'Программист', 'inalobin@tambler.ru', '+79229999999'),
(4, 'Александр Каратун', '1990-07-22', 'Программист на Python', 'alex.kar@mail.ru', '+79021243567');

-- --------------------------------------------------------

--
-- Структура таблицы ProjDevel
--

CREATE TABLE ProjDevel (
  ProjectID int NOT NULL,
  DeveloperID int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы ProjDevel
--

INSERT INTO ProjDevel (ProjectID, DeveloperID) VALUES
(1, 1),
(2, 2),
(3, 2),
(1, 3),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Структура таблицы Projects
--

CREATE TABLE Projects (
  ProjectID int NOT NULL,
  ProjectName varchar(255) NOT NULL,
  Customer varchar(255) NOT NULL COMMENT 'Customer -- по идее д.б. ссылкой (внешним ключем) на таблицу заказчиков, но щас просто храним тут наименование заказчика. '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы Projects
--

INSERT INTO Projects (ProjectID, ProjectName, Customer) VALUES
(1, 'Нож', 'Рога и Копыта, ООО'),
(2, 'Арахис', 'Администрация'),
(3, 'Береза', 'Никомед, ОАО'),
(4, 'Булава', 'Sony, LTD');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы Developers
--
ALTER TABLE Developers
  ADD PRIMARY KEY (DeveloperID);

--
-- Индексы таблицы ProjDevel
--
ALTER TABLE ProjDevel
  ADD PRIMARY KEY (ProjectID,DeveloperID),
  ADD KEY FK_DeveloperID_idx (DeveloperID);

--
-- Индексы таблицы Projects
--
ALTER TABLE Projects
  ADD PRIMARY KEY (ProjectID),
  ADD KEY IDX_Projects (ProjectName);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы Developers
--
ALTER TABLE Developers
  MODIFY DeveloperID int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы Projects
--
ALTER TABLE Projects
  MODIFY ProjectID int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы ProjDevel
--
ALTER TABLE ProjDevel
  ADD CONSTRAINT FK_DeveloperID FOREIGN KEY (DeveloperID) REFERENCES Developers (DeveloperID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT FK_ProjectID FOREIGN KEY (ProjectID) REFERENCES Projects (ProjectID) ON DELETE CASCADE ON UPDATE CASCADE;
