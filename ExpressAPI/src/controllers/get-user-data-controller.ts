// Node module imports
import { Request, Response } from "express";

// Middleware imports
import decodeAuthToken from "../middlewares/decode-auth-token";
import isTokenExpired from "../middlewares/check-token-expired";

// Util imports
import { UserClientData } from "../utils/types";

async function getUserDataController(req: Request, res: Response) {
    let bodyData: any = JSON.parse(req.body);
    let authToken = bodyData["token"];
    
    if (authToken === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: "Authentication token was not provided"
        });
    }

    let decoded: UserClientData | undefined = decodeAuthToken(authToken);
    
    if (decoded === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid auth token"
        });
    }

    // Check if the auth token has not expired
    let expired: boolean | undefined = isTokenExpired(authToken);

    if (expired === undefined) {
        return res.status(500).send({
            status_code: 500,
            message: "Invalid token error"
        });
    }

    if (expired === true) {
        return res.status(400).send({
            status_code: 400,
            message: "Token is expired."
        });
    }

    return res.status(200).send({
        status_code: 200,
        user_id: decoded.user_id,
        username: decoded.username,
        location: decoded.location
    });

}

export default getUserDataController;
