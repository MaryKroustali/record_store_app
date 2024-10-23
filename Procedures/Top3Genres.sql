USE [Chinook]
GO
/****** Object:  StoredProcedure [dbo].[query3]    Script Date: 15/1/2021 3:10:52 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[query3]
As 
begin
  SELECT TOP 3 Genre.Name, Genre.GenreId, COUNT (Genre.GenreId) AS 'Track Sales – Popular Genre'  --πλήθος πωλήσεων κομματιών, διαχρονικών ειδών μουσικής
FROM Genre, Invoice, InvoiceLine, Track, Customer
WHERE  Invoice.InvoiceId = InvoiceLine.InvoiceId AND
	   InvoiceLine.TrackId = Track.TrackId AND  
	   Track.GenreId = Genre.GenreId AND
	   Customer.Customerid = Invoice.CustomerId
	   GROUP BY Genre.Name, Genre.GenreId   --ομαδοποίηση πωλήσεων ανά είδος μουσικής
	   ORDER BY [Track Sales – Popular Genre] DESC  --φθίνουσα ταξινόμηση διαχρονικών ειδών
END
