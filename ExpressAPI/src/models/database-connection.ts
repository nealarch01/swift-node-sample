import mysql from "mysql2/promise"

import DBConfig from "../configs/db-config.json"

class DatabaseConnection {
    private static connectionPool = mysql.createPool(DBConfig);

    static async create(): Promise<mysql.PoolConnection | undefined> {
        let conn: mysql.PoolConnection;
        try {
            conn = await this.connectionPool.getConnection();
            return conn;
        } catch (err) {
            console.log(err);
            return undefined;
        }
    }
}

export default DatabaseConnection
