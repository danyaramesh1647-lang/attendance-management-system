# ☁️ AttendCloud – Cloud-Based Attendance Management System

A cloud-based attendance management system built using **HTML, CSS, JavaScript, and Supabase**. The system provides separate interfaces for faculty and students to manage, record, and view attendance information.

## 🌐 Live Demo

👉 [Open AttendCloud](https://danyaramesh1647-lang.github.io/attendance-management-system/)

---

## 📌 Project Overview

AttendCloud is a web-based attendance management system designed to simplify the process of recording and monitoring student attendance.

Faculty members can manage students, mark attendance, and view attendance reports, while students can log in to view their attendance details.

The system uses **Supabase** as the cloud backend for authentication and database management.

---

## ✨ Features

### 👨‍🏫 Faculty / Admin

- 🔐 Secure login authentication
- 👥 View student records
- ✅ Mark student attendance
- 📊 View attendance reports
- 👤 View faculty profile
- ☁️ Store attendance data in the cloud

### 🎓 Student

- 🔐 Student login
- 👤 View personal profile
- 📅 View attendance records
- 📊 View attendance percentage
- ☁️ Access attendance data from the cloud

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| HTML5 | Web page structure |
| CSS3 | Styling and responsive interface |
| JavaScript | Application logic and interaction |
| Supabase | Cloud database and authentication |
| Git | Version control |
| GitHub | Source code hosting |
| GitHub Pages | Website deployment |

---

## ☁️ Cloud Technology

The application uses **Supabase** as its cloud backend.

Supabase provides:

- 🔐 User authentication
- 🗄️ PostgreSQL database
- 🔒 Row Level Security (RLS)
- ☁️ Cloud-based data storage
- 🔄 Real-time access to application data

The frontend communicates with Supabase using its JavaScript client.

---

## 🏗️ Project Structure

```text
cloud-attendance-management-system/
│
├── css/
│   └── style.css
│
├── js/
│   ├── supabase.js
│   ├── login.js
│   ├── dashboard.js
│   ├── students.js
│   ├── attendance.js
│   ├── reports.js
│   └── profile.js
│
├── supabase/
│   └── schema.sql
│
├── index.html
├── login.html
├── dashboard.html
├── students.html
├── attendance.html
├── reports.html
├── profile.html
├── package.json
├── .env.example
└── README.md
👥 User Roles
Faculty / Admin

Faculty users can:

Log in to the system
View the dashboard
View students
Mark attendance
View attendance reports
View their profile
Student

Student users can:

Log in to the system
View their dashboard
View their attendance information
View their profile
🔄 System Workflow
User
  ↓
Login
  ↓
Supabase Authentication
  ↓
Role Verification
  ↓
┌─────────────────┬─────────────────┐
│                 │                 │
Faculty          Student
│                 │
↓                 ↓
Dashboard        Dashboard
│                 │
├── Students      ├── Attendance
├── Attendance    └── Profile
├── Reports
└── Profile
📊 Attendance Management

Faculty can mark attendance for students and save the attendance information to the Supabase cloud database.

The reports section allows attendance records to be viewed based on the stored data.

Students can view their attendance status and attendance percentage through their dashboard.

🔐 Authentication

The application uses Supabase Authentication for user login.

Each user is associated with a profile and role such as:

admin
student

The user's role determines which features are available after login.

🗄️ Database

The project uses a PostgreSQL database provided by Supabase.

Main database entities include:

Profiles – stores user information and roles
Students – stores student details
Attendance – stores attendance records
🚀 Deployment

The application is deployed using GitHub Pages.

Deployment Platform

GitHub Pages

Repository

attendance-management-system

Live Website

https://danyaramesh1647-lang.github.io/attendance-management-system/

💻 Running the Project Locally
1. Clone the repository
git clone https://github.com/danyaramesh1647-lang/attendance-management-system.git
2. Open the project folder
cd attendance-management-system
3. Install dependencies
npm install
4. Start the local server
npm start

The application can then be accessed through the local server URL shown in the terminal.

⚙️ Supabase Configuration

The application requires a Supabase project for authentication and database functionality.

The Supabase configuration is stored in:

js/supabase.js

The project uses the Supabase project URL and a client-side anon/publishable key.

⚠️ Never expose a Supabase service_role or secret key in frontend code.

🎯 Project Objectives
Reduce manual attendance management
Provide centralized cloud-based attendance storage
Allow faculty to efficiently record attendance
Allow students to monitor their attendance
Provide attendance reports
Demonstrate the use of cloud technologies in a web application
📈 Future Enhancements

Possible future improvements include:

📧 Email notifications for low attendance
📱 Improved mobile responsiveness
📊 Advanced attendance analytics
📥 Export attendance reports
🔔 Attendance alerts
👨‍💼 Multiple faculty accounts
📅 Date-wise and subject-wise attendance filtering
👩‍💻 Developed By

Danya R

Computer Science and Engineering

📄 License

This project is developed for educational and academic purposes.

⭐ If you find this project useful, consider giving the repository a star!


### Then

On GitHub's **Edit README** page:

**Ctrl + A → paste the entire thing → Commit changes.**

And that's it. Your README will look like an actual project README rather than just a basic file. 😭🔥