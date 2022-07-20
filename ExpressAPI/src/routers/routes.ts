import { Router } from "express";

import authenticateLoginController from "../controllers/authenticate-login.controller";
import createUserController from "../controllers/create-user.controller";
import getUserDataController from "../controllers/get-user-data-controller";

export const loginRouter = Router().post("/login", authenticateLoginController);
export const registerRouter = Router().post("/register", createUserController);
export const userDataRouter = Router().post("/user", getUserDataController);
