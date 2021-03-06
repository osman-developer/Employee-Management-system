USE [master]
GO
/****** Object:  Database [EmployeeDB]    Script Date: 5/1/2021 7:17:17 PM ******/
CREATE DATABASE [EmployeeDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeDB', FILENAME = N'D:\Programming\Employee system\Database\files\EmployeeDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployeeDB_log', FILENAME = N'D:\Programming\Employee system\Database\files\EmployeeDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EmployeeDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeeDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmployeeDB] SET QUERY_STORE = OFF
GO
USE [EmployeeDB]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](500) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](500) NULL,
	[Department] [varchar](500) NULL,
	[DateOfJoining] [datetime] NULL,
	[PhotoFileName] [varchar](700) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UP_DELETE_DEPARTMENT]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_DELETE_DEPARTMENT]  
(      
  @DepartmentId AS INT      
)      
AS      
BEGIN      
 DELETE      
 FROM  dbo.Department      
 WHERE DepartmentId = @DepartmentId
END
GO
/****** Object:  StoredProcedure [dbo].[UP_DELETE_EMPLOYEE]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_DELETE_EMPLOYEE]  
(      
  @EmployeeId AS INT      
)      
AS      
BEGIN      
 DELETE      
 FROM  dbo.Employee       
 WHERE EmployeeId = @EmployeeId
END
GO
/****** Object:  StoredProcedure [dbo].[UP_EDIT_DEPARTMENT]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_EDIT_DEPARTMENT]    
(  
@DepartmentId AS INT,  
@DepartmentName AS VARCHAR(500) 

 )   
 AS  
BEGIN      
 IF @DepartmentId  = -1      
 BEGIN      
  INSERT INTO dbo.Department(DepartmentName) VALUES (@DepartmentName)      
 END      
 ELSE      
 BEGIN    
   UPDATE  dbo.Department    
    SET     
     DepartmentName = @DepartmentName   

    WHERE  DepartmentId = @DepartmentId  
  END    
  END
GO
/****** Object:  StoredProcedure [dbo].[UP_EDIT_EMPLOYEE]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_EDIT_EMPLOYEE]     
(  
@EmployeeId AS INT,  
@EmployeeName AS VARCHAR(500),  
@Department AS VARCHAR(500),  
@DateOfJoining AS DATE,
@PhotoFileName AS VARCHAR(700)   
  
 )   
 AS  
BEGIN      
 IF @EmployeeId  = -1      
 BEGIN      
  INSERT INTO dbo.Employee(EmployeeName,Department,DateOfJoining,PhotoFileName) VALUES (@EmployeeName,@Department,@DateOfJoining,@PhotoFileName)      
 END      
 ELSE      
 BEGIN    
   UPDATE  dbo.Employee    
    SET     
     EmployeeName = @EmployeeName,    
    Department = @Department,  
 DateOfJoining=@DateOfJoining,  
 PhotoFileName=@PhotoFileName   
    WHERE  EmployeeId = @EmployeeId
  END    
  END
GO
/****** Object:  StoredProcedure [dbo].[UP_GET_DEPARTMENT_BY_WHERE]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_GET_DEPARTMENT_BY_WHERE]
(    
@DepartmentId INT =null ,    
@DepartmentName VARCHAR(500) =null       
  
)    
AS    
BEGIN  
	if(@DepartmentId is null) and (@DepartmentName is null)
	 Begin
		select * from dbo.Department;
	 End

	 else if(@DepartmentId is not null) and (@DepartmentName is null)
	 Begin
		select * from dbo.Department where DepartmentId=@DepartmentId;
	 end

	 else if (@DepartmentId is null) and (@DepartmentName is not null)
	Begin
		select * from dbo.Department where DepartmentName LIKE '%'+@DepartmentName+'%';
	end
	--else if(@DepartmentId!=null and @DepartmentName!=null) 
	--Begin 
	--	select * from dbo.Department where DepartmentId=@DepartmentId and DepartmentName=@DepartmentName;
	--end
	else
	Begin
		Select * from dbo.Department where DepartmentId=@DepartmentId and DepartmentName LIKE '%'+@DepartmentName+'%' ;
	end
end
GO
/****** Object:  StoredProcedure [dbo].[UP_GET_DEPARTMENTS]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_GET_DEPARTMENTS]    
AS    
BEGIN     
 SELECT * FROM dbo.Department    
END
GO
/****** Object:  StoredProcedure [dbo].[UP_GET_EMP_DEPARTMENTS]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_GET_EMP_DEPARTMENTS]   
AS      
BEGIN       
 select DepartmentName from dbo.Department     
END
GO
/****** Object:  StoredProcedure [dbo].[UP_GET_EMPLOYEES]    Script Date: 5/1/2021 7:17:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UP_GET_EMPLOYEES]    
AS    
BEGIN     
 SELECT * FROM dbo.Employee    
END
GO
USE [master]
GO
ALTER DATABASE [EmployeeDB] SET  READ_WRITE 
GO
