USE [Chinook]
GO
/****** Object:  StoredProcedure [dbo].[query5]    Script Date: 21/1/2021 11:41:23 μμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[query5]
@StartDate DATETIME,
@StopDate DATETIME,
@customerFirst VARCHAR(30),
@CustomerLast VARCHAR(30),
@employeeFirst VARCHAR(30),
@EmployeeLast VARCHAR(30)
AS
BEGIN
  SELECT Customer.InvoiceId, Customer.Company, Customer.Address, Customer.City, Customer.Country, Customer.Email,
         Customer.CustomerId , Customer.Fax, Customer.Phone, Customer.PostalCode, Customer.State, Customer.SupportRepId, Customer.Turnover,
	   Customer.FirstName, Customer.LastName, 
       Customer.EmployeeFirst, Customer.EmployeeLast
FROM Invoice, Customer, Employee
WHERE Invoice.InvoiceDate > @StartDate AND  --χρονικό διάστημα παραγγελιών
	  Invoice.InvoiceDate < @StopDate AND
      Invoice.CustomerId = Customer.CustomerId AND
	  Customer.LastName = @CustomerLast AND  --όνομα πελάτη
	  Customer.FirstName = @customerFirst AND
	  Employee.LastName = @EmployeeLast AND   --όνομα υπαλλήλου
	  Employee.FirstName = @employeeFirst
END
