<?php

    include 'conexion_db.php';

    $nombre = $_POST["nombres"];
    $apellido = $_POST["apellidos"];
    $identificacion = $_POST["identificacion"];
    $direccion = $_POST["direccion"];
    $telefono = $_POST["telefono"];
    $correo = $_POST["correo"];
    $contrasena = $_POST["contrasena"];

    $infousuarios1 = "INSERT INTO users(users_email, users_password)
        VALUES('$correo', '$contrasena')";
    $infousuarios2 = "INSERT INTO user_info(user_first_name, user_last_name, user_cedula, user_phone, user_address)
        VALUES('$nombre', '$apellido', '$identificacion', '$telefono', '$direccion')";

    $ejecutar1 = mysqli_query($conexion, $infousuarios1);
    $ejecutar2 = mysqli_query($conexion, $infousuarios2);

    if ($ejecutar1 && $ejecutar2) {
        echo "Los datos se insertaron correctamente en ambas tablas.";
    } else {
        echo "Ocurrió un error al insertar los datos en las tablas.";
    }
