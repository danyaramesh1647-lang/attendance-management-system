
// Supabase configuration

window.SUPABASE_URL = "https://qaibdtsxhkzluzuhpjdm.supabase.co";

window.SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFhaWJkdHN4aGt6bHV6dWhwamRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODgzNTIwNjcsImV4cCI6MjEwMzkyODA2N30.QzqX7TJPhvyPxo4v6CtUAwcreUmUikD1OPTE-FHHLQ0";

window.supabaseClient = window.supabase.createClient(
    window.SUPABASE_URL,
    window.SUPABASE_ANON_KEY
);