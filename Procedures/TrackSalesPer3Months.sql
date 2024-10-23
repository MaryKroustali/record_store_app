USE [Chinook]
GO
/****** Object:  StoredProcedure [dbo].[query6]    Script Date: 21/1/2021 11:37:32 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[query6] 
@date DATETIME
AS
BEGIN

 SELECT  Track.Name , Track.ArtistName , Track.AlbumId, Track.Bytes, Track.Composer, track.GenreId, Track.MediaTypeId, 
Track.Milliseconds, Track.TrackId, Track.UnitPrice ,
       DATEPART(YEAR, MAX(Invoice.InvoiceDate)) AS 'Year', --έτος πώλησης 
       Track.JanuaryMarch,  --πωλήσεις 1ου τριμήνου
       Track.AprilJune,     --πωλήσεις 2ου τριμήνου
       Track.JulySeptember, --πωλήσεις 3ου τριμήνου
       Track.OctoberDecember--πωλήσεις 4ου τριμήνου
 FROM InvoiceLine, Invoice, Track, Artist, Album
 WHERE DATEPART(yy, Invoice.InvoiceDate) = Datepart(yy, @date) AND  --επιλογή έτους
       Invoice.InvoiceId = InvoiceLine.InvoiceId AND
       InvoiceLine.TrackId = Track.TrackId AND
	   Album.AlbumId = Track.AlbumId AND
	   Album.ArtistId = Artist.ArtistId 
	   GROUP BY Track.Name, Artist.Name,Track.TrackId, Track.AlbumId, Track.Bytes, Track.Composer, track.GenreId, Track.MediaTypeId, 
Track.Milliseconds, Track.UnitPrice, Track.JanuaryMarch, Track.AprilJune, Track.JulySeptember, Track.OctoberDecember, Track.ArtistName --ομαδοποίηση πωλήσεων ανά καλλιτένη και κομμάτι
	   ORDER BY Artist.Name ASC, Track.Name --αύξουσα ταξινόμηση ανά καλλιτέχνη και όνομα κομματιού

END
