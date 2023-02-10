import User from "../Models/USER.js";
import { StatusCodes } from "http-status-codes";
import { BadRequestError } from "../Errors/badReqErr.js";

const register = async (req, res) => {
    const { name, email, profilePic, password } = req.body;

    let user = await User.findOne({ email });
    if (!user) user = await User.create({ name, email, profilePic, password });

    const token = user.createJWT();
    res.status(StatusCodes.CREATED).json({ user, token });
};

const login = async (req, res) => {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) throw new BadRequestError("Invalid Credentials, User Not Found!");

    const isPasswordCorrect = await user.comparePassword(password);
    if (!isPasswordCorrect) throw new UnauthenticatedError("Invalid Credentials");

    const token = user.createJWT();
    res.status(StatusCodes.OK).json({ user, token });
};


export { register, login };