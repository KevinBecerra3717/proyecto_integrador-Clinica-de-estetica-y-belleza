<?php

    include 'conexion_db.php';

    $nombre = $_POST["nombres"];
    $apellido = $_POST["apellidos"];
    $identificacion = $_POST["identificacion"];
    $direccion = $_POST["direccion"];
    $telefono = $_POST["telefono"];
    $correo = $_POST["correo"];
    $contrasena = $_POST["contrasena"];
    $rectcontrasena = $_POST["rectcontrasena"];

    if($contrasena !== $rectcontrasena) {
        echo '
            <script>
                alert("Las contraseñas no coinciden, inténtelo de nuevo");
                window.location = "../views/registro.html";
            </script>
        ';
        exit;
    }

    $infousuarios1 = "INSERT INTO usuarios(us_nombre, us_apellido, us_documento, us_direccion, us_telefono, us_correo, us_password)
        VALUES('$nombre', '$apellido', '$identificacion', '$direccion', '$telefono', '$correo', '$contrasena')";

    $ejecutar1 = mysqli_query($conexion, $infousuarios1);

    if ($ejecutar1) {
        echo '
            <script>
                alert("Usuario almacenado exitosamente");
                window.location = "../views/Login.html";
            </script>
        ';
    } else {
        echo '
            <script>
                alert("Inténtalo de nuevo, usuario no almacenado");
                window.location = "../views/Login.html";
            </script>
        ';
    }
?>
