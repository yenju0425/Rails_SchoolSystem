# README

In this project, you will learn about:

1. Creating API endpoints for external access to the database via the HTTP protocol.
2. Familiarizing yourself with Rails' MVC architecture.
3. Practicing unit testing using RSpec.

This project is a simulated school system where you can add and delete students and teachers through the API. Additionally, teachers can track students' progress. For detailed API documentation, please refer to the section below.

In this project, there are 7 available endpoints:

1. **POST /students**
   - This endpoint is used to create a new student. The request body should be in the following format:
     ```json
     {
         "student": {
             "name": "Doge"
         }
     }
     ```

2. **DELETE /students/:id**
   - This endpoint is used to delete a student by ID.

3. **POST /teachers**
   - This endpoint is used to create a new teacher. The request body should be in the following format:
     ```json
     {
         "teacher": {
             "name": "Doge"
         }
     }
     ```

4. **DELETE /teachers/:id**
   - This endpoint is used to delete a teacher by ID.

5. **POST /teachers/follow**
   - This endpoint is used to let a teacher follow a list of students. The request body should be in the following format:
     ```json
     {
         "teacher_id": 1,
         "student_ids": [1, 2]
     }
     ```

6. **POST /teachers/unfollow**
   - This endpoint is used to let a teacher unfollow a list of students. The request body should be in the following format:
     ```json
     {
         "teacher_id": 1,
         "student_ids": [1, 2]
     }
     ```

7. **GET /teachers/:id/students**
   - This endpoint is used to get a list of students followed by a teacher.
