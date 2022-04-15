package es.ifp.evento.dao;

import es.ifp.evento.beans.Evento;
import es.ifp.evento.beans.Reserva;
import es.ifp.evento.beans.Usuario;

import java.util.List;

public interface IntReservaMysql8JPA {
    int altaResrva (Reserva reserva);
    List<Reserva> findPorUsername(String username);
    Reserva findByEventoAndUsuario(Evento evento, Usuario usuario);
    int deleteReserva(int idReserva);
    Reserva findById(int idReserva);
}
