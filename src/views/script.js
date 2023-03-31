/* SCRIPT ADMINISTRADOR  */

   
const userBtn = document.getElementById("user-btn");
const userPopup = document.getElementById("user-popup");

userBtn.addEventListener("click", function() {
// Llena la ventana emergente con el nombre del usuario y un botón de logout
const userName = "Admin. Miguel"; // Reemplaza con el nombre del usuario
userPopup.innerHTML = `
    <p>${userName}</p>
    <button id="logout-btn">Logout</button>
`;

// Agrega un event listener al botón de logout
const logoutBtn = document.getElementById("logout-btn");
logoutBtn.addEventListener("click", function() {
    window.location.href = "Index.html"
});

// Muestra la ventana emergente
userPopup.style.display = "block";
});