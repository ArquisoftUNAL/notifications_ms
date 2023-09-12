# Habitus: Reminders Microservice

## Description

This microservice provides endpoints to save reminders of pending habits, reminders of completed habits and allows the user to be notified according to the dates set and depending on whether the reminders are active/inactive.

## Endpoints
There is a Postman collection with all of enabled and function endpoints in /docs/ folder

However here is an example of endpoints and their usage

### Get a reminder

Path: /reminders_controller/get_reminders
Method: GET

Expected result: 201 (OK)

### Create a reminder

Path: /reminders_controller/add_reminder
Method: POST
Body: 
```
{
    [String] rem_id: "<Reminder ID>"
    [DateTime] rem_init_date: "<Date to get the reminder>"
    [String] rem_description: "<Description about the reminder>"
    [Boolean] rem_active: "<If user wants or not get the reminder>"
}
```
Expected result: 201 (OK)

### Get reminder counts

Path: /reminders_controller/get_reminders_count
Method: GET

Expected result: 201 (OK)