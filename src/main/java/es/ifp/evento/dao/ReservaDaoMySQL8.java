package es.ifp.evento.dao;

import es.ifp.evento.beans.Evento;
import es.ifp.evento.beans.Reserva;
import es.ifp.evento.beans.Usuario;
import es.ifp.evento.repository.ReservaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservaDaoMySQL8 implements IntReservaMysql8JPA {
    @Autowired
    private ReservaRepository rrepo;
    @Override
    public int altaResrva(Reserva reserva) {
        int fila=0;
        try {
            rrepo.save(reserva);
        }catch (Exception e){
            e.printStackTrace();
        }
        return fila;
    }
    @Override
    public List<Reserva> findPorUsername(String username) {
        return rrepo.findPorUsername(username);
    }

    @Override
    public Reserva findByEventoAndUsuario(Evento evento, Usuario usuario) {
        return rrepo.findByEventoAndUsuario(evento,usuario);
    }

    @Override
    public int deleteReserva(int idReserva) {
        int fila=0;
        try {
            rrepo.deleteById(idReserva);
            fila=1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return fila;
    }

    @Override
    public Reserva findById(int idReserva) {
        return rrepo.findById(idReserva).orElse(null);
    }


}
