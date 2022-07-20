import jwt, { verify } from "jsonwebtoken"

import { UserClientData } from "../utils/types";
import { jwt_secret } from "../configs/secrets.json";

function decodeAuthToken(authToken: string): UserClientData | undefined {
    try {
        let decoded: any = jwt.verify(authToken, jwt_secret);
        return {
            user_id: decoded.user_id,
            username: decoded.username,
            location: decoded.location
        }
    } catch (err) {
        return undefined;
    }
}

export default decodeAuthToken;
