import User from "../Models/USER.js";
import { StatusCodes } from "http-status-codes";
import { BadRequestError } from "../Errors/badReqErr.js";

const register = async (req, res) => {
    const { name, email, profilePic } = req.body;

    let user = await User.findOne({ email });
    if (!user) user = await User.create({ name, email, profilePic });

    const token = user.createJWT();
    res.status(StatusCodes.CREATED).json({ user, token });
};

const login = async (req, res) => {
    const user = await User.findOne(req.user);
    if (!user) throw new BadRequestError("Invalid Credentials, User Not Found!");

    const token = user.createJWT();
    res.status(StatusCodes.OK).json({ user, token });
};


export { register, login };