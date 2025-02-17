# Inventory Management System API Documentation

## Authentication Endpoints

### Login
- **URL**: `/api/login`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**: Returns user data and authentication token

### Register
- **URL**: `/api/register`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "name": "string",
    "email": "string",
    "password": "string",
    "password_confirmation": "string",
    "role": "admin|manager|warehouse|staff"
  }
  ```
- **Response**: Returns created user data and authentication token

## Product Management

### List Products
- **URL**: `/api/products`
- **Method**: `GET`
- **Query Parameters**:
  - `search`: Search by name or SKU
  - `category`: Filter by category
  - `is_active`: Filter by status
  - `per_page`: Items per page
- **Access**: All authenticated users

### Create Product
- **URL**: `/api/products`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "sku": "string",
    "name": "string",
    "description": "string|null",
    "category": "string",
    "minimum_stock": "number",
    "unit": "string",
    "current_stock": "number",
    "is_active": "boolean"
  }
  ```
- **Access**: Admin, Manager

### Get Low Stock Products
- **URL**: `/api/products/low-stock`
- **Method**: `GET`
- **Access**: All authenticated users

## Stock Transactions

### List Transactions
- **URL**: `/api/stock-transactions`
- **Method**: `GET`
- **Query Parameters**:
  - `product_id`: Filter by product
  - `transaction_type`: Filter by type (in/out)
  - `date_from`: Start date
  - `date_to`: End date
  - `per_page`: Items per page
- **Access**: All authenticated users

### Create Transaction
- **URL**: `/api/stock-transactions`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "product_id": "number",
    "transaction_type": "in|out",
    "quantity": "number",
    "unit_price": "number",
    "reference_number": "string",
    "notes": "string|null"
  }
  ```
- **Access**: Admin, Manager, Warehouse

## Stock Opname (Audit)

### List Stock Opname
- **URL**: `/api/stock-opname`
- **Method**: `GET`
- **Query Parameters**:
  - `status`: Filter by status (draft/approved)
  - `date_from`: Start date
  - `date_to`: End date
  - `per_page`: Items per page
- **Access**: All authenticated users

### Create Stock Opname
- **URL**: `/api/stock-opname`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "product_id": "number",
    "physical_stock": "number",
    "notes": "string|null"
  }
  ```
- **Access**: Warehouse, Manager, Admin

### Approve Stock Opname
- **URL**: `/api/stock-opname/{id}/approve`
- **Method**: `POST`
- **Access**: Manager, Admin

## Stock Adjustments

### List Adjustments
- **URL**: `/api/stock-adjustments`
- **Method**: `GET`
- **Query Parameters**:
  - `product_id`: Filter by product
  - `adjustment_type`: Filter by type (addition/reduction)
  - `date_from`: Start date
  - `date_to`: End date
  - `per_page`: Items per page
- **Access**: All authenticated users

### Create Adjustment
- **URL**: `/api/stock-adjustments`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "product_id": "number",
    "adjustment_type": "addition|reduction",
    "quantity": "number",
    "reason": "string",
    "notes": "string|null"
  }
  ```
- **Access**: Warehouse, Manager, Admin

### Approve Adjustment
- **URL**: `/api/stock-adjustments/{id}/approve`
- **Method**: `POST`
- **Access**: Manager, Admin

## Vendor Management

### List Vendors
- **URL**: `/api/vendors`
- **Method**: `GET`
- **Query Parameters**:
  - `search`: Search by name, email, or phone
  - `is_active`: Filter by status
  - `per_page`: Items per page
- **Access**: All authenticated users

### Create Vendor
- **URL**: `/api/vendors`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "name": "string",
    "email": "string",
    "phone": "string|null",
    "address": "string|null",
    "contact_person": "string|null",
    "notes": "string|null",
    "is_active": "boolean"
  }
  ```
- **Access**: Admin, Manager

## Reports

### Stock Transaction Report
- **URL**: `/api/stock-transactions/report`
- **Method**: `GET`
- **Query Parameters**:
  - `date_from`: Start date
  - `date_to`: End date
- **Access**: Manager, Admin

### Stock Opname Report
- **URL**: `/api/stock-opname/report`
- **Method**: `GET`
- **Query Parameters**:
  - `date_from`: Start date
  - `date_to`: End date
- **Access**: Manager, Admin

### Stock Adjustment Report
- **URL**: `/api/stock-adjustments/report`
- **Method**: `GET`
- **Query Parameters**:
  - `date_from`: Start date
  - `date_to`: End date
- **Access**: Manager, Admin

## Authentication

All API endpoints except login and register require authentication. Include the authentication token in the request header:

```
Authorization: Bearer <token>
```

## Role-Based Access Control

The system implements role-based access control with the following roles:
- **Admin**: Full access to all features
- **Manager**: Can approve stock opname and adjustments, view reports
- **Warehouse**: Can create stock transactions, opname, and adjustments
- **Staff**: Can view data and create basic transactions

## Error Responses

The API returns standard HTTP status codes:
- `200`: Success
- `201`: Created
- `204`: No Content
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `422`: Validation Error
- `500`: Server Error

Error responses include a message describing the error:
```json
{
  "message": "Error description"
}
```

For validation errors:
```json
{
  "message": "The given data was invalid.",
  "errors": {
    "field": [
      "Error message"
    ]
  }
}
```
Great! Yes, all the API endpoints are now working correctly. Here's a summary of what we've accomplished:

Authentication System
Login endpoint: /api/auth/login
Register endpoint: /api/auth/register (admin only)
User roles: admin, manager, warehouse, staff
Protected Routes
All routes are protected with Sanctum authentication
Role-based middleware for specific endpoints
Proper CORS configuration for frontend access
Database Structure
All tables have proper foreign key constraints
Soft deletes implemented across all models
Added missing vendor_id to stock transactions
Available Endpoints
CopyInsert
# Auth
POST /api/auth/login
POST /api/auth/register (admin)
POST /api/auth/logout
GET  /api/auth/user

# Products
GET    /api/products
POST   /api/products (admin/manager)
GET    /api/products/{id}
PUT    /api/products/{id} (admin/manager)
DELETE /api/products/{id} (admin/manager)
GET    /api/products/low-stock
GET    /api/products/{id}/stock-movement

# Vendors
GET    /api/vendors
POST   /api/vendors (admin/manager)
GET    /api/vendors/{id}
PUT    /api/vendors/{id} (admin/manager)
DELETE /api/vendors/{id} (admin/manager)
GET    /api/vendors/{id}/transactions

# Stock Management
GET  /api/stock-transactions
GET  /api/stock-transactions/{id}
POST /api/stock-adjustments (admin/manager)
POST /api/stock-opname (admin/manager)
You can now proceed with building your frontend application. Remember to:

Include the authentication token in requests: Authorization: Bearer <token>
Set the proper headers: Accept: application/json and Content-Type: application/json
Handle role-based access control on the frontend