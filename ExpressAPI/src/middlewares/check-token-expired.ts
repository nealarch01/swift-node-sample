import jwt from "jsonwebtoken";

import { jwt_secret } from "../configs/secrets.json";

function isTokenExpired(authToken: string): boolean | undefined {
    try {
        let decoded: any = jwt.verify(authToken, jwt_secret);

        let currentTime = new Date().getTime(); // Get current time 
        currentTime / 1000; // Divide to match "exp" timestamp

        if (currentTime >= decoded.expires) {
            return true;
        }
        return false;
    } catch (err) {
        return undefined;
    }
}

export default isTokenExpired;
