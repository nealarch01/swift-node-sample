import jwt from "jsonwebtoken"

import { jwt_secret } from "../configs/secrets.json";

function createAuthToken(user_id: number, username: string, location: string): string {
    let currentTime = new Date().getTime(); // Returns current time in UNIX Milliseconds
    let expireTime = currentTime + (60000 * 3600); // Token expires in 1 hour

    let jwtPayload = {
        user_id,
        username,
        location,
        expires: expireTime
    }
    
    return jwt.sign(jwtPayload, jwt_secret);
}

export default createAuthToken
