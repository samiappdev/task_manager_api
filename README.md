# Task Manager App

This is Flutter app manages tasks using a REST API. I built this project to showcase create, read, update and delete functionality.

### Technical Overview

* **State Management**: I used **Riverpod** to manage the list of tasks.
* **API Integration**: The app uses the `http` package to connect to a MockAPI backend. 
* **Navigation**: I implemented **GoRouter** to handle navigation.

### Features

* **View Tasks**: Fetches the list from the server on startup.
* **Create Task**: a form that validates input and posts data to the API.
* **Update Status**: Tapping a checkbox sends a PUT request to update the task status.
* **Delete**: Swiping a task removes it from the list and sends a DELETE request.
