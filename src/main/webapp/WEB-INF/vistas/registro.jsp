<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Eventos</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/">Incio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/destacado">Eventons Destacados</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/estado">Eventos Activos</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Tipos de eventos
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <c:forEach var="listaTipo" items="${listTipo }">
                                <li><a class="dropdown-item" href="/tipo/${listaTipo.idTipo }">${listaTipo.nombre }</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                    <sec:authorize access="hasAnyAuthority('CLIENTE','ADMINISTRADOR','GESOR')">
                        <li class="nav-item">
                            <a class="nav-link">Mis Reserva</a>
                        </li>
                    </sec:authorize>
                </ul>
                <form class="d-flex">
                    <sec:authorize access="!isAuthenticated()">
                        <a class="btn btn-outline-success" href="/login">Login</a>
                        <a class="btn btn-outline-success" href="/registro">Registrarse</a>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <a class="btn btn-outline-success" href="/logout">Cerrar Sesion</a>
                    </sec:authorize>
                </form>
            </div>
        </div>
    </nav>
</header>
<main>
    <div class="container" style="justify-content: center; align-content: center; padding: 5vh 10em; border: solid 1px; border-radius: 10px; margin-top: 5vh">
        <h1>Registro</h1>
        <form action="/registro/usuario" method="post">
            <h4>Correo Electronico:</h4>
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="floatingInput" name="username" placeholder="name@example.com">
                <label for="floatingInput"><h5>Inroduce tu correo electronico</h5></label>
            </div>
            <h4>Contraseña:</h4>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password">
                <label for="floatingPassword"><h5>Inroduce tu contraseña</h5></label>
            </div>
            <h4>Nombre:</h4>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingName" name="nombre" placeholder="Password">
                <label for="floatingName"><h5>Inroduce tu nombre</h5></label>
            </div>
            <h4>Apellidos:</h4>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingLastName" name="apellidos" placeholder="Password">
                <label for="floatingLastName"><h5>Inroduce tus apellidos</h5></label>
            </div>
            <h4>Direccion:</h4>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingAddress" name="direccion" placeholder="Password">
                <label for="floatingAddress"><h5>Inroduce tu direccion</h5></label>
            </div>
            <div class="container">
                <input type="submit" class="btn btn-outline-success" value="enviar" name="" id="boton">
            </div>
        </form>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>