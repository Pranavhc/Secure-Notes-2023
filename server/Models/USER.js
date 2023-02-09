import mongoose from "mongoose";
import jwt from "jsonwebtoken";

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, "Please Provide Name!"]
    },

    email: {
        type: String,
        match: [
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
            "Please Provide Email!",
        ],
        unique: true,
    },

    profilePic: {
        type: String,
        required: true,
    },
});

userSchema.methods.createJWT = function () {
    return jwt.sign({ userID: this._id, name: this.name }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_LIFETIME });
};

export default mongoose.model("user", userSchema);