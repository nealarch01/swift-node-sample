import jwt from "jsonwebtoken"

import { jwt_secret } from "../configs/secrets.json";

function createAuthToken(user_id: number, username: string, location: string): string {
    let jwtPayload = {
        user_id,
        username,
        location
    }
    
    return jwt.sign(jwtPayload, jwt_secret, { expiresIn: "3h" });
}

export default createAuthToken
