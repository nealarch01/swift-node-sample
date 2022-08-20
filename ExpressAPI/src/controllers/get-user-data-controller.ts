// Node module imports
import { Request, Response } from "express";

// Middleware imports
import decodeAuthToken from "../middlewares/decode-auth-token";

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

    // Decode the auth token, returns the user client data (user_id, username, and location) if the token is valid.
    let decoded: UserClientData | undefined = decodeAuthToken(authToken);
    
    if (decoded === undefined) {
        return res.status(400).send({
            status_code: 400,
            message: "Invalid auth token"
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
