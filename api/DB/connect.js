import mongoose from "mongoose";
mongoose.set('strictQuery', true);

async function connectDb(url) {
  try {
    await mongoose.connect(url);
    return console.log("Connected to database successfully!");
  } catch (err) {
    return console.dir({ err });
  }
}

export default connectDb;