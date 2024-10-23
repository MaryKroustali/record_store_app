USE [chinook]
GO
/****** Object:  StoredProcedure [dbo].[query1]    Script Date: 16/1/2021 10:41:06 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[query1] 
 @X INT, --κορυφαίοι X καλλιτέχνες
 @StartDate DATETIME,  --ημερομηνία αναζήτησης
 @StopDate DATETIME
AS
 BEGIN
    SELECT TOP (@X) Artist.Name, Artist.ArtistId, COUNT (Album.Title) as 'Album Sales' --πλήθος άλμπουμ που πωλήθηκαν
FROM Artist, InvoiceLine, Album, Invoice, Track 
WHERE Invoice.InvoiceDate > @StartDate AND --χρονικό διάστημα με βάση τα τιμολόγια
	  Invoice.InvoiceDate < @StopDate AND 
      Invoice.InvoiceId = InvoiceLine.InvoiceId AND
	  InvoiceLine.TrackId = Track.TrackId AND  
	  Track.AlbumId = Album.AlbumId AND
	  Album.ArtistId = Artist.ArtistId
	  GROUP BY Artist.Name, Artist.ArtistId         --άλμπουμ ανά καλλιτέχνη
	  ORDER BY [Album Sales] DESC  --ταξινόμηση πωλήσεων με φθίνουσα σειρά
END
