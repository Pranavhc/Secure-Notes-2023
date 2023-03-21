import express from "express";
import { getAllNotes, getNote, createNote, updateNote, deleteNote } from "../Controllers/notes_controller.js";

const router = express.Router();

router.route("/").post(createNote).get(getAllNotes);
router.route("/:id").get(getNote).patch(updateNote).delete(deleteNote);

export default router;
