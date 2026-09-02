# Cloud-Based Attendance Management System using Supabase

## Project structure
- `index.html` - landing/login page
- `login.html` - dedicated login page
- `dashboard.html` - role-based dashboard
- `students.html` - faculty student management
- `attendance.html` - faculty attendance marking
- `reports.html` - attendance history/reports
- `profile.html` - account profile
- `css/style.css` - shared styling
- `js/supabase.js` - Supabase client configuration
- `js/auth.js` - authentication
- `js/dashboard.js` - dashboard logic
- `js/students.js` - student management
- `js/attendance.js` - attendance marking
- `js/reports.js` - reports/history
- `js/profile.js` - profile page
- `supabase/schema.sql` - complete database, trigger and RLS setup

## Supabase setup
1. Create a Supabase project.
2. Open SQL Editor.
3. Paste/run the complete `supabase/schema.sql`.
4. Go to Project Settings -> API.
5. Copy the Project URL and public anon/publishable key.
6. Put them in `js/supabase.js`.
7. In Authentication -> Users, create a faculty account.
8. Make the faculty account admin:
   `update public.profiles set role = 'admin' where email = 'faculty@example.com';`
9. Create student rows with the students page. If a student Auth account uses the same email as a student row, the trigger links the profile automatically.

## Run
Use VS Code Live Server, or:
`python -m http.server 5500`
Then open `http://localhost:5500`.

## Security
Only the public anon/publishable key belongs in frontend code. Never put the Supabase service_role/secret key in the browser.

## Note
The included seed students use example.edu addresses. They are database test records only; no Auth accounts are created for them.
