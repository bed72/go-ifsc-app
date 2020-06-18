const String DATABASE_NAME = "go.db";
const String TABLE_NOTIFICATION = "notification";
const String TABLE_USER = "user";

const String CREATE_USER_TABLE_SCRIPT =
    "CREATE TABLE user(id INTEGER PRIMARY KEY,name TEXT, email TEXT, phone TEXT,image TEXT, addressLine1 TEXT, addressLine2 TEXT, latLng TEXT)";
