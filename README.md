# **ETransportation API Application**

This is a Rails API application that manages `ETransportation` resources. The application allows you to create, read, update, and delete `ETransportation` records. It includes validations to ensure unique combinations of `transportation_type`, `sensor_type`, and `owner_id`, and includes conditional validation for the `lost_sensor` field based on the `transportation_type`.

---

## **Table of Contents**

1. [Prerequisites](#prerequisites)
2. [Setup & Installation](#setup--installation)
3. [Running the Application](#running-the-application)
4. [Testing the Application](#testing-the-application)
5. [Postman Setup](#postman-setup)
6. [Environment Setup](#environment-setup)
7. [Functionality Overview](#functionality-overview)
8. [API Endpoints](#api-endpoints)
9. [Additional Notes](#additional-notes)
10. [Troubleshooting](#troubleshooting)

---

## **Prerequisites**

Before setting up the application, ensure you have the following installed:

- **Ruby** 3.0.0
- **Rails** 7.x
- **SQLite3** (for development and testing environments)
- **Node.js** and **Yarn** (if you're handling JavaScript in your frontend)
- **Postman** (for testing the API endpoints)

### **Installing Ruby & Rails**

If you don’t have Ruby installed, use **RVM** or **rbenv** to install version 3.0.0:

```bash
rvm install 3.0.0
rvm use 3.0.0

```

Or for rbenv:

```bash
rbenv install 3.0.0
rbenv global 3.0.0
```

Then install Rails:
 ```bash
 gem install rails -v 7.0.8
 ```

### **Install Dependencies**
Ensure you have Bundler installed: by gem install bundler and then install bundle install

### **Setup & Installation**

**1- Set Up the Database**
After installing dependencies, create and migrate the database:

```bash
rails db:create db:migrate db:seed
```
- `db:create` creates the database.
- `db:migrate` applies the necessary migrations.
- `db:seed` seeds the database with initial data (if any exists).
