export interface DatabaseResponse {
    readonly data: any
    readonly client_message?: string 
    readonly private_message?: string
    readonly success: boolean
}

export interface UserClientData {
    user_id: number;
    username: string;
    location: string;
}

export interface userModelResponse {
    success: boolean;
    status_code: number;
    auth_token?: string; // Implicitly undefined
}
