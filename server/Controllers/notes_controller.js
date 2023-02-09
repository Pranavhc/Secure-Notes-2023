import StatusCodes from "http-status-codes";
import Note from "../Models/NOTE.js";
import { BadRequestError } from "../Errors/badReqErr.js";

const getAllNotes = async (req, res) => {
    const notes = await Note.find({ createdBy: req.user.userID }).sort("createdAt");
    res.status(StatusCodes.OK).json({ notes, count: notes.length });
};

const getNote = async (req, res) => {
    const { user: { userID }, params: { id: noteID } } = req;
    const note = await Note.findOne({ _id: noteID, createdBy: userID });
    if (!note) throw new BadRequestError(`Note with id: ${noteID} doesn't exist!`);
    res.status(StatusCodes.OK).json(note);
};

const createNote = async (req, res) => {
    req.body.createdBy = req.user.userID;
    const note = await Note.create(req.body);
    res.status(StatusCodes.CREATED).json(note);
};

const updateNote = async (req, res) => {
    if (req.body.title, req.body.title === "") throw new BadRequestError("Title cannot be empty!");

    const note = await Note.findOneAndUpdate({ _id: req.params.id, createdBy: req.user.userID }, {
        title: req.body.title,
        content: req.body.content,
    }, { new: true });

    if (!note) throw new BadRequestError(`Note with id: ${req.params.id} doesn't exist!`);
    res.status(StatusCodes.CREATED).json(note);
};

const deleteNote = async (req, res) => {
    const { user: { userID }, params: { id: noteID } } = req;
    const note = await Note.findOneAndDelete({ _id: noteID, createdBy: userID });
    if (!note) throw new BadRequestError(`Failed - Note with id: ${noteID} doesn't exist!`);
    res.status(StatusCodes.OK).json(`Deleted note with id: ${noteID}`);
};


export { getAllNotes, getNote, createNote, updateNote, deleteNote };