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

const notificationsBtn = document.querySelector('.social_media ion-icon[name="notifications-outline"]');
notificationsBtn.addEventListener('click', () => {
const notificationsPopup = document.createElement('div');
notificationsPopup.innerHTML = `
    <h3>Notificaciones:</h3>
    <ul>
    <li>Tienes 3 nuevas notificaciones</li>
    <li>Se ha creado un nuevo usuario</li>
    <li>El sistema ha detectado un error</li>
    </ul>
    <button>Ver todas las notificaciones</button>
`;
notificationsPopup.style.position = 'absolute';
notificationsPopup.style.top = '50px';
notificationsPopup.style.right = '20px';
notificationsPopup.style.background = '#fff';
notificationsPopup.style.border = '1px solid #000';
notificationsPopup.style.padding = '10px';
notificationsPopup.style.display = 'none';
notificationsPopup.style.maxHeight = '300px';
notificationsPopup.style.overflowY = 'scroll';
document.body.appendChild(notificationsPopup);
notificationsPopup.style.display = 'block';
});


/* SCRIPT Cliente */