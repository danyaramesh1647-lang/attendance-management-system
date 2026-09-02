const client=window.supabaseClient;
(async()=>{const {data}=await client.auth.getSession();if(data.session)location.href="dashboard.html";})();
document.getElementById("loginForm").addEventListener("submit",async e=>{e.preventDefault();const btn=document.getElementById("loginBtn"),msg=document.getElementById("message");btn.disabled=true;btn.textContent="Signing in...";
const {error}=await client.auth.signInWithPassword({email:document.getElementById("email").value.trim(),password:document.getElementById("password").value});
if(error){msg.textContent=error.message;msg.className="message";btn.disabled=false;btn.textContent="Sign in";return}location.href="dashboard.html";});