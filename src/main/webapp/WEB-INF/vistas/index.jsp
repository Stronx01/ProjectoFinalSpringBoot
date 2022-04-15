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
                                    <a class="nav-link" href="/cliente/miReserva">Mis Reservas</a>
                                </li>
                            </sec:authorize>
                        </ul>
                        <form class="d-flex">
                            <sec:authorize access="!isAuthenticated()">
                                    <a class="btn btn-outline-success" href="/login">Login</a>
                                    <a class="btn btn-outline-success" href="/registro">Registrarse</a>
                            </sec:authorize>
                            <sec:authorize access="isAuthenticated()">
                                <h5>${usuNombre }</h5>
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
                        <h1>Eventos ${evento }</h1>
                    </div>
                    <div class="col">
                        <sec:authorize access="!isAuthenticated()">
                            <h1>Bienvenido</h1>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated()">
                            <h1> Bienvenido ${usuNombre }</h1>
                            <h2>${mensaje }</h2>
                        </sec:authorize>
                    </div>
                </div>

            </div>
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">NOMRBE</th>
                    <th scope="col">AFORO</th>
                    <th scope="col">FECHA INICIO</th>
                    <th scope="col">OPCIONES</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="listaEventos" items="${liEventos }">
                <tr>
                    <th scope="row">${listaEventos.idEvento }</th>
                    <td>${listaEventos.nombre }</td>
                    <td>${listaEventos.aforoMaximo }</td>
                    <td>${listaEventos.fechaInicio }</td>
                    <td>
                        <div class="btn-group dropstart">
                            <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                Detalle
                            </button>
                            <div class="dropdown-menu p-5 " style="width: 700px">
                               <div class="row text-center" style="border-bottom: solid 1px">
                                   <h3>Detalle del evento Selecionado</h3>
                               </div>
                                <div class="row">
                                    <div class="col" style="border-right: solid 1px; padding: 10px">
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Nombre: ${listaEventos.nombre }</h5>
                                        </div>
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Descripcion: ${listaEventos.descripcion }</h5>
                                        </div>
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Direccion: ${listaEventos.direccion }</h5>
                                        </div>
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Fecha Incio: ${listaEventos.fechaInicio }</h5>
                                        </div>
                                        <div class="row"style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Duracion: ${listaEventos.duracion } horas</h5>
                                        </div>
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Aforo Maximo: ${listaEventos.aforoMaximo }</h5>
                                        </div>
                                        <div class="row" style="border-bottom: solid 1px; margin: 5px">
                                            <h5>Minimo Asistencia: ${listaEventos.minimoAsistencia }</h5>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <h5>Plazas disponibles: ${listaEventos.aforoMaximo }</h5>
                                        <h5>Plazas precio: ${listaEventos.precio } Euros</h5>
                                        <h5>Cantidad a reservar</h5>
                                        <form action="/cliente/reserva/${listaEventos.idEvento }" method="POST">
                                            <select class="form-select" aria-label="Default select example" name="cantidad">
                                                <option selected>Selecionar</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                            <sec:authorize access="!isAuthenticated()">
                                                <a class="btn btn-outline-success" href="/login">Reservar</a>
                                            </sec:authorize>
                                            <sec:authorize access="isAuthenticated()">
                                                <input type="submit" class="btn btn-outline-success" value="Reservar" name="" id="boton">
                                            </sec:authorize>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>