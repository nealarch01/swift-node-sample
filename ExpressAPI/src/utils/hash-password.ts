// Node imports
import crypto from "crypto"

// Config import
import { sha256_secret } from "../configs/secrets.json";


function hashPassword(password: string): string {
    return crypto.createHmac("sha256", sha256_secret).update(password).digest("base64");
}

export default hashPassword;
