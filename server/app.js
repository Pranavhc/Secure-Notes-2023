import express from "express";
import env from "dotenv";
import "express-async-errors";
import connectDb from "./DB/connect.js";
import authRouter from "./Routers/auth_route.js";
import noteRouter from "./Routers/note_router.js";
import authMiddleware from "./Middlewares/Authenticate.js";
import routeNotFoundErrMid from "./Middlewares/routeNotFoundErrMid.js";
import errorHandler from "./Middlewares/errorHandler.js";
import cookieParser from "cookie-parser";
import helmet from "helmet";
import cors from "cors";
import xss from "xss-clean";

env.config();
const app = express();

app.set("trust proxy", 1);

// cors header
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "http://localhost:3000");
    res.header(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept"
    );
    next();
});

// Essential Middlewares
app.use(helmet());
app.use(cors());
app.use(xss());
app.use(express.json());
app.use(cookieParser());

// Routes
app.get("/", (req, res) => res.send("<center><h1>Secure Notes - API</h1></center>"));
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/notes", authMiddleware, noteRouter);
app.use("/api/v1/welcome", authMiddleware, (req, res) => { res.status(200).json(req.user); });

// Error Handler Middlewares 
app.use(routeNotFoundErrMid);
app.use(errorHandler);

const port = process.env.PORT || 5000;
(async () => {
    try {
        await connectDb(process.env.MONGO_URI);
        app.listen(port, () => console.log(`Server's Listening on port ${port}...`));
    } catch (error) { console.error(error); }
})();