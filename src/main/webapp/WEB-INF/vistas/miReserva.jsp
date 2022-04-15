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
            <a class="navbar-brand" href="/index">Eventos</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/index">Incio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/destacado">Eventos Destacados</a>
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
    <div class="container"
         style="align-content: center; justify-content: center; padding: 3vh 10em;">
        <div class="row">
            <div class="col">
                <h1>Mis Reservas</h1>
                <h1>${mensaje }</h1>
            </div>
        </div>

    </div>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">NOMRBE EVENTO</th>
            <th scope="col">FECHA INICIO</th>
            <th scope="col">PRECIO/UNIDAD</th>
            <th scope="col">CANTIDAD</th>
            <th scope="col">BORRAR</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="liReserv" items="${liReserv }">
            <tr>
                <th scope="row">${liReserv.idReserva }</th>
                <td>${liReserv.evento.nombre }</td>
                <td>${liReserv.evento.fechaInicio }</td>
                <td>${liReserv.evento.precio } Euros/Unidad</td>
                <td>${liReserv.cantidad }</td>
                <td><a class="btn btn-outline-warning" href="/cliente/reserva/cancelar/${liReserv.idReserva }">Cancelar</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>