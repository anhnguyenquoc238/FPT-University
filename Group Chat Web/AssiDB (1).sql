USE master
GO

CREATE DATABASE [ChatSystem]
GO

USE [ChatSystem]
GO

-- create table Messages int database IRC_MockUp
CREATE TABLE [Message] (
[ID] INT NOT NULL IDENTITY(1,1),
[UserID] INT NOT NULL,
[Content] NTEXT NOT NULL,
PRIMARY KEY (ID),
)

-- create table User
CREATE TABLE [User] (
[ID] INT NOT NULL IDENTITY(1,1),
[Username] NVARCHAR(50) NOT NULL,
[Name] NVARCHAR(30),
[Email] VARCHAR(50) NOT NULL,
[Password] VARCHAR(64) NOT NULL,
PRIMARY KEY (ID),
)

-- add foreign key UserID in Messages references to ID in table User
ALTER TABLE [Message] 
ADD CONSTRAINT FK_UserID FOREIGN KEY (UserID) REFERENCES [User](ID);

-- inject first user into table User
INSERT INTO [User] ([Username], [Name], [Email], [Password])
VALUES ('SysAdmin', 'System', 'aaa', '12345')

-- inject first message into table Message
INSERT INTO [Message] ([UserID], [Content])
VALUES ('1', 'This is the start of group conversation')
