package es.ifp.evento.repository;

import es.ifp.evento.beans.Evento;
import es.ifp.evento.beans.Reserva;
import es.ifp.evento.beans.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReservaRepository extends JpaRepository<Reserva,Integer> {
    @Query("SELECT r from Reserva r where r.usuario.username=?1")
    List<Reserva>findPorUsername(String username);
    Reserva findByEventoAndUsuario(Evento evento, Usuario usuario);
}
