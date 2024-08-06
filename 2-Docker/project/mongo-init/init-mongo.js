// Retrieve environment variables for MongoDB configuration
const dbName = process.env.MONGO_DATABASE;
const adminUser = process.env.MONGO_USER;
const adminPassword = process.env.MONGO_PASSWORD;

// Ensure all necessary environment variables are set
if (!dbName || !adminUser || !adminPassword) {
  throw new Error("Required environment variables (MONGO_DATABASE, MONGO_USER, MONGO_PASSWORD) are missing");
}

// Use the admin database to create the admin user
const adminDb = db.getSiblingDB('admin');

// Create the admin user if not already created
const adminUserExists = adminDb.getUser(adminUser);
if (!adminUserExists) {
  adminDb.createUser({
    user: adminUser,
    pwd: adminPassword,
    roles: [
      {
        role: 'root',
        db: 'admin'
      }
    ]
  });
  print(`Admin user "${adminUser}" created with root access`);
} else {
  print(`Admin user "${adminUser}" already exists`);
}

// Use the specified database
const db = db.getSiblingDB(dbName);

// Optionally: Create other necessary configurations for the database if needed

print(`Database "${dbName}" is ready`);
