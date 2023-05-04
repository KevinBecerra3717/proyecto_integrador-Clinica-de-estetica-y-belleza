<?php

    include "conexion_db.php";

    $nombre = $_POST["nombres"];
    $apellido = $_POST["apellidos"];
    $identificacion = $_POST["identificacion"];
    $direccion = $_POST["direccion"];
    $telefono = $_POST["telefono"];
    $correo = $_POST["correo"];
    $contrasena = $_POST["contrasena"];
    $rectcontrasena = $_POST["rectcontrasena"];
    $usuario = $nombre . ' ' . $apellido;

    if($contrasena!=$rectcontrasena){
        echo '
            <div class="notification is-danger is-light">
                <strong>¡Ocurrio un error inesperado!</strong><br>
                Las CLAVES que ha ingresado no coinciden
            </div>
        ';
        exit();
    }else{
        $clave=password_hash($clave_1,PASSWORD_BCRYPT,["cost"=>10]);
    }


    $infousuarios1 = "INSERT INTO usuarios(us_usuario, us_documento, us_direccion, us_telefono, us_correo, us_password, us_nombre, us_apellido, us_activo)
            VALUES('$usuario', '$identificacion', '$direccion', '$telefono', '$correo', '$clave', '$nombre', '$apellido', '5')";

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
                window.location = "../views/Crear-cuenta.html";
            </script>
        ';
    }
?>
