# Task Manager App

This Flutter app manages tasks using a REST API. I built this project to showcase create, read, update and delete functionality.

### Technical Overview

* **State Management**: I used **Riverpod** to manage the list of tasks.
* **API Integration**: The app uses the `http` package to connect to a MockAPI backend. 
* **Navigation**: I implemented **GoRouter** to handle navigation.

### Features

* **View Tasks**: Fetches the list from the server on startup.
* **Create Task**: a form that validates input and posts data to the API.
* **Update Status**: Tapping a checkbox sends a PUT request to update the task status.
* **Delete**: Swiping a task removes it from the list and sends a DELETE request.

### Preview
<img width="400" height="400" alt="Untitled design-2" src="https://github.com/user-attachments/assets/754c4aba-83e7-455b-8063-dcee7d0bf0d1" />
