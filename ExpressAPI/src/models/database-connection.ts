import mysql from "mysql2/promise"

import DBConfig from "../configs/db-config.json"

class DatabaseConnection {
    private static connectionPool = mysql.createPool(DBConfig);

    static async create(): Promise<mysql.PoolConnection | undefined> {
        let conn: mysql.PoolConnection;
        try {
            // Aquire a database connection and return it to the caller
            return await DatabaseConnection.connectionPool.getConnection(); // Note: manually release the connection after use.
        } catch (err) {
            console.log(err);
            return undefined;
        }
    }
}

export default DatabaseConnection
