const express = require("express");
const app = express();

const mongoose = require("mongoose");
const Note = require("./models/note");

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const mongoDbPath =
  "mongodb+srv://ibrahim:if123@cluster0.awg3u.mongodb.net/notesdb";
mongoose.connect(mongoDbPath).then(function () {
  app.get("/", function (req, res) {
    const response = { message: "API WORK" };
    res.json(response);
  });

  const noteRouter = require("./routes/note");
  app.use("/notes", noteRouter);
});
// ?retryWrites=true&w=majority&appName=Cluster0

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server started at port: ${PORT}`));

// const express = require('express');
// const mongoose = require('mongoose');
// const bodyParser = require('body-parser');
// const Note = require('./models/note');

// const app = express();

// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(bodyParser.json());

// mongoose.connect("mongodb+srv://ibrahim:if123@cluster0.awg3u.mongodb.net/notesdb").then(
//     function () {
//         app.get("/", function (req, res) {
//             res.send('Hello ITS Ibrahim');
//         });

//         app.get("/notes/list/:userid", async function (req, res) {
//             try {
//                 var notes = await Note.find({ userid: req.params.userid });
//                 res.json(notes);
//             } catch (error) {
//                 res.status(500).json({ message: "Error fetching notes" });
//             }
//         });

//         app.post("/notes/add", async function (req, res) {
//             try {
//                 const newNote = new Note({
//                     id: req.body.id,
//                     userid: req.body.userid,
//                     title: req.body.title,
//                     content: req.body.content,
//                 });

//                 await newNote.save();

//                 const response = { message: "note added successfully, id: " + req.body.id };
//                 res.json(response);
//             } catch (error) {
//                 res.status(400).json({ message: "Error adding note", error });
//             }
//         });
//     }
// );

// // Start the server
// const PORT = process.env.PORT || 3000;
// app.listen(PORT, () => console.log(`Server started at port: ${PORT}`));
