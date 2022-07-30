// Node module type imports
import { Request, response, Response } from "express"

// Model imports
import UserModel from "../models/user-model";

// Util imports
import RegexValid from "../utils/input-regex";


async function authenticateLoginController(req: Request, res: Response) {
    let bodyData: any = JSON.parse(req.body);
    let username: any = bodyData["username"];
    let password: any = bodyData["password"];

    if (username === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: "Missing field \"username\""
        });
    }

    if (typeof username !== "string") {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid username"
        });
    }

    username = username.toLowerCase();

    let userExists: boolean | undefined = await UserModel.userExists(username);

    if (userExists === undefined) {
        return res.status(500).send({
            status_code: 500,
            message: "Internal server error"
        });
    }

    if (userExists === false) {
        return res.status(404).send({
            status_code: 404,
            message: "User does not exist"
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
            message: "Invalid password"
        });
    }

    password = password.toLowerCase();

    if (!RegexValid.username(username)) {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid username format"
        });
    }

    if (!RegexValid.password(password)) {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid password format"
        });
    }

    let modelRes = await UserModel.authenticateUser(username, password);

    if (modelRes.success === false) {

        if (modelRes.status_code === 404) {
            return res.status(404).send({
                status_code: 404,
                message: "Invalid credentials"
            });
        }
        return res.status(modelRes.status_code).send({
            status_code: modelRes.status_code,
            message: "Internal server error."
        });
    }

    return res.status(200).send({
        status_code: 200,
        token: modelRes.auth_token
    });

}

export default authenticateLoginController
