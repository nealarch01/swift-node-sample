// Node module imports
import express from "express";
// import https from "https";
// import fs from "fs";

// Router imports
import { loginRouter, registerRouter, userDataRouter } from "./src/routers/routes";


const app = express();

const port = 1234;

// app.use(bodyParser.text({
//     type: "*/*"
// }));

app.use(express.text({
    type: "application/json"
}));

app.get("/", (req: express.Request, res: express.Response) => {
    return res.send({
        status: 200,
        message: "OK"
    });
});

app.use("/auth", loginRouter);
app.use("/auth", registerRouter);
app.use("/", userDataRouter);

// Code block to create HTTPS Server
// const httpsServer = https.createServer({
//     key: fs.readFileSync("./server.key"),
//     cert: fs.readFileSync("./server.cert")
// }, app);

// httpsServer.listen(port, () => {
//     console.log(`Listening at: https://127.0.0.1:${port}/`);
// });

app.listen(port, () => {
    console.log(`Listening at: http://127.0.0.1:${port}`);
});
