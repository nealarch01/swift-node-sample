// Type imports
import { Request, Response } from "express"

// Model imports
import UserModel from "../models/user-model";

// Util imports
import RegexValid from "../utils/input-regex";



async function createUserController(req: Request, res: Response) {
    let bodyData = JSON.parse(req.body);
    let username: any = bodyData["username"];
    let password: any = bodyData["password"];
    let location: any = bodyData["location"];

    if (username === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: `Missing field "username"`
        });
    }

    if (typeof username !== "string") {
        return res.status(406).send({
            status_code: 406,
            message: `Invalid username`
        });
    }

    username = username.toLowerCase();

    if (!RegexValid.username(username)) {
        return res.status(400).send({
            status_code: 400,
            message: `Missing field "username"`
        });
    }

    // Check if the username has already been taken

    let usernameTaken: boolean | undefined = await UserModel.userExists(username);

    if (usernameTaken === undefined) {
        return res.status(500).send({
            status_code: 500,
            message: "Internal server error."
        });
    }

    if (usernameTaken === true) {
        return res.status(400).send({
            status_code: 400,
            message: `Username taken`
        });
    }

    if (password === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: `Missing field "password"`
        });
    }

    if (typeof password !== "string") {
        return res.status(400).send({
            status_code: 400,
            message: `Missing field "password"`
        });
    }

    if (location === undefined || typeof location !== "string") {
        location = "";
    }

    if (!RegexValid.password(password)) {
        return res.status(400).send({
            status_code: 400,
            message: ""
        });
    }

    if (!RegexValid.location(location)) {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid location"
        });
    }

    let modelRes = await UserModel.createUser(username, password, location);
    if (modelRes === undefined) {
        return res.status(500).send({
            status_code: 500,
            message: "Connection error"
        });
    }

    return res.status(201).send({
        status_code: 201,
        token: modelRes.auth_token
    });

}

export default createUserController
