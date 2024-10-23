CREATE PROCEDURE [dbo].[query2]
@StartDate DATE,
@StopDate DATE
AS 
BEGIN
SELECT TOP 10 Track.Name, Track.AlbumId, Track.Bytes, Track.Composer, track.GenreId, Track.MediaTypeId, 
Track.Milliseconds, Track.TrackId, Track.UnitPrice ,COUNT (Track.Name) AS 'Track Sales - Favorites', JanuaryMarch, AprilJune, JulySeptember, OctoberDecember, ArtistName   --ðëÞèïò áãáðçìÝíùí êïììáôéþí
FROM Invoice, Track, InvoiceLine, Customer 
WHERE Invoice.CustomerId = Customer.CustomerId AND
      InvoiceLine.TrackId = Track.TrackId AND
      InvoiceLine.InvoiceId = Invoice.InvoiceId AND
      Invoice.InvoiceDate > @StartDate AND  --÷ñïíéêü äéÜóôçìá ìå âÜóç ôá ôéìïëüãéá
	  Invoice.InvoiceDate < @StopDate 
      GROUP BY Track.Name, Track.AlbumId, Track.Bytes, Track.Composer, track.GenreId, Track.MediaTypeId, 
Track.Milliseconds, Track.TrackId, Track.UnitPrice, JanuaryMarch, AprilJune, JulySeptember, OctoberDecember, ArtistName   --ïìáäïðïßçóç ðùëÞóåùí áíÜ êïììÜôé
	  ORDER BY [Track Sales - Favorites] DESC --öèßíïõóá ôáîéíüìçóç áãáðçìÝíùí êïììáôéþí
END
