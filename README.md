# Habitus: Notifications Microservice

## Description

This microservice provides endpoints to save notifications of pending habits, notifications of completed habits and allows the user to be notified according to the dates set and depending on whether the notifications are active/inactive.

## Endpoints
There is a Postman collection with all of enabled and function endpoints in /docs/ folder

However here is an example of endpoints and their usage

### Get a Notification

Path: /notifications_controller/get_notifications
Method: GET

Expected result: 201 (OK)

### Create a Notification

Path: /notifications_controller/add_notification
Method: POST
Body: 
```
{
    [String] not_id: "<Notification ID>"
    [DateTime] not_init_date: "<Date to get the notification>"
    [String] not_description: "<Description about the notification>"
    [Boolean] not_active: "<If user wants or not get the notification>"
}
```
Expected result: 201 (OK)

### Get Notification counts

Path: /notifications_controller/get_notifications_count
Method: GET

Expected result: 201 (OK)