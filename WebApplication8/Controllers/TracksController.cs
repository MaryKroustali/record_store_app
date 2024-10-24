﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication8.Models;
using System.Data.SqlClient;

namespace WebApplication8.Controllers
{
    public class TracksController : Controller
    {
        private ChinookEntities db = new ChinookEntities();

        // GET: Tracks
        public ActionResult Index()
        {
            var track = db.Track.Include(t => t.Album).Include(t => t.Genre).Include(t => t.MediaType);
            return View(track.ToList());
        }

        // GET: Tracks/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Track track = db.Track.Find(id);
            if (track == null)
            {
                return HttpNotFound();
            }
            return View(track);
        }

        // GET: Tracks/Create
        public ActionResult Create()
        {
            ViewBag.AlbumId = new SelectList(db.Album, "AlbumId", "Title");
            ViewBag.GenreId = new SelectList(db.Genre, "GenreId", "Name");
            ViewBag.MediaTypeId = new SelectList(db.MediaType, "MediaTypeId", "Name");
            return View();
        }

        // POST: Tracks/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TrackId,Name,AlbumId,MediaTypeId,GenreId,Composer,Milliseconds,Bytes,UnitPrice")] Track track)
        {
            if (ModelState.IsValid)
            {
                db.Track.Add(track);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AlbumId = new SelectList(db.Album, "AlbumId", "Title", track.AlbumId);
            ViewBag.GenreId = new SelectList(db.Genre, "GenreId", "Name", track.GenreId);
            ViewBag.MediaTypeId = new SelectList(db.MediaType, "MediaTypeId", "Name", track.MediaTypeId);
            return View(track);
        }

        // GET: Tracks/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Track track = db.Track.Find(id);
            if (track == null)
            {
                return HttpNotFound();
            }
            ViewBag.AlbumId = new SelectList(db.Album, "AlbumId", "Title", track.AlbumId);
            ViewBag.GenreId = new SelectList(db.Genre, "GenreId", "Name", track.GenreId);
            ViewBag.MediaTypeId = new SelectList(db.MediaType, "MediaTypeId", "Name", track.MediaTypeId);
            return View(track);
        }

        // POST: Tracks/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TrackId,Name,AlbumId,MediaTypeId,GenreId,Composer,Milliseconds,Bytes,UnitPrice")] Track track)
        {
            if (ModelState.IsValid)
            {
                db.Entry(track).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AlbumId = new SelectList(db.Album, "AlbumId", "Title", track.AlbumId);
            ViewBag.GenreId = new SelectList(db.Genre, "GenreId", "Name", track.GenreId);
            ViewBag.MediaTypeId = new SelectList(db.MediaType, "MediaTypeId", "Name", track.MediaTypeId);
            return View(track);
        }

        // GET: Tracks/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Track track = db.Track.Find(id);
            if (track == null)
            {
                return HttpNotFound();
            }
            return View(track);
        }

        // POST: Tracks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Track track = db.Track.Find(id);
            db.Track.Remove(track);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult Input1()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Input1(string year)
        {
            string date = year;
            if (date == "")
            {
                return RedirectToAction("Input1");
            }
            using (var context = new ChinookEntities())
            {
                var data = context.Track.SqlQuery("[dbo].[query6] @date", new SqlParameter("date", date)).ToList();
                TempData["data"] = data;
                return RedirectToAction("sales3months");
            }

        }
        public ActionResult sales3months()
        {
            var result = TempData["data"];
            if (result != null)
            {
                return View(result);
            }
            else
            {
                return RedirectToAction("Input1");
            }

        }

        public ActionResult Input()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Input(string date1, string date2)
        {
            string since = date1;
            string till = date2;
            if (since == "" && till == "")
            {
                return RedirectToAction("Input");
            }
            else if (since == "" )
            {
                since = "2009-01-01"; 
            }
            else if (till == "" )
            {
                till = "2100-01-01"; 
            }

            using (var context = new ChinookEntities())
            {
                var data = context.Track.SqlQuery("[dbo].[query2] @StartDate, @StopDate",
                    new SqlParameter("StartDate", since),
                    new SqlParameter("StopDate", till)).ToList();
                TempData["data"] = data;
                return RedirectToAction("show");
            }
        } 
        public ActionResult Show()
        {
            var result = TempData["data"];
            if (result != null)
            {
                return View(result);
            }
            else
            {
                return RedirectToAction("Input");
            }
        }
    }
}
